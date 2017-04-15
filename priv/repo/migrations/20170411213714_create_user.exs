defmodule IceNarwhal.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :tag, :string
      add :password_hash, :string

      timestamps()
    end

  end
end
