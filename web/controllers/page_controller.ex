defmodule IceNarwhal.PageController do
  use IceNarwhal.Web, :controller

  def index(conn, _params) do
    current_user = conn.assigns.current_user |> Repo.preload(:fragments)
    if current_user do
      render conn, "home.html", current_user: current_user
    else
      render conn, "index.html"
    end
  end
end
