defmodule Contento.Mixfile do
  use Mix.Project

  def project do
    [
      app: :contento,
      version: "0.0.1",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      build_embedded: Mix.env == :prod,
      aliases: aliases(),
      deps: deps(),
      name: "Contento Test",
      source_url: "https://github.com/contentocms/contento",
      homepage_url: "https://getcontento.com",
      description: """
      An open-source CMS built with the power of Elixir and Phoenix.
      """,
      docs: docs()
    ]
  end

  def application do
    [
      mod: {Contento.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.2"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:guardian, "~> 1.0-beta"},
      {:comeonin, "~> 4.0"},
      {:argon2_elixir, "~> 1.2"},
      {:proper_case, "~> 1.0.2"},
      {:timex, "~> 3.1"},
      {:earmark, "~> 1.2"},
      {:bamboo, "~> 0.8"},
      {:bamboo_smtp, "~> 1.4.0"},
      {:scrivener_ecto, "~> 1.2"},
      {:liquid, "~> 0.7.0"},
      {:mime, "~> 1.1"}
    ]
  end

  defp docs do
    [
      logo: "assets/static/images/logo.png",
      groups_for_modules: groups_for_modules(),
      extras: ["README.md"]
    ]
  end

  defp groups_for_modules do
    # Ungrouped Modules:

    [
      "Core": [
        Contento.Repo,
        Contento.Guardian,
        Contento.Guardian.Plug,
        Contento.Mailer,
        Contento.Mailer.Email,

        ContentoWeb.Endpoint,
        ContentoWeb.Router,
        ContentoWeb.Router.Helpers,
        ContentoWeb.Themer,
        ContentoWeb.Gettext
      ],

      "Contexts": [
        Contento.Accounts,
        Contento.Content,
        Contento.Themes,
        Contento.Settings
      ],

      "Resources": [
        Contento.Accounts.User,
        Contento.Content.Post,
        Contento.Content.Page,
        Contento.Themes.Theme,
        Contento.Settings.Setting,
      ],

      "Controllers": [
        ContentoWeb.AccountController,
        ContentoWeb.DashboardController,
        ContentoWeb.FallbackController,
        ContentoWeb.PageController,
        ContentoWeb.PostController,
        ContentoWeb.SessionController,
        ContentoWeb.SettingsController,
        ContentoWeb.ThemeController,
        ContentoWeb.UserController,
        ContentoWeb.WebsiteController
      ],

      "Views": [
        ContentoWeb.AccountView,
        ContentoWeb.DashboardView,
        ContentoWeb.ErrorView,
        ContentoWeb.LayoutView,
        ContentoWeb.PageView,
        ContentoWeb.PostView,
        ContentoWeb.SessionView,
        ContentoWeb.SettingsView,
        ContentoWeb.ThemeView,
        ContentoWeb.UserView
      ],

      "Helpers": [
        ContentoWeb.AdminHelpers,
        ContentoWeb.ErrorHelpers,
        ContentoWeb.FormHelpers,
        ContentoWeb.SessionHelpers,
        ContentoWeb.ThemeHelpers
      ],

      "Plugs": [
        ContentoWeb.Plug.AuthRequired,
        ContentoWeb.Plug.CheckUser,
        ContentoWeb.Plug.Maintenance,
        ContentoWeb.Plug.PasswordSetup,
        ContentoWeb.Plug.Settings,
        ContentoWeb.Plug.Theme,
        ContentoWeb.Plug.Website
      ],

      "Channels": [
        ContentoWeb.UserSocket
      ]
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test": ["ecto.create --quiet", "ecto.migrate", "test"],
      "post.deploy": ["ecto.migrate"],
    ]
  end
end
