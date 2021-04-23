defmodule InmanaWeb.RestaurantsControllerTest do
  use InmanaWeb.ConnCase

  describe "create/2" do
    test "when all params are valid creates the user", %{conn: conn} do
      params = %{name: "Restaurant", email: "restaurant@mail.com"}

      response =
        conn
        |> post(Routes.restaurants_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "Restaurant created",
               "restaurant" => %{
                 "email" => "restaurant@mail.com",
                 "id" => _id,
                 "name" => "Restaurant"
               }
             } = response
    end

    test "when params are invalid returns an error", %{conn: conn} do
      params = %{name: "R", email: "restaurantmail.com"}

      expected_response = %{
        "errors" => %{
          "email" => ["has invalid format"],
          "name" => ["should be at least 2 character(s)"]
        }
      }

      response =
        conn
        |> post(Routes.restaurants_path(conn, :create, params))
        |> json_response(:bad_request)

      assert response == expected_response
    end
  end
end
