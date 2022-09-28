defmodule KuroCams.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      KuroCams.Repo,
      # Start the Telemetry supervisor
      KuroCamsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: KuroCams.PubSub},
      # Start the Endpoint (http/https)
      KuroCamsWeb.Endpoint,
      KuroCamsWeb.Presence,
      KuroCamsWeb.Stun
      # Start a worker by calling: KuroCams.Worker.start_link(arg)
      # {KuroCams.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KuroCams.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KuroCamsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
