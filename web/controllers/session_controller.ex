
import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

alias IceNarwhal.User

defmodule IceNarwhal.SessionController do
  use IceNarwhal.Web, :controller

  plug :scrub_params, "session" when action in [:create]

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"tag" => tag, "password" => password}}) do
    
    # here there be dragons
    user = Repo.get_by(User, tag: tag)
    result = cond do
      user && checkpw(password, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end

    case result do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "You've been logged in!")
        |> redirect(to: "/")
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid username or password!")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> logout
    |> put_flash(:info, "You've been logged out.")
    |> redirect(to: "/")
  end

  def login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(user)
  end

  defp logout(conn) do
    Guardian.Plug.sign_out(conn)
  end

end
