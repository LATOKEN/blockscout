defmodule Explorer.ExchangeRates.Source.CoinMarketCap do
  @moduledoc """
  Adapter for fetching exchange rates from https://coinmarketcap.com/
  """

  alias Explorer.ExchangeRates.{Source, Token}

  require Logger

  import Source, only: [to_decimal: 1]

  @behaviour Source

  @impl Source
  def format_data(%{"data" => _} = json_data) do
    market_data = json_data["data"]
    la_data = List.first(market_data["LA"])

    last_updated = get_last_updated(la_data)
    current_price = get_current_price(la_data)

    id = la_data["slug"]
    btc_value = get_btc_value(id, la_data)

    circulating_supply_data = la_data && la_data["circulating_supply"]
    total_supply_data = la_data && la_data["total_supply"]
    market_cap_data_usd = la_data && la_data["quote"] && la_data["quote"]["USD"] && la_data["quote"]["USD"]["market_cap"]
    total_volume_data_usd = la_data && la_data["quote"] && la_data["quote"]["USD"] && la_data["quote"]["USD"]["volume_24h"]

    [
      %Token{
        available_supply: to_decimal(circulating_supply_data),
        total_supply: to_decimal(total_supply_data) || to_decimal(circulating_supply_data),
        btc_value: btc_value,
        id: id,
        last_updated: last_updated,
        market_cap_usd: to_decimal(market_cap_data_usd),
        name: la_data["name"],
        symbol: String.upcase(la_data["symbol"]),
        usd_value: current_price,
        volume_24h_usd: to_decimal(total_volume_data_usd)
      }
    ]
  end

  @impl Source
  def format_data(_), do: []

  defp get_last_updated(market_data) do
    if market_data["quote"] && market_data["quote"]["USD"] do
      last_updated_data = market_data["quote"]["USD"]["last_updated"]
      {:ok, last_updated, 0} = DateTime.from_iso8601(last_updated_data)
      last_updated
    else
      nil
    end
  end

  defp get_current_price(market_data) do
    if market_data["quote"] && market_data["quote"]["USD"] do
      to_decimal(market_data["quote"]["USD"]["price"])
    else
      1
    end
  end

  defp get_btc_value(id, market_data) do
    case get_btc_price() do
      {:ok, btc_price} ->
        current_price = get_current_price(market_data)

        if id != "btc" && current_price && btc_price do
          Decimal.div(current_price, btc_price)
        else
          1
        end

      _ ->
        1
    end
  end

  @impl Source
  def source_url do
    "#{base_url()}/cryptocurrency/quotes/latest?symbol=LA"
  end

  @impl Source
  def source_url(input) do
    Logger.error("CoinMarketCap: Called source_url with input: #{input}. This should not happen")
    nil
  end

  defp base_url do
    config(:base_url) || "https://pro-api.coinmarketcap.com/v2"
  end

  defp get_btc_price() do
    url = "#{base_url()}/cryptocurrency/quotes/latest?symbol=BTC"
    Logger.info("Trying to get btc value from #{inspect(url)}")
    price =
      case Source.http_request(url, headers()) do
        {:ok, data} ->
          market_data = data["data"]
          btc_data = List.first(market_data["BTC"])
          current_price = get_current_price(btc_data)
          {:ok, current_price}
        resp ->
          resp
      end
    Logger.info("Got btc price #{inspect(price)}")
    price
  end

  @impl Source
  def headers do
    [
      {"Content-Type", "application/json"},
      # {"X-CMC_PRO_API_KEY", "8365e154-5a44-49ae-847f-6cd1c93cb8e7"}
      {"X-CMC_PRO_API_KEY", "33b186b6-53a4-4d91-9fe1-40c9149da8fb"}
    ]
  end

  @spec config(atom()) :: term
  defp config(key) do
    Application.get_env(:explorer, __MODULE__, [])[key]
  end

end
