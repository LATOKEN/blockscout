defmodule Explorer.ExchangeRates.Source.EthPlorer do
  @moduledoc """
  Adapter for fetching exchange rates from https://ethplorer.io/
  """

  alias Explorer.ExchangeRates.{Source, Token}

  require Logger

  import Source, only: [to_decimal: 1]
  import Explorer.Chain.Wei, only: [one_wei_in_decimal: 0]

  @behaviour Source

  @impl Source
  def format_data(market_data) do
    last_updated = get_last_updated(market_data)
    current_price = get_current_price(market_data)

    id = market_data["name"]
    btc_value = get_wbtc_value(id, market_data)

    price = market_data && market_data["price"]
    circulating_supply_data = price && price["availableSupply"]
    total_supply_data = to_decimal(market_data && market_data["totalSupply"])
    {:ok, one_wei} = one_wei_in_decimal()
    total_supply_data = Decimal.div(total_supply_data, one_wei)
    market_cap_data_usd = price && price["marketCapUsd"]
    total_volume_data_usd = price && price["volume24h"]

    [
      %Token{
        available_supply: to_decimal(circulating_supply_data),
        total_supply: to_decimal(total_supply_data) || to_decimal(circulating_supply_data),
        btc_value: btc_value,
        id: id,
        last_updated: last_updated,
        market_cap_usd: to_decimal(market_cap_data_usd),
        name: market_data["name"],
        symbol: String.upcase(market_data["symbol"]),
        usd_value: current_price,
        volume_24h_usd: to_decimal(total_volume_data_usd)
      }
    ]
  end

  defp get_last_updated(market_data) do
    price = market_data && market_data["price"]
    last_updated_data = price && price["ts"]

    if last_updated_data do
      {:ok, last_updated} = DateTime.from_unix(last_updated_data)
      last_updated
    else
      nil
    end
  end

  defp get_current_price(market_data) do
    if market_data["price"] do
      to_decimal(market_data["price"]["rate"])
    else
      1
    end
  end

  defp get_wbtc_value(id, market_data) do
    case get_wbtc_price() do
      {:ok, btc_price} ->
        current_price = get_current_price(market_data)

        if id != "WBTC" && current_price && btc_price do
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
    "#{base_url()}/getTokenInfo/#{latoken_contract_on_ethereum()}?apiKey=freekey"
  end

  @impl Source
  def source_url(input) do
    Logger.error("EthPlorer: Called source_url with input: #{input}. This should not happen")
    nil
  end

  defp latoken_contract_on_ethereum do
    "0xE50365f5D679CB98a1dd62D6F6e58e59321BcdDf"
  end

  defp wbtc_contract_on_ethereum do
    "0x2260fac5e5542a773aa44fbcfedf7c193bc2c599"
  end

  defp base_url do
    config(:base_url) || "https://api.ethplorer.io"
  end

  defp get_wbtc_price() do
    url = "#{base_url()}/getTokenInfo/#{wbtc_contract_on_ethereum()}?apiKey=freekey"
    Logger.info("Trying to get wbtc price from #{inspect(url)}")
    price =
      case Source.http_request(url) do
        {:ok, data} ->
          current_price = get_current_price(data)
          {:ok, current_price}
        resp ->
          resp
      end
    Logger.info("Got wbtc price #{inspect(price)}")
    price
  end

  @impl Source
  def headers do
    Source.headers()
  end

  @spec config(atom()) :: term
  defp config(key) do
    Application.get_env(:explorer, __MODULE__, [])[key]
  end

end
