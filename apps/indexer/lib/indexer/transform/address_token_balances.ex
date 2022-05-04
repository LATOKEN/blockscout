defmodule Indexer.Transform.AddressTokenBalances do
  @moduledoc """
  Extracts `Explorer.Address.TokenBalance` params from other schema's params.
  """

  require Logger

  #import EthereumJSONRPC.Utilities, only: [print: 2]

  alias Explorer.Chain
  alias Explorer.Chain.Address.CurrentTokenBalance

  @burn_address "0x0000000000000000000000000000000000000000"

  @tokens_to_update_all_address [
    #"0x0000000000000000000000000000000000000001", #testing
    #"0xd83faf5c2ae5e1f96e104cc94ee1919bcbf25c46", # testing
    "0xaba0bb586335b938a7a817a900017d891268d32c", # xWeowns in mainnet
    "0x82779f184af990b7808f1559e48db8fd114ab347", # xWeowns in testnet
    "0x5ce3d12a629414fe9b02b61e01bab92fe20c482a", # xWeowns in testnet
    "0x68f62581b6cbe6d8f153479c9179fd18125637d5", # xWeowns in testnet
    "0x59d0f901503600c4c953a851044f9dc1c747caee", # xWeowns in testnet
    "0xa03c640677fa03ce5fd10f1c95eb52b75e69c781" # xWeowns in testnet
  ]

  def update_all_address(%{tokens_params: tokens}, block_number) do
    tokens_to_update = Enum.filter(tokens, &filter_necessary_tokens/1)
    #print(tokens_to_update, "got filtered tokens")
    if tokens_to_update == [] do
      MapSet.new()
    else
      tokens_with_block_number = put_block_number(tokens_to_update, block_number)
      #print(tokens_with_block_number, "filtered tokens with block number")
      get_all_address(tokens_with_block_number, MapSet.new())
    end
  end

  def put_block_number([], _block_number), do: []

  def put_block_number([token | tokens], block_number) do
    [Map.put(token, :block_number, block_number) | put_block_number(tokens, block_number)]
  end

  def filter_necessary_tokens(%{contract_address_hash: contract_address_hash}) do
    res =
    if (contract_address_hash not in @tokens_to_update_all_address) do
      false
    else
      true
    end
    #print({contract_address_hash, res}, "filtering token")
    res
  end

  def filter_necessary_tokens(_token) do
    false
  end

  def get_all_address([
    %{
      contract_address_hash: contract_address_hash,
    } = token | tokens ], result) when is_list(tokens) do

      #print(contract_address_hash, "printing token address in hex")
      with {:ok, token_address} <- Chain.string_to_address_hash(contract_address_hash) do
        #print(token_address, "printing token address in Address format")
        addresses = Chain.fetch_token_holders_from_token_hash(token_address, false)
        #print(token, "printing token")
        #print(addresses, "printing addresses for token")
        #print(result, "printing result")
        result = update_each_address(addresses, token, result)
        get_all_address(tokens, result)
      else
        error ->
          Logger.error("got error fetching token holders: #{inspect(error)}")
      end
  end

  def get_all_address([], result), do: result

  def update_each_address(
    [address | addresses],
    %{
      block_number: block_number,
      contract_address_hash: contract_address_hash,
      type: token_type
    } = token,
    result) do
      address_hash = CurrentTokenBalance.get_address_hex(address)
      #print({contract_address_hash, address_hash}, "printing addresses for token")
      result = add_token_balance_address(result, address_hash, contract_address_hash, nil, token_type, block_number)
      update_each_address(addresses, token, result)
  end

  def update_each_address([] , _token, result), do: result

  def params_set(%{} = import_options) do
    Enum.reduce(import_options, MapSet.new(), &reducer/2)
  end

  defp reducer({:token_transfers_params, token_transfers_params}, initial) when is_list(token_transfers_params) do
    token_transfers_params
    |> ignore_burn_address_transfers_for_token_larc_721
    |> Enum.reduce(initial, fn %{
                                 block_number: block_number,
                                 from_address_hash: from_address_hash,
                                 to_address_hash: to_address_hash,
                                 token_contract_address_hash: token_contract_address_hash,
                                 token_id: token_id,
                                 token_type: token_type
                               } = params,
                               acc
                               when is_integer(block_number) and is_binary(from_address_hash) and
                                      is_binary(to_address_hash) and is_binary(token_contract_address_hash) ->
      if params[:token_ids] && token_type == "LARC-1155" do
        params[:token_ids]
        |> Enum.reduce(acc, fn id, sub_acc ->
          sub_acc
          |> add_token_balance_address(from_address_hash, token_contract_address_hash, id, token_type, block_number)
          |> add_token_balance_address(to_address_hash, token_contract_address_hash, id, token_type, block_number)
        end)
      else
        acc
        |> add_token_balance_address(from_address_hash, token_contract_address_hash, token_id, token_type, block_number)
        |> add_token_balance_address(to_address_hash, token_contract_address_hash, token_id, token_type, block_number)
      end
    end)
  end

  defp ignore_burn_address_transfers_for_token_larc_721(token_transfers_params) do
    Enum.filter(token_transfers_params, &do_filter_burn_address/1)
  end

  defp add_token_balance_address(map_set, unquote(@burn_address), _, _, _, _), do: map_set

  defp add_token_balance_address(map_set, address, token_contract_address, token_id, token_type, block_number) do
    MapSet.put(map_set, %{
      address_hash: address,
      token_contract_address_hash: token_contract_address,
      block_number: block_number,
      token_id: token_id,
      token_type: token_type
    })
  end

  def do_filter_burn_address(%{to_address_hash: unquote(@burn_address), token_type: "LARC-721"}) do
    false
  end

  def do_filter_burn_address(_token_balance_param) do
    true
  end
end
