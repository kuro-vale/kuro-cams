defmodule KuroCamsWeb.HomeControllerTest do
  use KuroCamsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Home"
  end
end
