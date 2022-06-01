defmodule Explorer.ExchangeRates.Source do
  @moduledoc """
  Behaviour for fetching exchange rates from external sources.
  """
  require Logger

  import EthereumJSONRPC.Utilities, only: [print: 2]

  alias Explorer.ExchangeRates.{Source, Token}
  alias HTTPoison.{Error, Response}

  @doc """
  Fetches exchange rates for currencies/tokens.
  """
  @spec fetch_exchange_rates(module) :: {:ok, [Token.t()]} | {:error, any}
  def fetch_exchange_rates(source \\ exchange_rates_source()) do
    source_url = source.source_url()
    # fetch_exchange_rates_request(source, "https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest?symbol=LA")
    fetch_exchange_rates_request(source, source_url)
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
    Logger.info("Trying to get exchange rate from #{source_url}")
    case http_request(source_url) do
      {:ok, result} = resp ->
        if is_map(result) do
          print(result, "printing result for exchange rate")
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

  def headers do
    [{"Content-Type", "application/json"}]
    # [
    #   {"Content-Type", "application/json"},
    #   # {"X-CMC_PRO_API_KEY", "8365e154-5a44-49ae-847f-6cd1c93cb8e7"}
    #   {"X-CMC_PRO_API_KEY", "33b186b6-53a4-4d91-9fe1-40c9149da8fb"}
    # ]
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

  @spec exchange_rates_source() :: module()
  defp exchange_rates_source do
    config(:source) || Explorer.ExchangeRates.Source.EthPlorer
  end

  @spec config(atom()) :: term
  defp config(key) do
    Application.get_env(:explorer, __MODULE__, [])[key]
  end

  def http_request(source_url) do
    case HTTPoison.get(source_url, headers()) do
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
