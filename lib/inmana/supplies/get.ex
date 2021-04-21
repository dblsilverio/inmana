defmodule Inmana.Supplies.Get do
  alias Inmana.{Supply, Repo}

  def call(uuid) do
    # Supply
    # |> Repo.get(uuid)
    # |> handle_get()

    case Repo.get(Supply, uuid) do
      nil -> {:error, %{result: "Supply not found", status: :not_found}}
      supply -> {:ok, supply}
    end
  end

  # defp handle_get(%Supply{} = result), do: {:ok, result}
  # defp handle_get(nil), do: {:error, %{result: "Supply not found", status: :not_found}}
end
