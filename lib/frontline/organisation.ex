defmodule Frontline.Organisation do
  use Ecto.Schema

  @primary_key {:organisation_id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "organisations" do
    field :name

    has_many :organisations_users, Frontline.OrganisationUser, foreign_key: :organisation_id
    has_many :users, through: [:organisations_users, :users]

    timestamps()
  end
end
