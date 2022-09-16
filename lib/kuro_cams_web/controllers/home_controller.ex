defmodule KuroCamsWeb.HomeController do
  use KuroCamsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
