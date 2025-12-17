defmodule HelloWsWeb.AuthSocket do
  # alias ElixirLS.LanguageServer.Plugins.Phoenix

  use Phoenix.Socket
  require Logger

  channel("ping", HelloWsWeb.PingChannel)
  channel("tracked", HelloWsWeb.TrackedChannel)
  channel "user:*", HelloWsWeb.AuthChannel

  def connect(%{"token" => token}, socket) do
    case verify(socket, token) do
      {:ok, user_id} ->
        Logger.info("AuthSocket: User #{user_id} connected.")
        socket = assign(socket, :user_id, user_id)
        {:ok, socket}

      {:error, err} ->
        Logger.error("#{__MODULE__} connect error #{inspect(err)}")
        :error
    end
  end

  def connect(_params, _socket) do
    Logger.error("#{__MODULE__} connect error: no token provided")
    :error
  end

  def verify(socket, token),
    do:
      Phoenix.Token.verify(
        socket,
        "user salt",
        token,
        # 1 day in seconds
        max_age: 86400
      )
  def id(%{assigns: %{user_id: user_id}}), do: "auth_socket:#{user_id}"
end
