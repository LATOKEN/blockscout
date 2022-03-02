defmodule BlockScoutWeb.StakerView do
  use BlockScoutWeb, :view

  require Logger

  import BlockScoutWeb.AddressView, only: [balance: 1, balance_percentage_enabled?: 1, balance_percentage: 2, empty_exchange_rate?: 1, stake: 1]

  @dialyzer :no_match

end
