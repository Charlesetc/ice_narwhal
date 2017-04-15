defmodule IceNarwhal.PageController do
  use IceNarwhal.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
