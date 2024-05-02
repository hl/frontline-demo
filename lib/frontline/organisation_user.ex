defmodule Frontline.OrganisationUser do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "organisations_users" do
    belongs_to :organisation, Frontline.Organisation,
      foreign_key: :organisation_id,
      references: :organisation_id

    belongs_to :user, Frontline.User
    timestamps()
  end
end
