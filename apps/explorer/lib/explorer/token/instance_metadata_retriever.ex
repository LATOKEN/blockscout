defmodule Explorer.Token.InstanceMetadataRetriever do
  @moduledoc """
  Fetches ERC721 token instance metadata.
  """

  require Logger

  alias Explorer.SmartContract.Reader
  # alias HTTPoison.{Response}

  @token_uri "c87b56dd"
  # @token_uri "4a8a11c7"

  @abi [
    %{
      "type" => "function",
      "stateMutability" => "view",
      "payable" => false,
      "outputs" => [
        %{"type" => "string", "name" => ""}
      ],
      "name" => "tokenURI",
      # "name" => "storageTokenURI",
      "inputs" => [
        %{
          "type" => "uint256",
          "name" => "_tokenId"
        }
      ],
      "constant" => true
    }
  ]

  @uri "0e89341c"

  @abi_uri [
    %{
      "type" => "function",
      "stateMutability" => "view",
      "payable" => false,
      "outputs" => [
        %{
          "type" => "string",
          "name" => "",
          "internalType" => "string"
        }
      ],
      "name" => "uri",
      "inputs" => [
        %{
          "type" => "uint256",
          "name" => "_id",
          "internalType" => "uint256"
        }
      ],
      "constant" => true
    }
  ]

  @cryptokitties_address_hash "0x06012c8cf97bead5deae237070f9587f8e7a266d"

  @no_uri_error "no uri"
  @vm_execution_error "VM execution error"

  def fetch_metadata(unquote(@cryptokitties_address_hash), token_id) do
    %{"tokenURI" => {:ok, ["https://api.cryptokitties.co/kitties/#{token_id}"]}}
    |> fetch_json()
  end

  def fetch_metadata(contract_address_hash, token_id) do
    # c87b56dd =  keccak256(tokenURI(uint256))
    contract_functions = %{@token_uri => [token_id]}

    res =
      contract_address_hash
      |> query_contract(contract_functions, @abi)
      |> fetch_json()

    if res == {:ok, %{error: @vm_execution_error}} do
      contract_functions_uri = %{@uri => [token_id]}

      contract_address_hash
      |> query_contract(contract_functions_uri, @abi_uri)
      |> fetch_json()
    else
      res
    end
  end

  def query_contract(contract_address_hash, contract_functions, abi) do
    Reader.query_contract(contract_address_hash, abi, contract_functions, false)
  end

  def fetch_json(uri) when uri in [%{@token_uri => {:ok, [""]}}, %{@uri => {:ok, [""]}}] do
    {:ok, %{error: @no_uri_error}}
  end

  def fetch_json(uri)
      when uri in [
             %{@token_uri => {:error, "(-32015) VM execution error."}},
             %{@uri => {:error, "(-32015) VM execution error."}}
           ] do
    {:ok, %{error: @vm_execution_error}}
  end

  def fetch_json(%{@token_uri => {:error, "(-32015) VM execution error." <> _}}) do
    {:ok, %{error: @vm_execution_error}}
  end

  def fetch_json(%{@uri => {:error, "(-32015) VM execution error." <> _}}) do
    {:ok, %{error: @vm_execution_error}}
  end

  def fetch_json(%{@token_uri => {:ok, ["http://" <> _ = token_uri]}}) do
    fetch_metadata(token_uri)
  end

  def fetch_json(%{@uri => {:ok, ["http://" <> _ = token_uri]}}) do
    fetch_metadata(token_uri)
  end

  def fetch_json(%{@token_uri => {:ok, ["https://" <> _ = token_uri]}}) do
    fetch_metadata(token_uri)
  end

  def fetch_json(%{@uri => {:ok, ["https://" <> _ = token_uri]}}) do
    fetch_metadata(token_uri)
  end

  def fetch_json(%{@token_uri => {:ok, ["data:application/json," <> json]}}) do
    decoded_json = URI.decode(json)

    fetch_json(%{@token_uri => {:ok, [decoded_json]}})
  rescue
    e ->
      Logger.debug(["Unknown metadata format #{inspect(json)}. error #{inspect(e)}"],
        fetcher: :token_instances
      )

      {:error, json}
  end

  def fetch_json(%{@uri => {:ok, ["data:application/json," <> json]}}) do
    decoded_json = URI.decode(json)

    fetch_json(%{@token_uri => {:ok, [decoded_json]}})
  rescue
    e ->
      Logger.debug(["Unknown metadata format #{inspect(json)}. error #{inspect(e)}"],
        fetcher: :token_instances
      )

      {:error, json}
  end

  def fetch_json(%{@token_uri => {:ok, ["ipfs://ipfs/" <> ipfs_uid]}}) do
    ipfs_url = "https://ipfs.io/ipfs/" <> ipfs_uid
    fetch_metadata(ipfs_url)
  end

  def fetch_json(%{@uri => {:ok, ["ipfs://ipfs/" <> ipfs_uid]}}) do
    ipfs_url = "https://ipfs.io/ipfs/" <> ipfs_uid
    fetch_metadata(ipfs_url)
  end

  def fetch_json(%{@token_uri => {:ok, ["ipfs://" <> ipfs_uid]}}) do
    ipfs_url = "https://ipfs.io/ipfs/" <> ipfs_uid
    fetch_metadata(ipfs_url)
  end

  def fetch_json(%{@uri => {:ok, ["ipfs://" <> ipfs_uid]}}) do
    ipfs_url = "https://ipfs.io/ipfs/" <> ipfs_uid
    fetch_metadata(ipfs_url)
  end

  def fetch_json(%{@token_uri => {:ok, [json]}}) do
    {:ok, json} = decode_json(json)

    check_type(json)
  rescue
    e ->
      Logger.debug(["Unknown metadata format #{inspect(json)}. error #{inspect(e)}"],
        fetcher: :token_instances
      )

      {:error, json}
  end

  def fetch_json(%{@uri => {:ok, [json]}}) do
    {:ok, json} = decode_json(json)

    check_type(json)
  rescue
    e ->
      Logger.debug(["Unknown metadata format #{inspect(json)}. error #{inspect(e)}"],
        fetcher: :token_instances
      )

      {:error, json}
  end

  def fetch_json(result) do
    Logger.debug(["Unknown metadata format #{inspect(result)}."], fetcher: :token_instances)

    {:error, result}
  end

  defp fetch_metadata(uri) do
    newUri = if String.contains?(uri, "gateway.pinata.cloud") do
      String.replace(uri, "gateway.pinata.cloud", "latoken.mypinata.cloud")
    else
      uri
    end

    resp = HTTPoison.get!(newUri)
    if resp.status_code == 200 do
      {:ok, json} = decode_json(resp.body)
      if Map.has_key?(json, "image") do
        check_type(json)
      else
        newJson = Map.put(json, "image", json["url"])
        check_type(newJson)
      end
    end

    rescue
      e ->
        Logger.debug(["Could not send request to token uri #{inspect(uri)}. error #{inspect(e)}"],
          fetcher: :token_instances
        )
        newUri = if String.contains?(uri, "gateway.pinata.cloud") do
          String.replace(uri, "gateway.pinata.cloud", "latoken.mypinata.cloud")
        else
          uri
        end
        Logger.debug(["Could not send request to new token uri #{inspect(newUri)}. error #{inspect(e)}"],
          fetcher: :token_instances
        )

        {:error, :request_error}

  end

  defp decode_json(body) do
    if String.valid?(body) do
      Jason.decode(body)
    else
      body
      |> :unicode.characters_to_binary(:latin1)
      |> Jason.decode()
    end
  end

  defp check_type(json) when is_map(json) do
    if String.contains?(json["image"], "gateway.pinata.cloud") do
      newUri = String.replace(json["image"], "gateway.pinata.cloud", "latoken.mypinata.cloud")
      json = Map.put(json, "image", newUri)

      {:ok, %{metadata: json}}
    else
      {:ok, %{metadata: json}}
    end
  end

  defp check_type(_) do
    {:error, :wrong_metadata_type}
  end
end
