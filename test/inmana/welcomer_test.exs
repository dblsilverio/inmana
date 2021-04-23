defmodule Inmana.WelcomerTest do
  use ExUnit.Case

  alias Inmana.Welcomer

  describe "welcome/1" do
    test "when user is special returns a special message" do
      params = %{"name" => "banana", "age" => "42"}
      expected_result = {:ok, "Special Banana"}

      result = Welcomer.welcome(params)

      assert result == expected_result
    end

    test "when user is not special returns a message" do
      params = %{"name" => "alice", "age" => "32"}
      expected_result = {:ok, "Welcome, alice"}

      result = Welcomer.welcome(params)

      assert result == expected_result
    end

    test "when user is under age returns a message" do
      params = %{"name" => "bob", "age" => "15"}
      expected_result = {:error, "Not allowed small bob"}

      result = Welcomer.welcome(params)

      assert result == expected_result
    end
  end
end
