defmodule IceNarwhal.UserTest do
  use IceNarwhal.ModelCase

  alias IceNarwhal.User

  @valid_attrs %{password_hash: "some content", tag: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
