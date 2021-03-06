alias Contento.{Settings, Themes, Accounts}

now = fn -> DateTime.utc_now() end

Accounts.create_user(%{
  "name" => "Default User",
  "handle" => "contento",
  "email" => "contento@example.org",
  "password" => "contento"
})

Themes.create_theme(%{
  "id" => 1,
  "alias" => "simplo",
  "name" => "Simplo",
  "description" => "Simple theme",
  "inserted_at" => now.(),
  "updated_at" => now.(),
  "setting_id" => 1,
})

Settings.create_settings(%{
  "id" => 1,
  "website_title" => "An Awesome Website",
  "website_description" => "Random Opinions and Ideas",
  "theme_id" => 1
})
