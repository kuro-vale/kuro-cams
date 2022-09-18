defmodule KuroCamsWeb.HomeController do
  use KuroCamsWeb, :controller

  alias KuroCams.Accounts

  def index(conn, _params) do
    users = Accounts.get_all_users()
    render(conn, "index.html", users: users)
  end
end
