defmodule Frontline.Shift do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "shifts" do
    field :organisation_id, Ecto.UUID
    field :name

    belongs_to :user, Frontline.User

    timestamps()
  end
end
