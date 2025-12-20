defmodule HelloWsWeb.RecurringChannel do
  use Phoenix.Channel
  require Logger

  @send_after 5_000

  def join("recurring", _params, _socket) do
    schedule_send_token()
    {:ok, socket}
  end

  defp schedule_send_token() do
    Process.send_after(self(), :send_token, @send_after)
  end
end
