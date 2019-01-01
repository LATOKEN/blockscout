defmodule BlockScoutWeb.Tokens.HolderController do
  use BlockScoutWeb, :controller

  alias BlockScoutWeb.Tokens.HolderView
  alias Explorer.{Chain, Market}
  alias Phoenix.View

  import BlockScoutWeb.Chain,
    only: [
      split_list_by_page: 1,
      paging_options: 1,
      next_page_params: 3
    ]

  def index(conn, %{"token_id" => address_hash_string, "type" => "JSON"} = params) do
    with {:ok, address_hash} <- Chain.string_to_address_hash(address_hash_string),
         {:ok, token} <- Chain.token_from_address_hash(address_hash),
         token_balances <- Chain.fetch_token_holders_from_token_hash(address_hash, paging_options(params)) do
      {token_balances_paginated, next_page} = split_list_by_page(token_balances)

      next_page_path =
        case next_page_params(next_page, token_balances_paginated, params) do
          nil ->
            nil

          next_page_params ->
            token_holder_path(conn, :index, address_hash, Map.delete(next_page_params, "type"))
        end

      token_balances_json =
        Enum.map(token_balances_paginated, fn token_balance ->
          View.render_to_string(HolderView, "_token_balances.html", token_balance: token_balance, token: token)
        end)

      json(conn, %{items: token_balances_json, next_page_path: next_page_path})
    else
      :error ->
        not_found(conn)

      {:error, :not_found} ->
        not_found(conn)
    end
  end

  def index(conn, %{"token_id" => address_hash_string}) do
    with {:ok, address_hash} <- Chain.string_to_address_hash(address_hash_string),
         {:ok, token} <- Chain.token_from_address_hash(address_hash) do
      render(
        conn,
        "index.html",
        current_path: current_path(conn),
        holders_count_consolidation_enabled: Chain.token_holders_counter_consolidation_enabled?(),
        token: Market.add_price(token),
        total_token_holders: Chain.count_token_holders_from_token_hash(address_hash),
        total_token_transfers: Chain.count_token_transfers_from_token_hash(address_hash)
      )
    else
      :error ->
        not_found(conn)

      {:error, :not_found} ->
        not_found(conn)
    end
  end
end
