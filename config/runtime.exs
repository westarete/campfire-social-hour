import Config
import Dotenvy

source([".env", ".env.#{config_env()}", System.get_env()])

config :campfire_social_hour,
  secret_token: env!("ZOOM_SECRET_TOKEN", :string!),
  meeting_secret: env!("MEETING_SECRET", :string!),
  account_id: env!("ZOOM_ACCOUNT_ID", :string!),
  client_id: env!("ZOOM_CLIENT_ID", :string!),
  client_secret: env!("ZOOM_CLIENT_SECRET", :string!),
  theme: env!("THEME", :string!)

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.
if config_env() == :prod do
  # The secret key base is used to sign/encrypt cookies and other secrets.
  # A default value is used in config/dev.exs and config/test.exs but you
  # want to use a different value for prod and you most likely don't want
  # to check this value into version control, so we use an environment
  # variable instead.
  secret_key_base = env!("SECRET_KEY_BASE", :string!)
  host = env!("PHX_HOST", :string!)
  port = env!("PORT", :integer!)

  config :campfire_social_hour, CampfireSocialHourWeb.Endpoint,
    url: [host: host, port: 80],
    check_origin: ["//campfire-social-hour.gigalixirapp.com", "//*.westarete.com"],
    http: [
      # Enable IPv6 and bind on all interfaces.
      # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
      # See the documentation on https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html
      # for details about using IPv6 vs IPv4 and loopback vs public addresses.
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base

  # ## Using releases
  #
  # If you are doing OTP releases, you need to instruct Phoenix
  # to start each relevant endpoint:
  #
  #     config :campfire_social_hour, CampfireSocialHourWeb.Endpoint, server: true
  #
  # Then you can assemble a release by calling `mix release`.
  # See `mix help release` for more information.

  # ## Configuring the mailer
  #
  # In production you need to configure the mailer to use a different adapter.
  # Also, you may need to configure the Swoosh API client of your choice if you
  # are not using SMTP. Here is an example of the configuration:
  #
  #     config :campfire_social_hour, CampfireSocialHour.Mailer,
  #       adapter: Swoosh.Adapters.Mailgun,
  #       api_key: System.get_env("MAILGUN_API_KEY"),
  #       domain: System.get_env("MAILGUN_DOMAIN")
  #
  # For this example you need include a HTTP client required by Swoosh API client.
  # Swoosh supports Hackney and Finch out of the box:
  #
  #     config :swoosh, :api_client, Swoosh.ApiClient.Hackney
  #
  # See https://hexdocs.pm/swoosh/Swoosh.html#module-installation for details.

  config :logger,
    level: env!("PHX_LOG_LEVEL", :atom?, :info)
end
