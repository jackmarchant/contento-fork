alias Contento.Content

now = fn -> DateTime.utc_now() end

Content.create_page(%{
  "slug" => "about",

  "title" => "About",
  "content" => "Tell people something nice about you!",

  "published" => true,
  "published_at" => now.(),

  "author_id" => 1
})

Content.create_post(%{
  "slug" => "getting-started",

  "title" => "Getting started with Contento",
  "content" => "Hello!! This is your first post on Contento!",

  "published" => true,
  "published_at" => now.(),

  "author_id" => 1
})

Contento.Accounts.create_user(%{
  "name" => "Default User",
  "handle" => "contento",
  "email" => "contento@example.org",
  "password" => "contento"
})

Contento.Settings.create_settings(%{
  "website_title" => "An Awesome Website",
  "website_description" => "Random Opinions and Ideas",
  "theme_id" => 1
})

Contento.Themes.create_theme(%{
  "id" => 1,
  "alias" => "simplo",
  "name" => "Simplo",
  "description" => "Simple theme",
  "inserted_at" => now.(),
  "updated_at" => now.(),
  "setting_id" => 1,
})


