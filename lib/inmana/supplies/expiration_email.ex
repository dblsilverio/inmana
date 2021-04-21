defmodule Inmana.Supplies.ExpirationEmail do
  import Bamboo.Email

  alias Inmana.Supply

  def create(to_email, expired_supplies) do
    new_email(
      to: to_email,
      from: "app@inmana.com",
      subject: "Supplies about to expire",
      text_body: email_text(expired_supplies)
    )
  end

  defp email_text(supplies) do
    initial_text = "--- Supplies about to expired ---\n"

    Enum.reduce(supplies, initial_text, fn elem, acc ->
      acc <> supply_string(elem)
    end)
  end

  defp supply_string(%Supply{
         description: description,
         expiration_date: expiration_date,
         responsible: responsible
       }) do
    "Description: #{description}, Expiration Date: #{expiration_date}, Responsible: #{responsible}\n"
  end
end
