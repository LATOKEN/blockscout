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
    Logger.info("Updating fake balances")
    addresses =
      [
        "0x0ac36c93c01debbef9bc8df8f9f1c1fce7b25f72",
        "0x4448ad5088f4e5df619ea4e0432d53f266ef672f",
        "0x15f11309d4a763c7d1c6d66568dfa521c8c6dd2d",
        "0xc331470f6230580bfb406512ab69e8e25c4fa655",
        "0xd420fdab6df4cf9c9832e4bcb97b0719d54f8e5b",
        "0x3c503c8ae59464b04880a88b21d3b8f56abd3a50",
        "0xee739147c93636b8f97eea5676307892199383b1",
        "0x5591ec8913e055c3321772dcd3a46f4265d44761",
        "0xa265a756c45b2f6f0ad58b55afddfbf02c3dbe0e",
        "0x3301187446f0283985290710f3b43c9c20eeb5b4",
        "0x4ba938cb90b7e2cc4f93f95bc5ae5ac153f2dce5",
        "0xa4a1deeb72a6e567f18d7b203185ad2e6aa3c91c",
        "0xf6e520f0153afdeb11569c40e0978cff4ca2ce13",
        "0x4650d85a83ec98466974a8ad67a94a82c174a095",
        "0xc8bb0a0f524ea4b522b73c6b34724a96657b574d",
        "0x7dd7438593cfe63455a00d2f0beecd7a3654221c",
        "0xdfcfe38245718daaa357cb49f735149cd743aadb",
        "0x0505a468c4d8ca39cab2c107c8310e8bf2371dd4",
        "0x0518e09fb873d2b81258a90b1debc8480aaee121",
        "0x7cd97bc2da659546915f679c0a54db557e783ae9",
        "0xc0e363077cee4100765dd8b4a2376033bf8a930d",
        "0xde87fcd4686cc49e381230531c29c84154a3b2ac",
        "0x48882441a203f22e1b9619b572388edc6233c09b",
        "0x9829923404d7c7670cb42cde967b5036ffc1ebfe",
        "0x84b4f2c8e9bbf2379a4acb2ad144bbf5f88f9dbb",
        "0xf27b87bb98da8667801a75121a9b26492de2c361",
        "0x4c10876a087ef719c5b678d2fdcca9fd1896d631",
        "0xa40adc263bfddfb0bef5b0a633613f324ed8bd96",
        "0x84105cb82fa74066209bc24510ca32b95142738b",
        "0xf72dc8f1ba053eaf2338e84ab2eec1f285ea9a0a",
        "0x14028a89b911e137f7d7482b8db453dc77d1669b",
        "0x4016c0240cce6b77faf7b0432c6caa6d2a21fd6f",
        "0xf1520fb4e02604ee2a26e3a6a2ea36dfaa658a55",
        "0xebcb7a8e2fcac23433fd636f417d2353f9736723",
        "0xa720785048f8beb925937cc7f041e9ef6ff6fa42",
        "0x13e8d99f97066c5b392d6ab605def27cefe993df",
        "0x1ee8ec9bd8a920bbef66680684ef1029ecf7d64b",
        "0x094dbf3bb0fc144b7892649141b7503738358a50",
        "0x6949c8169fb9d235fb59b5e2ce5879706f1a0a43",
        "0xbada5f073f30d96620b692d3c2bb775892d8849c",
        "0x1a76b8fd394d539f31010f94bfbeae0f8fb911d8",
        "0x363c13573dd179ddf705b6bbafe9484409c1d58f",
        "0xbc69c559eba7fd5cafb79f03b23a284fa4174894",
        "0xeff6e17fdc68d56812da40f7d05fc8cdfd212440",
        "0x184b4efa04daffc532e4e94251cbec90f0c5caa5",
        "0x5e093fe60cf2b04c7d9c58e66391123240df0bed",
        "0x3385a66ab7d0294479cc33c6c26e261a81a457be",
        "0xd205d505ad413e627523fb877380e4a9de2c786a",
        "0x11fe29d73db33c52c156c3fedbc5776487c025f4",
        "0xcc4c3c80fd4dab8297e2f386b5bdf2d7dd139176",
        "0x0e3ac56774e282f7ff4f544ef996f1cf4331c3c5",
        "0x596bc98630e2548379b7c997e69c5e09ec4e0a7d",
        "0x49c76c602c4294ccee289e6e03e5d01d9bcf9dd0",
        "0x7f6611e208126805d42624e9a70d8c55e8820739",
        "0x9c68ddcc8f821888daad51b5b37d5125c6607395",
        "0xea4c13df6b962e94e35755f827dc15bde5d07eb0",
        "0x3a898d596840c6b6b586d722bfadcc8c4761bf41",
        "0x8d36582b8e2c46a0c2db910f7f55324727bb7a99",
        "0x9d366c56c8aad25e4adcb8f52b7ae80c5c59def7",
        "0x1d07ed425e01c82fa9d75e5efd866e680941a46b",
        "0xab85ea6b4c61b502b74f6756afcdc100399c85d6",
        "0x01b352e29388d1a95054464f478f31d1a6c51325",
        "0x823bd56266cd7b075e08e95453ad76a1921c776b",
        "0x97836ba434bd957804aa25b9f97c7a7e9a48f2cc",
        "0xb20188bfc6f3284a77e2283420fb64e4ad514a42",
        "0x8f02a68cfa8c004e7039632836515e8747b19c5e",
        "0x63a21fd16e62753c223aa1d62e9f280a82624817",
        "0x3ef749ffeac78139206191f3a7e1878ccebfcc33",
        "0x5c45f40d16eb0c97a96340ab7ce2d45b613e3ea3",
        "0xd779bc2ca93c90215d19e9ce2ba8d4b03a3dbe8f",
        "0x8d65bc9adbc922c2ac10b7445016dbfec120aa61",
        "0xf5b4d29b607c030c2f2d58906eea2f30f92c383d",
        "0x762f91eb5e8947b604b64687e5889e83a6ce63ad",
        "0x0000000000000000000000000000000000000002",
        "0x31ed5415795cda9b5c91294f45c764c964eb9422",
        "0x22175e7dcccca4316f329c6f7e1d0468bd53dc58",
        "0x0000000000000000000000000000000000000003",
        "0x15f11309d4a763c7d1c6d66568dfa521c8c6dd2d",
        "0xee739147c93636b8f97eea5676307892199383b1",
        "0xf6e520f0153afdeb11569c40e0978cff4ca2ce13",
        "0x7dd7438593cfe63455a00d2f0beecd7a3654221c",
        "0x7cd97bc2da659546915f679c0a54db557e783ae9",
        "0xc0e363077cee4100765dd8b4a2376033bf8a930d",
        "0xde87fcd4686cc49e381230531c29c84154a3b2ac",
        "0x48882441a203f22e1b9619b572388edc6233c09b",
        "0x4c10876a087ef719c5b678d2fdcca9fd1896d631",
        "0xa40adc263bfddfb0bef5b0a633613f324ed8bd96",
        "0xf72dc8f1ba053eaf2338e84ab2eec1f285ea9a0a",
        "0x14028a89b911e137f7d7482b8db453dc77d1669b",
        "0xeff6e17fdc68d56812da40f7d05fc8cdfd212440",
        "0xd205d505ad413e627523fb877380e4a9de2c786a",
        "0x596bc98630e2548379b7c997e69c5e09ec4e0a7d",
        "0x49c76c602c4294ccee289e6e03e5d01d9bcf9dd0",
        "0x9c68ddcc8f821888daad51b5b37d5125c6607395",
        "0x4c3550365b82b3a30b15d3f22e33652d19a1a249",
        "0x3a898d596840c6b6b586d722bfadcc8c4761bf41",
        "0xdd87b606e3244924354510f9fb85a277f0f796e4",
        "0x9d366c56c8aad25e4adcb8f52b7ae80c5c59def7",
        "0x1d07ed425e01c82fa9d75e5efd866e680941a46b",
        "0xab85ea6b4c61b502b74f6756afcdc100399c85d6",
        "0xfe1a7aa5492156409160e9cd565acf14f41576dc",
        "0x63a21fd16e62753c223aa1d62e9f280a82624817",
        "0x97836ba434bd957804aa25b9f97c7a7e9a48f2cc",
        "0xb20188bfc6f3284a77e2283420fb64e4ad514a42",
        "0xc5e13c92afd6751e426aa490cd505009824e59fc",
        "0x6bc32575acb8754886dc283c2c8ac54b1bd93195",
        "0x3ef749ffeac78139206191f3a7e1878ccebfcc33",
        "0x5c45f40d16eb0c97a96340ab7ce2d45b613e3ea3",
        "0xc28a6b8a3ddb2cdef493ff861dd868c09790813a",
        "0xd779bc2ca93c90215d19e9ce2ba8d4b03a3dbe8f",
        "0xf5b4d29b607c030c2f2d58906eea2f30f92c383d",
        "0x762f91eb5e8947b604b64687e5889e83a6ce63ad",
        "0x0000000000000000000000000000000000000000",
        "0x31ed5415795cda9b5c91294f45c764c964eb9422",
        "0x0000000000000000000000000000000000000003",
        "0x79ac948f99f5afecec8c54d85a291ddf5bb19005",
        "0x14014524883b39895f1c7a287399723f3faf0bdf",
        "0x333ae6b0c55847ffa5d7f03f0b841082b66f0a86"
      ]
    # fetch all tokens
    tokens = Chain.list_top_tokens(nil)
    formatted_tokens = format_tokens(tokens)
    params = get_map_set_params(formatted_tokens, addresses, MapSet.new(), block_number)
    Logger.info("Got params to update fake balances")
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
