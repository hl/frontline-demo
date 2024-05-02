defmodule Frontline.Repo.Migrations.InitialSchema do
  use Ecto.Migration

  def change do
    # Organisations
    create table(:organisations, primary_key: false) do
      add :organisation_id, :uuid, primary_key: true, null: false
      add :name, :text
      timestamps()
    end

    # Users

    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :organisation_id, :uuid, null: false
      add :name, :text

      timestamps()
    end

    create unique_index(:users, [:id, :organisation_id])

    # OrganisationsUsers

    create table(:organisations_users, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false

      add :organisation_id,
          references(:organisations, column: :organisation_id, type: :uuid),
          null: false

      add :user_id,
          references(:users, type: :uuid, with: [organisation_id: :organisation_id]),
          null: false

      timestamps()
    end

    create unique_index(:organisations_users, [:organisation_id, :user_id])

    # Shifts

    create table(:shifts, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :organisation_id, :uuid, null: false
      add :name, :string

      add :user_id,
          references(:users, type: :uuid, with: [organisation_id: :organisation_id]),
          null: false

      timestamps()
    end
  end
end
