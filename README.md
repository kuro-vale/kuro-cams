# KuroCams

This branch requires to implements a STUN / TURN server to connect peers, otherwise video calls only will work for users in the same network

## Quick Setup

  * Install dependencies with `mix deps.get`
  * Set dev database environment variable for a postgres database DEV_DATABASE_URL="ecto://user:pass@host:port/db"
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
