defmodule Frontline.UsersTest do
  use Frontline.DataCase

  alias Frontline.Organisation
  alias Frontline.OrganisationUser
  alias Frontline.Repo
  alias Frontline.User

  test "create user" do
    organisation =
      Repo.insert!(%Organisation{
        name: "Org#{System.unique_integer()}"
      })

    Repo.insert!(%User{
      organisation_id: organisation.organisation_id,
      name: "Usr#{System.unique_integer()}"
    })
  end

  test "add user to organisation if organisation_id matches" do
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
  end

  test "fail to add user to organisation if organisation_id differs" do
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

    assert_raise Ecto.ConstraintError, fn ->
      Repo.insert!(%OrganisationUser{user: user, organisation: organisation2})
    end
  end
end
