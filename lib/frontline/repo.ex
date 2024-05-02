defmodule Frontline.Repo do
  use Ecto.Repo,
    otp_app: :frontline,
    adapter: Ecto.Adapters.Postgres

  require Ecto.Query

  @impl true
  def prepare_query(_operation, query, opts) do
    cond do
      opts[:skip_organisation_id] || opts[:schema_migration] ->
        {query, opts}

      organisation_id = opts[:organisation_id] ->
        {Ecto.Query.where(query, organisation_id: ^organisation_id), opts}

      true ->
        raise "expected organisation_id or skip_organisation_id to be set"
    end
  end
end
