# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ice_narwhal,
  ecto_repos: [IceNarwhal.Repo]

# Configures the endpoint
config :ice_narwhal, IceNarwhal.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jFHPrDBS5cnZ35bLXqn33ME+47YIQ7OVl9SzWZ9AtnHKeWIOnlYMT8oLbiKXK0ub",
  render_errors: [view: IceNarwhal.ErrorView, accepts: ~w(html json)],
  pubsub: [name: IceNarwhal.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
 issuer: "IceNarwhal.#{Mix.env}",
 ttl: {30, :days},
 verify_issuer: true,
 serializer: IceNarwhal.GuardianSerializer,
 secret_key: to_string(Mix.env) <> "There are never enough cool things to go around right?!!! io1 0k"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
