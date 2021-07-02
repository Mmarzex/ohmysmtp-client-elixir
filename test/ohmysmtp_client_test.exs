defmodule OhmysmtpClientTest do
  use ExUnit.Case
  doctest OhmysmtpClient

  test "greets the world" do
    assert OhmysmtpClient.hello() == :world
  end
end
