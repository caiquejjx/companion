# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :companion,
  ecto_repos: [Companion.Repo]

# Configures the endpoint
config :companion, CompanionWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/umT1baTE/wDfQx0WmIUOUYsQ/Pay55vpDTrrMLoij9G3v14cOexirrJmYd3gpf4",
  render_errors: [view: CompanionWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Companion.PubSub,
  live_view: [signing_salt: "cDcqFF0E"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
