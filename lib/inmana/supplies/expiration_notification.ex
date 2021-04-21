defmodule Inmana.Supplies.ExpirationNotification do
  alias Inmana.Supplies.{ExpirationEmail, GetByExpiration}
  alias Inmana.Mailer

  def send() do
    data = GetByExpiration.call()

    Enum.each(data, fn {to_email, expired_supplies} ->
      to_email
      |> ExpirationEmail.create(expired_supplies)
      |> Mailer.deliver_later!()
    end)
  end
end
