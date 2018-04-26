defmodule ContentoWeb.WebsiteController do
  use ContentoWeb, :controller

  alias Contento.Accounts
  alias Contento.Content
  alias Contento.Themer

  plug :put_layout, false
  plug :put_view, false

  action_fallback ContentoWeb.FallbackController

  def index(conn, _params) do
    page = Content.get_page(slug: "home")
    do_render(conn, 200, "index", page: page)
  end

  def blog(conn, params) do
    data = Content.list_posts(params)

    do_render(conn, 200, "index",
      posts: data.entries, 
      page_number: data.page_number,
      page_size: data.page_size, 
      total_pages: data.total_pages,
      total_entries: data.total_entries
    )
  end

  def page_or_post(conn, assigns, :page_title) do
    cond do
      page = assigns[:page] ->
        page.title
      post = assigns[:post] ->
        post.title
      true ->
        nil
    end
  end
  def page_or_post(conn, %{"slug" => slug} = _params) do
    cond do
      page = Content.get_page(slug: slug) ->
        template = if page_template = page.template, do: page_template,
                                                     else: "page"

        do_render(conn, 200, template, page: page)
      post = Content.get_post(slug: slug) ->
        do_render(conn, 200, "post", post: post)
      true ->
        {:error, :website_not_found}
    end
  end

  def author(conn, %{"handle" => handle}) do
    if user = Accounts.get_user(handle: handle) do
      do_render(conn, 200, "author", author: user)
    end
  end

  def assets(conn, %{"file" => file}) do
    filepath = Path.join(["priv/themes/", conn.assigns[:settings].theme.alias, "assets"] ++ file)

    if File.exists?(filepath) && !File.dir?(filepath) do
      mime = MIME.from_path(filepath)

      conn
      |> put_resp_header("Content-Type", mime)
      |> send_file(200, filepath)
    else
      {:error, :website_not_found}
    end
  end

  defp do_render(conn, status, template, assigns \\ []) do
    body = Themer.render(conn, template, assigns)

    conn
    |> put_resp_header("Content-Type", "text/html")
    |> send_resp(status, body)
  end
end
