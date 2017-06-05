defmodule IceNarwhal.Shard do
  use IceNarwhal.Web, :model

  schema "shards" do
    field :kind, :string
    field :content, :string

    belongs_to :fragment, IceNarwhal.Fragment
    belongs_to :shard, IceNarwhal.Shard
    has_many :shards, IceNarwhal.Shard

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:kind, :content])
    |> validate_required([:kind, :content])
  end
end
