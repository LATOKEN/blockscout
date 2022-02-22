defmodule EthereumJSONRPC.Validators do


  require Logger

  import EthereumJSONRPC, only: [json_rpc: 2, request: 1]

  def request() do
    request(%{id: 0, method: "bcn_validators", params: []})
  end

  def fetch_pubkey(json_rpc_named_arguments) do
    with {:ok , response} <-
      request()
      |> json_rpc(json_rpc_named_arguments)
    do
      {:ok , response}
    else
      {msg , response} ->
        Logger.error("error fetching validators public key: #{msg}")
        {msg , response}
    end
  end

  def request_to_get_stake(address, id) do
    request(%{id: id, method: "fe_getBalance", params: [ address ]})
  end

  def fetch_stake(address, json_rpc_named_arguments) do
    with {:ok, response} <-
            request_to_get_stake(address, 0)
            |> json_rpc(json_rpc_named_arguments),
          stake = response["staking"],
          delegated_stake = response["staked"]
    do
      {:ok , %{staking: stake , delegated_stake: delegated_stake} }
    else
      {msg , response} ->
        Logger.error("error fetching stake for address: #{msg}")
        {msg , response}
    end
  end

end
