defmodule IceNarwhal.Repo.Migrations.UpdateUserTable do
  use Ecto.Migration

  def change do

    create unique_index(:users, [:tag])

  end
end
