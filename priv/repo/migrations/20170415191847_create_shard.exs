defmodule IceNarwhal.Repo.Migrations.CreateShard do
  use Ecto.Migration

  def change do
    create table(:shards) do
      add :kind, :string
      add :content, :string
      add :fragment_id, references(:fragments, on_delete: :nothing)
      add :shard_id, references(:shards, on_delete: :nothing)

      timestamps()
    end
    create index(:shards, [:fragment_id])
    create index(:shards, [:shard_id])

  end
end
