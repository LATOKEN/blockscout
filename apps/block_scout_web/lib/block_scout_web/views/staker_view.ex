defmodule BlockScoutWeb.StakerView do
  use BlockScoutWeb, :view

  require Logger

  alias Explorer.Chain
  alias Explorer.Chain.{Address, Hash, Wei}
  alias Explorer.ExchangeRates.Token, as: TokenExchangeRate


  @dialyzer :no_match




  @doc """
  Returns a formatted address balance and includes the unit.
  """
  def balance(%Address{fetched_coin_balance: nil}), do: ""

  def balance(%Address{fetched_coin_balance: balance}) do
    format_wei_value(balance, :ether)
  end

  def balance_percentage_enabled?(total_supply) do
    Application.get_env(:block_scout_web, :show_percentage) && total_supply > 0
  end

  def balance_percentage(_, nil), do: ""

  def balance_percentage(
        %Address{
          hash: %Hash{
            byte_count: 20,
            bytes: <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>>
          }
        },
        _
      ),
      do: ""

  def balance_percentage(%Address{fetched_coin_balance: balance}, total_supply) do
    if Decimal.cmp(total_supply, 0) == :gt do
      balance
      |> Wei.to(:ether)
      |> Decimal.div(Decimal.new(total_supply))
      |> Decimal.mult(100)
      |> Decimal.round(4)
      |> Decimal.to_string(:normal)
      |> Kernel.<>("% #{gettext("Market Cap")}")
    else
      balance
      |> Wei.to(:ether)
      |> Decimal.to_string(:normal)
    end
  end

  def balance_percentage(%Address{fetched_coin_balance: _} = address) do
    balance_percentage(address, Chain.total_supply())
  end

  def empty_exchange_rate?(exchange_rate) do
    TokenExchangeRate.null?(exchange_rate)
  end

  def stake(stake) do
    case :binary.match(stake, ".") do
      :nomatch ->
        stake <> " #{gettext("LA")}"
      {pos,1} ->
        len = String.length(stake)
        fraction_len = len - pos - 1
        fraction = String.slice(stake,pos + 1, fraction_len)
        if fraction == get_zeros(fraction_len) do
          String.slice(stake, 0, pos) <> " #{gettext("LA")}"
        else
          stake <> " #{gettext("LA")}"
        end
      error ->
        Logger.error("got error calculating stake: #{inspect(error)}")
    end
  end

  @spec get_zeros(non_neg_integer()) :: String.t()
  def get_zeros(count) do
    if count == 0 do
      ""
    else
      "0" <> get_zeros(count - 1)
    end
  end

end
