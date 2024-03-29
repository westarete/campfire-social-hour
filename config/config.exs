# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configures the endpoint
config :campfire_social_hour, CampfireSocialHourWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: CampfireSocialHourWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: CampfireSocialHour.PubSub,
  live_view: [signing_salt: "HNgrGo7M"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :campfire_social_hour, CampfireSocialHour.Mailer, adapter: Swoosh.Adapters.Local

config :campfire_social_hour, zoom_api: CampfireSocialHour.ZoomApi

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure dart-sass
config :dart_sass,
  version: "1.49.11",
  default: [
    args: ~w(
      css/theme_campfire.scss:../priv/static/assets/theme_campfire.css
      css/theme_techextra.scss:../priv/static/assets/theme_techextra.css
      css/theme_berkeley.scss:../priv/static/assets/theme_berkeley.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :tesla, adapter: Tesla.Adapter.Hackney

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
