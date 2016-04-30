defmodule Chowmonger.API.V1.TokenView do
  use Chowmonger.Web, :view

  attributes [:id, :name, :email, :jwt]

  def render("error.json", _) do
    %{error: "Invalid email or password."}
  end

  def render("forbidden.json", %{error: error}) do
    %{error: error}
  end
end
