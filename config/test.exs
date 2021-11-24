import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :campfire_social_hour, CampfireSocialHourWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "OX5vqXi2Wh2+lhWu+Fev3y8YwWV9pib6N1Od6Djed2fvXxvtslwrDdP/tFRdxnN5",
  server: false

# In test we don't send emails.
config :campfire_social_hour, CampfireSocialHour.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Use a mocked version of the Zoom API pollers, that do not actually hammer the zoom api
config :campfire_social_hour,
  meetings_poller_adapter: CampfireSocialHour.Poller.MeetingsPoller.Mock,
  participants_poller_adapter: CampfireSocialHour.Poller.ParticipantsPoller.Mock

config :tesla, adapter: Tesla.Mock

# Conveniently import secrets in dev/test mode.
# In production, these are loaded from ENV variables in config/runtime.exs
import_config "test.secret.exs"
