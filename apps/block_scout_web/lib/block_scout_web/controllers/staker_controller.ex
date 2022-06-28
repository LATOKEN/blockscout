defmodule BlockScoutWeb.StakerController do
  use BlockScoutWeb, :controller

  require Logger

  import BlockScoutWeb.Chain, only: [paging_options: 1, next_page_params: 3, split_list_by_page: 1]
  import Indexer.Transform.Blocks, only: [get_address_from_compressed_pubkey: 1]
  import EthereumJSONRPC, only: [fetch_validators_public_key: 1] #, fetch_stake_of_address: 2]

  alias BlockScoutWeb.{StakerView, Controller}
  alias Explorer.{Chain, Market}
  #alias Explorer.Chain.Address
  alias Explorer.ExchangeRates.Token
  alias Phoenix.View

  def index(conn, %{"type" => "JSON"} = params) do

    validators_address = get_validators_address()
    paging_options = paging_options(params)
    addresses = Chain.list_validators(paging_options, validators_address)
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
          {staking, delegated_stake} = get_stake(address)
          View.render_to_string(
            StakerView,
            "_tile.html",
            address: address,
            index: items_count + index,
            exchange_rate: exchange_rate,
            total_supply: total_supply,
            tx_count: tx_count,
            staking: staking,
            delegated_stake: delegated_stake
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

  def get_stake(_address), do: {0, 0}

  # def get_stake(address) do
  #   address_hash = Address.checksum(address.hash)
  #   json_rpc_named_arguments = Application.get_env(:explorer, :json_rpc_named_arguments)
  #   with {:ok, %{staking: stake , delegated_stake: delegated_stake} } <- fetch_stake_of_address(address_hash, json_rpc_named_arguments)
  #   do
  #     {stake , delegated_stake}
  #   else
  #     error ->
  #       Logger.error("error fetching stake: #{inspect(error)}")
  #       {0, 0}
  #   end
  # end

  def get_validators_address do
    json_rpc_named_arguments = Application.get_env(:explorer, :json_rpc_named_arguments)
    with {:ok, responses} <- fetch_validators_public_key(json_rpc_named_arguments),
      {:ok, addresses} <- get_address_from_public_key(make_list(responses))
    do
      addresses
    end
  end


  def get_address_from_public_key(validator_public_key) when not is_list(validator_public_key) do
    pubkey_bytes = Base.decode16!(String.slice(validator_public_key,2,66), case: :mixed)
    {:ok, address_bytes} = get_address_from_compressed_pubkey(pubkey_bytes)
    address = Base.encode16(address_bytes, case: :lower)
    {:ok, "0x" <> address}
  end


  def get_address_from_public_key([]), do: {:ok, []}

  def get_address_from_public_key([public_key | rest_public_keys]) do
    with {:ok, address} <- get_address_from_public_key(public_key),
      {:ok, addresses} <- get_address_from_public_key(rest_public_keys)
    do
      {:ok, [address | addresses]}
    end
  end


  def make_list(var) do
    if is_list(var) do
      var
    else
      [var]
    end
  end

end
