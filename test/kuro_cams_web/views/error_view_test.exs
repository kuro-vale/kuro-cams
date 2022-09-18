defmodule KuroCamsWeb.ErrorViewTest do
  use KuroCamsWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 403.html" do
    assert render_to_string(KuroCamsWeb.ErrorView, "403.html", []) =~ "Forbidden page"
  end

  test "renders 404.html" do
    assert render_to_string(KuroCamsWeb.ErrorView, "404.html", []) =~ "Page not found."
  end

  test "renders 500.html" do
    assert render_to_string(KuroCamsWeb.ErrorView, "500.html", []) =~ "Something bad happen"
  end
end
