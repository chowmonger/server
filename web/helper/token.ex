defmodule Chowmonger.Token do
  alias Chowmonger.Repo
  alias Chowmonger.API.V1.User

  def authenticate(%{"email" => email, "password" => password}) do
    user = Repo.get_by(User, email: String.downcase(email))

    case check_password(user, password) do
      true -> {:ok, user}
      _    -> :error
    end
  end
  def authenticate(_params), do: :error

  defp check_password(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.password_hash)
    end
  end

end
