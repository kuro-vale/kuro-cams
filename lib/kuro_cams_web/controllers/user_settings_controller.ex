defmodule KuroCamsWeb.UserSettingsController do
  use KuroCamsWeb, :controller

  def edit(conn, _params) do
    render(conn, "edit.html")
  end
end
