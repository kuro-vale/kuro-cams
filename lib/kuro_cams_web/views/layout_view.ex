defmodule KuroCamsWeb.LayoutView do
  use KuroCamsWeb, :view

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  def active_class(conn, path) do
    current_path = Path.join(["/" | conn.path_info])
    if path == current_path do
      "text-gray-800 dark:text-gray-100"
    else
      nil
    end
  end
end
