defmodule Chowmonger.API.V1.UserTest do
  use Chowmonger.ModelCase

  alias Chowmonger.API.V1.User

  @valid_attrs %{email: "blah@blah.com", name: "some content", password: "some content", password_confirmation: "some content"}
  @invalid_attrs [
    %{email: "blah", name: "something", password: "blergh", password_confirmation: "blergh"},
    %{email: "blah@blah.com", name: "", password: "asdfghaoeij", password_confirmation: "asdfghaoeij"},
    %{email: "blah@blah.com", name: "something", password: "blerg", password_confirmation: "blerg"},
    %{email: "blah@blah.com", name: "something", password: "somepassword", password_confirmation: "diffpass"},
    %{}
  ]

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    Enum.each @invalid_attrs, fn(attrs) ->
      changeset = User.changeset(%User{}, attrs)
      refute changeset.valid?
    end
  end
end
