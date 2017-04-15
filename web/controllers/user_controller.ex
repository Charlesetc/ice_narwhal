
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

  def create(conn, %{"user" => user_params}) do

    changeset = %IceNarwhal.User{} |> IceNarwhal.User.registration_changeset(user_params)

    IO.puts("registration changeset:")
    IO.inspect(changeset)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> IceNarwhal.SessionController.login(user)
        |> put_flash(:info, "#{user.tag} created!")
        |> redirect(to: user_path(conn, :show, user))
      {:error, changeset} ->
        IO.inspect changeset
        render(conn, "new.html", changeset: changeset)
    end
  end

end
