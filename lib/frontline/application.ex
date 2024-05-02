defmodule Frontline.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FrontlineWeb.Telemetry,
      Frontline.Repo,
      {DNSCluster, query: Application.get_env(:frontline, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Frontline.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Frontline.Finch},
      # Start a worker by calling: Frontline.Worker.start_link(arg)
      # {Frontline.Worker, arg},
      # Start to serve requests, typically the last entry
      FrontlineWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Frontline.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FrontlineWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
