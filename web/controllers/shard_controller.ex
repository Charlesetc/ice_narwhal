
defmodule IceNarwhal.ShardController do
  use IceNarwhal.Web, :controller

  alias IceNarwhal.Shard

  def create(conn, %{"shard" => params}) do

    # bunch of logic has to go here
    # # is it the right user's post?

    changeset = conn.assigns[:current_user]
      |> build_assoc(:shard)
      |> Fragment.changeset(params)

    case Repo.insert(changeset) do
      {:ok, fragment} ->
        conn
        |> put_flash(:info, "#{fragment.label} created!")
        |> redirect(to: fragment_path(conn, :show, fragment))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
