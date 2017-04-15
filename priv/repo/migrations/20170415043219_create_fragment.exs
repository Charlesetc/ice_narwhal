defmodule IceNarwhal.Repo.Migrations.CreateFragment do
  use Ecto.Migration

  def change do
    create table(:fragments) do
      add :label, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:fragments, [:user_id])

  end
end
