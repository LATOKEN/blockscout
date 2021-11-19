defmodule EthereumJSONRPC.Pool do

  alias EthereumJSONRPC.Transactions


  require Logger
  def request(id) do
    EthereumJSONRPC.request(%{id: id, method: "eth_getTransactionPool", params: []})
  end

  def make_list(var) do
    if is_list(var) do
      var
    else
      [var]
    end
  end


  def check_if_pending([] , _ , _), do: []

  def check_if_pending([tx_hash | tail] , id , json_rpc_named_arguments) do
    request = make_list(Transactions.request(id , tx_hash))
    with {:ok, response_list} <- EthereumJSONRPC.json_rpc(request, json_rpc_named_arguments)
    do
      [response | _] = response_list
      [transaction | _] = Transactions.to_elixir([response[:result]])
      block_hash = transaction["blockHash"]
      if block_hash == nil or block_hash == "0x" do
        [transaction | check_if_pending(tail , id + 1, json_rpc_named_arguments)]
      else
        check_if_pending(tail , id + 1, json_rpc_named_arguments)
      end
    else
      {msg , _} ->
        Logger.error("error fetching transaction #{tx_hash} by hash: #{msg}")
        check_if_pending(tail , id + 1, json_rpc_named_arguments)
    end

  end

  def pending_transactions(tx_hashes , json_rpc_named_arguments) do
    if is_list(tx_hashes) do
      check_if_pending(tx_hashes, 0 , json_rpc_named_arguments)
      |> Transactions.elixir_to_params()
    else
      Logger.error("invalid arguement")
      []
    end
  end


end
