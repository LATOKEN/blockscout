defmodule EthereumJSONRPC.Utilities do

  require Logger

  def print_msg(msg), do: Logger.info("#{inspect(msg)}")

  def print(nil, msg) do
    print_msg({msg, "got nil...skipping"})
  end

  def print([] , msg) do
    print_msg({msg , "got empty list...skipping"})
  end

  def print(var , msg) do
    print_msg({msg , var})
  end

end
