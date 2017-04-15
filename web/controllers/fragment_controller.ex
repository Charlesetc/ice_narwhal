
defmodule IceNarwhal.FragmentController do
  use IceNarwhal.Web, :controller

  alias IceNarwhal.Fragment

  # plug :scrub_params, "user" when action in [:create]

  def show(conn, %{"id" => id}) do
    fragment = Repo.get!(Fragment, id) |> Repo.preload(:user)
    render(conn, "show.html", fragment: fragment)
  end

  def new(conn, _) do
    changeset = IceNarwhal.Fragment.changeset(%IceNarwhal.Fragment{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"fragment" => params}) do

    changeset = conn.assigns[:current_user]
      |> build_assoc(:fragments)
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
