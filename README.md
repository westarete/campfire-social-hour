# Campfire Social Hour

This is an app that listens to a collection of Zoom rooms and displays a live-updating list of all participants in those rooms. It allows virtual conferences the means to offer a "social hour" where attendees can find each other and talk.

## Development Setup 

This app is written in Phoenix and requires an Elixir/Erlang development environment. The versions that it was coded against are in the `.tool-versions` file, which is compatible with [asdf](http://asdf-vm.com).

Next, copy the config files for dev and test modes:

```shell
$ cp dotenv.example .env.dev
$ cp dotenv.example .env.test
```

The values for these configuration files are discussed below

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Customization for your event

This app currently does not use a relational database. Instead, the list of meetings is hardcoded in the aptly named `CampfireSocialHour.Meetings.Hardcoded` module which can be found in `lib/campfire_social_hour/meetings/hardcoded.ex`. Open that module and change it to return as many meetings as you desire. Each room needs a name, a url, and Zoom's id for that room—the samed ID that is in the URL. For example if the Zoom meeting URL is this: https://us02web.zoom.us/j/86376488264?pwd=abc123 then the ID would be 86376488264.

## App Configuration

There are a few ENV variables that must be configured for this to work. In dev and test modes, these values can be entered into the respective `config/{env}.secret.exs` files. In test mode you can just use fake values. In production mode, it is expected that these will be in ENV variables.

For the `ZOOM_*` secrets below, the only person who can read those values in the Zoom management dashboard is the person who created the app, nobody else can. If you do not have access to the dashboard, in the 1PW Developers vault for Campfire Social Hour App Secrets for the values.

| Variable           | Purpose                                                      |
| ------------------ | ------------------------------------------------------------ |
| ZOOM_SECRET_TOKEN | A token that Zoom includes when it sends webhooks to us, which allows us to authenticate that the hook is actually coming from Zoom. This is available in Zoom's app configuration where you set up the webhooks. |
| ZOOM_ACCOUNT_ID | The Zoom Server-to-server Oauth App's Account ID. This is available in the Zoom app's configuration screen. |
| ZOOM_CLIENT_ID | The Zoom Server-to-server Oauth App's Client ID. This is available in the Zoom app's configuration screen. |
| ZOOM_CLIENT_SECRET | The Zoom Server-to-server Oauth App's Client Secret. This is available in the Zoom app's configuration screen. |
| MEETING_SECRET     | Any string value that you want to use to obfuscate the meeting dashboard view. For example if you set this value to "crankstations" then the meetings dashboard will be accessible at https://your.app/meetings/crankstations |
| THEME | Can be set to `techextra` or `campfire` and changes the theme accordingly. |
| SECRET_KEY_BASE | Phoenix secret key base. See runtime.exs |
| PHX_LOG_LEVEL | Optional. If set, allows you to change the log level in production. Default if unset is `info` but can be set to `debug` for example. |
| PHX_HOST | The host the site is running at. Note that this must be a subdomain of `westarete.com` or runtime.exs needs to be updated as well. (For example, `basecamp2037.westarete.com`). Since this changes from event to event, it must be set to match whatever DNS host is configured in Route 52 as well as Gigalixer. |

## Zoom Configuration

Once the ZOOM_ACCOUNT_ID, ZOOM_CLIENT_ID, and ZOOM_CLIENT_SECRET ENV variables are set, the application will automatically negotiate an Oauth access token on startup and handle refreshing it automatically when necessary.

The next step is to set up webhooks, which Zoom also has a guide for [setting up webhooks](https://developers.zoom.us/docs/api/rest/webhook-reference/#set-endpoint-url). Provide the URL for this app running in production and be sure to set the ZOOM_SECRET_TOKEN ENV variable which is provided in the zoom app's page. Once set, you can hit the "Verify" button in the Zoom interface to verify the webhook. You will want to subscribe to the following hooks:

* Start meeting

* End meeting

* Participant/host joined meeting

* Participant/host left meeting

  

Ready to run in production? Please [check Phoenix's deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
