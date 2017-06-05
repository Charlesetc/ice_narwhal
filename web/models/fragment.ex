defmodule IceNarwhal.Fragment do
  use IceNarwhal.Web, :model

  schema "fragments" do
    field :label, :string
    belongs_to :user, IceNarwhal.User
    has_many :shards, IceNarwhal.Shard

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:label])
    |> validate_required([:label])
    |> assoc_constraint(:user)
  end

end
