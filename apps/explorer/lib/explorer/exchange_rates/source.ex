defmodule Explorer.ExchangeRates.Source do
  @moduledoc """
  Behaviour for fetching exchange rates from external sources.
  """
  require Logger

  alias Explorer.ExchangeRates.{Source, Token}
  alias HTTPoison.{Error, Response}

  @doc """
  Fetches exchange rates for currencies/tokens.
  Return type: {:ok, [Token.t()]} | {:error, any}
  """
  def fetch_exchange_rates(source) when not is_list(source) do
    source_url = source.source_url()
    fetch_exchange_rates_request(source, source_url)
  end

  def fetch_exchange_rates([]), do: {:error, "No source available"}

  def fetch_exchange_rates([source | remaining_sources]) do
    with {:ok, rate} <- fetch_exchange_rates(source) do
      {:ok, rate}
    else
      {:error, _} -> fetch_exchange_rates(remaining_sources)
    end
  end

  def fetch_exchange_rates() do
    all_sources = [exchange_rates_source1(), exchange_rates_source2(), exchange_rates_source3()]
    fetch_exchange_rates(all_sources)
  end

  @spec fetch_exchange_rates_for_token(String.t()) :: {:ok, [Token.t()]} | {:error, any}
  def fetch_exchange_rates_for_token(symbol) do
    source_url = Source.CoinGecko.source_url(symbol)
    Logger.info(fn -> "24. #{inspect(source_url)}" end)
    fetch_exchange_rates_request(Source.CoinGecko, source_url)
  end

  @spec fetch_exchange_rates_for_token_address(String.t()) :: {:ok, [Token.t()]} | {:error, any}
  def fetch_exchange_rates_for_token_address(address_hash) do
    source_url = Source.CoinGecko.source_url(address_hash)
    Logger.info(fn -> "31. #{inspect(source_url)}" end)
    fetch_exchange_rates_request(Source.CoinGecko, source_url)
  end

  defp fetch_exchange_rates_request(_source, source_url) when is_nil(source_url), do: {:error, "Source URL is nil"}

  defp fetch_exchange_rates_request(source, source_url) do
    Logger.info("Trying to get exchange rate from #{inspect(source_url)}")
    rate =
      case http_request(source_url, source.headers()) do
        {:ok, result} = resp ->
          if is_map(result) do
            result_formatted =
              result
              |> source.format_data()

            {:ok, result_formatted}
          else
            resp
          end

        resp ->
          resp
      end
    Logger.info("Got exchange rate #{inspect(rate)}")
    rate
  end

  @doc """
  Callback for api's to format the data returned by their query.
  """
  @callback format_data(String.t()) :: [any]

  @doc """
  Url for the api to query to get the market info.
  """
  @callback source_url :: String.t()

  @callback source_url(String.t()) :: String.t() | :ignore

  @callback headers :: [any]

  def headers do
    [{"Content-Type", "application/json"}]
  end

  def decode_json(data) do
    Jason.decode!(data)
  rescue
    _ -> data
  end

  def to_decimal(nil), do: nil

  def to_decimal(%Decimal{} = value), do: value

  def to_decimal(value) when is_float(value) do
    Decimal.from_float(value)
  end

  def to_decimal(value) when is_integer(value) or is_binary(value) do
    Decimal.new(value)
  end

  defp exchange_rates_source1 do
    config(:source) || Explorer.ExchangeRates.Source.EthPlorer
  end

  defp exchange_rates_source2 do
    config(:source) || Explorer.ExchangeRates.Source.CoinMarketCap
  end

  defp exchange_rates_source3 do
    config(:source) || Explorer.ExchangeRates.Source.CoinGecko
  end

  @spec config(atom()) :: term
  defp config(key) do
    Application.get_env(:explorer, __MODULE__, [])[key]
  end

  def http_request(source_url) do
    http_request(source_url, headers())
  end

  def http_request(source_url, input_header) do
    case HTTPoison.get(source_url, input_header) do
      {:ok, %Response{body: body, status_code: 200}} ->
        parse_http_success_response(body)

      {:ok, %Response{body: body, status_code: status_code}} when status_code in 400..526 ->
        parse_http_error_response(body)

      {:ok, %Response{status_code: status_code}} when status_code in 300..308 ->
        {:error, "Source redirected"}

      {:ok, %Response{status_code: _status_code}} ->
        {:error, "Source unexpected status code"}

      {:error, %Error{reason: reason}} ->
        {:error, reason}

      {:error, :nxdomain} ->
        {:error, "Source is not responsive"}

      {:error, _} ->
        {:error, "Source unknown response"}
    end
  end

  defp parse_http_success_response(body) do
    body_json = decode_json(body)

    cond do
      is_map(body_json) ->
        {:ok, body_json}

      is_list(body_json) ->
        {:ok, body_json}

      true ->
        {:ok, body}
    end
  end

  defp parse_http_error_response(body) do
    body_json = decode_json(body)

    if is_map(body_json) do
      {:error, body_json["error"]}
    else
      {:error, body}
    end
  end
end
