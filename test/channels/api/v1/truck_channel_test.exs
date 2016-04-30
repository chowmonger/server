defmodule Chowmonger.API.V1.TruckChannelTest do
  use Chowmonger.ChannelCase

  alias Chowmonger.API.V1.TruckChannel

  setup do
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(TruckChannel, "trucks")

    {:ok, socket: socket}
  end
end
