defmodule Frontline.ShiftsTest do
  use Frontline.DataCase

  alias Frontline.Organisation
  alias Frontline.OrganisationUser
  alias Frontline.Repo
  alias Frontline.Shift
  alias Frontline.User

  test "create shift for user if organisation_id matches" do
    organisation =
      Repo.insert!(%Organisation{
        name: "Org#{System.unique_integer()}"
      })

    user =
      Repo.insert!(%User{
        organisation_id: organisation.organisation_id,
        name: "Usr#{System.unique_integer()}"
      })

    Repo.insert!(%OrganisationUser{user: user, organisation: organisation})

    Repo.insert!(%Shift{
      organisation_id: organisation.organisation_id,
      user: user,
      name: "Shf#{System.unique_integer()}"
    })
  end

  test "fail to create shift for user if organisation_id differs" do
    organisation1 =
      Repo.insert!(%Organisation{
        name: "Org#{System.unique_integer()}"
      })

    organisation2 =
      Repo.insert!(%Organisation{
        name: "Org#{System.unique_integer()}"
      })

    user =
      Repo.insert!(%User{
        organisation_id: organisation1.organisation_id,
        name: "Usr#{System.unique_integer()}"
      })

    Repo.insert!(%OrganisationUser{user: user, organisation: organisation1})

    assert_raise Ecto.ConstraintError, fn ->
      Repo.insert!(%Shift{
        organisation_id: organisation2.organisation_id,
        user: user,
        name: "Shf#{System.unique_integer()}"
      })
    end
  end
end
