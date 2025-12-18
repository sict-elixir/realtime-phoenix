defmodule HelloWsWeb.PageController do
  use HelloWsWeb, :controller
  require Logger


  def home(conn, _params) do
    Logger.info("Rendering home page")
    fake_user_id = 1
    conn
    |> assign(:auth_token, generate_auth_token(conn, fake_user_id))
    |> assign(:user_id, fake_user_id)
    |> render(:home)
  end

  defp generate_auth_token(conn, user_id) do
    Phoenix.Token.sign(conn, "user salt", user_id)
  end

end
