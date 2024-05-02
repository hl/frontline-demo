defmodule Frontline.User do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "users" do
    field :organisation_id, Ecto.UUID
    field :name

    has_many :organisations_users, Frontline.OrganisationUser
    has_many :organisations, through: [:organisations_users, :organisations]

    has_many :shifts, Frontline.Shift

    timestamps()
  end
end
