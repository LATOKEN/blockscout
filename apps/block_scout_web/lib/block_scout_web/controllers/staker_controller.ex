defmodule BlockScoutWeb.StakerController do
  use BlockScoutWeb, :controller

  require Logger

  import BlockScoutWeb.Chain, only: [paging_options: 1, next_page_params: 3, split_list_by_page: 1]

  alias BlockScoutWeb.{StakerView, Controller}
  alias Explorer.{Chain, Market}
  alias Explorer.ExchangeRates.Token
  alias Phoenix.View

  def index(conn, %{"type" => "JSON"} = params) do
    addresses =
      params
      |> paging_options()
      |> Chain.list_validators()



    {addresses_page, next_page} = split_list_by_page(addresses)

    next_page_path =
      case next_page_params(next_page, addresses_page, params) do
        nil ->
          nil

        next_page_params ->
          staker_path(
            conn,
            :index,
            Map.delete(next_page_params, "type")
          )
      end

    exchange_rate = Market.get_exchange_rate(Explorer.coin()) || Token.null()
    total_supply = Chain.total_supply()

    items_count_str = Map.get(params, "items_count")

    items_count =
      if items_count_str do
        {items_count, _} = Integer.parse(items_count_str)
        items_count
      else
        0
      end

    items =
      addresses_page
      |> Enum.with_index(1)
      |> Enum.map(fn {{address, tx_count}, index} ->
          View.render_to_string(
            StakerView,
            "_tile.html",
            address: address,
            index: items_count + index,
            exchange_rate: exchange_rate,
            total_supply: total_supply,
            tx_count: tx_count,
            stake: 0
          )
      end)

    json(
      conn,
      %{
        items: items,
        next_page_path: next_page_path
      }
    )
  end

  def index(conn, _params) do
    total_supply = Chain.total_supply()

    render(conn, "index.html",
      current_path: Controller.current_full_path(conn),
      address_count: Chain.address_estimated_count(),
      total_supply: total_supply
    )
  end


end
