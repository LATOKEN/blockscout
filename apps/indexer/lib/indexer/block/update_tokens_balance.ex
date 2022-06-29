defmodule Indexer.Block.UpdateTokensBalance do
  @moduledoc """
  This is a helper module to update all balance of holders of all tokens
  Call the method update_all_tokens_balance(), it will get a map_set of params to update balances
  After it seems that all tokens are updated, stop calling this method because
  it can decrease the efficiency of the explorer
  """

  alias Explorer.Chain
  alias Explorer.Chain.{Address, Token}

  require Logger

  def update_selected_address_balance(block_number) do
    Logger.info("Updating balances")
    addresses =
      [
        "0x333aE6B0C55847fFa5d7f03F0b841082B66f0A86"
      ]
    # fetch all tokens
    tokens = Chain.list_top_tokens(nil)
    formatted_tokens = format_tokens(tokens)
    total = length(formatted_tokens)
    Logger.info("Got total tokens: #{inspect(total)}")
    params = get_map_set_params(formatted_tokens, addresses, MapSet.new(), block_number)
    Logger.info("Got params to update balances")
    params
  end

  def update_all_tokens_balance(block_number) do
    # fetch all tokens
    tokens = Chain.list_top_tokens(nil)
    formatted_tokens = format_tokens(tokens)
    # fetch all addresses
    addresses = Chain.list_top_addresses()
    formatted_addresses = format_addresses(addresses)
    # get the MapSet params to update balance
    get_map_set_params(formatted_tokens, formatted_addresses, MapSet.new(), block_number)
  end

  def format_tokens([]), do: []

  def format_tokens([token | remaining_tokens]) do
    formatted_token = format_tokens(token)
    if formatted_token == nil do
      format_tokens(remaining_tokens)
    else
      [formatted_token | format_tokens(remaining_tokens)]
    end
  end

  def format_tokens(%Token{
    type: type,
    contract_address_hash: hash
  }) do
    if type == "LARC-20" do
      %{
        type: type,
        contract_address_hash: Address.checksum(hash)
      }
    else
      nil
    end
  end

  def format_addresses([]), do: []

  def format_addresses([address | remaining_addresses]) do
    formatted_address = format_addresses(address)
    [formatted_address | format_addresses(remaining_addresses)]
  end

  def format_addresses({%Address{
    hash: hash
  }, _}) do
    Address.checksum(hash)
  end

  def get_map_set_params(_token, [], result, _block_number), do: result

  def get_map_set_params(%{
    type: type,
    contract_address_hash: contract_address
  } = token, [address | remaining_addresses], result, block_number) do
    result = add_token_balance_address(result, address, contract_address, nil, type, block_number)
    get_map_set_params(token, remaining_addresses, result, block_number)
  end

  def get_map_set_params([], _addresses, result, _block_number), do: result

  def get_map_set_params([token | remaining_tokens], addresses, result, block_number) do
    result = get_map_set_params(token, addresses, result, block_number)
    get_map_set_params(remaining_tokens, addresses, result, block_number)
  end

  def add_token_balance_address(map_set, address, token_contract_address, token_id, token_type, block_number) do
    MapSet.put(map_set, %{
      address_hash: address,
      token_contract_address_hash: token_contract_address,
      block_number: block_number,
      token_id: token_id,
      token_type: token_type
    })
  end

end
