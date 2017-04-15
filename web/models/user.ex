defmodule IceNarwhal.User do
  use IceNarwhal.Web, :model

  schema "users" do
    field :tag, :string, unique: true
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :fragments, IceNarwhal.Fragment

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:tag, :password_hash])
    |> validate_required([:tag])
    |> unique_constraint(:tag)
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, ~w(password)a, [])
    |> hash_password
    |> validate_required([:password_hash])
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{changes: %{password: password}} ->
        put_change(changeset,
                   :password_hash,
                   Comeonin.Bcrypt.hashpwsalt(password))
      _ -> changeset
    end

  end

end
