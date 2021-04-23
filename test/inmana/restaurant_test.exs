defmodule Inmana.RestaurantTest do
  use Inmana.DataCase

  alias Inmana.Restaurant
  alias Ecto.Changeset

  describe "changeset/1" do
    test "when all parameters are valid returns a valid changeset" do
      params = %{name: "Restaurant Test", email: "test@mail.com"}

      response = Restaurant.changeset(params)

      assert %Changeset{
               changes: %{email: "test@mail.com", name: "Restaurant Test"},
               valid?: true
             } = response
    end

    test "when exists any invalid parameters return error" do
      params = %{name: "r"}

      expected_response = %{
        email: ["can't be blank"],
        name: ["should be at least 2 character(s)"]
      }

      response = Restaurant.changeset(params)

      assert %Changeset{valid?: false} = response
      assert errors_on(response) == expected_response
    end
  end
end
