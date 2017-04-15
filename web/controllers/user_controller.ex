
defmodule IceNarwhal.UserController do
  use IceNarwhal.Web, :controller

  alias IceNarwhal.User

  plug :scrub_params, "user" when action in [:create]

  def show(conn, %{"id" => id}) do
    user = Repo.get!(IceNarwhal.User, id)
    render(conn, "show.html", user: user)
  end

  def new(conn, _) do
    changeset = IceNarwhal.User.changeset(%IceNarwhal.User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => params}) do

    changeset = %IceNarwhal.User{} |> IceNarwhal.User.registration_changeset(params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> IceNarwhal.SessionController.login(user)
        |> put_flash(:info, "#{user.tag} created!")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
