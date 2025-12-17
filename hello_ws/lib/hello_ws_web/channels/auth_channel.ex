defmodule HelloWsWeb.AuthChannel do
  use Phoenix.Channel
  require Logger

  def join(
        "user:" <> user_id,
        _params,
        %{assigns: %{user_id: socket_user_id}} = socket
      ) do
    if user_id == to_string(socket_user_id) do
      Logger.info("AuthChannel: User #{user_id} joined their channel.")
      {:ok, socket}
    else
      Logger.error(
        "AuthChannel: User #{socket_user_id} attempted to join channel for user #{user_id}."
      )

      {:error, %{reason: "unauthorized"}}
    end
  end
end
