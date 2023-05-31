# Campfire Social Hour

This is an app that listens to a collection of Zoom rooms and displays a live-updating list of all participants in those rooms. It allows virtual conferences the means to offer a "social hour" where attendees can find each other and talk.

## Development Setup 

This app is written in Phoenix and requires an Elixir/Erlang development environment. The versions that it was coded against are in the `.tool-versions` file, which is compatible with [asdf](http://asdf-vm.com).

Next, copy the config files for dev and test modes:

```shell
$ cp config/dev.secret.exs.example config/dev.secret.exs
$ cp config/test.secret.exs.example config/test.secret.exs
```

The values for these configuration files is discussed below

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Customization for your event

This app currently does not use a relational database. Instead, the list of meetings is hardcoded in the aptly named `CampfireSocialHour.Meetings.Hardcoded` module which can be found in `lib/campfire_social_hour/meetings/hardcoded.ex`. Open that module and change it to return as many meetings as you desire. Each room needs a name, a url, and Zoom's id for that room—the samed ID that is in the URL. For example if the Zoom meeting URL is this: https://us02web.zoom.us/j/86376488264?pwd=abc123 then the ID would be 86376488264.

## App Configuration

There are a few ENV variables that must be configured for this to work. In dev and test modes, these values can be entered into the respective `config/{env}.secret.exs` files. In test mode you can just use fake values. In production mode, it is expected that these will be in ENV variables.

| Variable           | Purpose                                                      |
| ------------------ | ------------------------------------------------------------ |
| ZOOM_API_JWT       | Authorization token for Zoom's REST API. You will need to create one for your app in the Zoom Marketplace |
| ZOOM_WEBHOOK_TOKEN | A token that Zoom includes when it sends webhooks to us, which allows us to authenticatet that the hook is actually coming from Zoom. This is available in Zoom's app configuration where you set up the webhooks. |
| MEETING_SECRET     | Any string value that you want to use to obfuscate the meeting dashboard view. For example if you set this value to "crankstations" then the meetings dashboard will be accessible at https://your.app/meetings/crankstations |

## Zoom Configuration

You need to create a JWT app in Zoom. This guide from Zoom's documentation for [creating a JWT app](https://marketplace.zoom.us/docs/guides/build/jwt-app) will walk you through the process. Save the JWT and add it to the configuration above.

The next step is to set up webhooks, which Zoom also has a guide for [setting up webhooks](https://marketplace.zoom.us/docs/guides/build/webhook-only-app). Provide the URL for this app running in production and be sure to save the verification token and add it to the above configuration. You will want to subscribe to the following hooks:

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
