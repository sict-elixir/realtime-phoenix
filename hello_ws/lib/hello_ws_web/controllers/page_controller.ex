defmodule HelloWsWeb.PageController do
  use HelloWsWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
