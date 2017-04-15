
defmodule IceNarwhal.FragmentController do
  use IceNarwhal.Web, :controller

  alias IceNarwhal.Fragment

  plug :load_fragment when action in [:show]
  plug :authorize_fragment when action in [:show]

  def show(conn, _) do
    render(conn, "show.html", fragment: conn.assigns[:fragment])
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

  defp load_fragment(conn, _) do
    id = conn.params["id"]
    fragment = Repo.get!(Fragment, id) |> Repo.preload(:user)
    assign(conn, :fragment, fragment)
  end

  defp authorize_fragment(conn, _) do
    if conn.assigns[:current_user] == conn.assigns[:fragment].user do
      conn
    else
      conn
      |> put_flash(:error, "That's not your page!")
      |> redirect(to: "/")
      |> halt
    end
  end

end
