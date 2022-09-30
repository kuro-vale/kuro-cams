# KuroCams

[![Tests](https://github.com/kuro-vale/kuro-cams/actions/workflows/tests.yml/badge.svg)](https://github.com/kuro-vale/kuro-cams/actions/workflows/tests.yml)
[![Lint](https://github.com/kuro-vale/kuro-cams/actions/workflows/lint.yml/badge.svg)](https://github.com/kuro-vale/kuro-cams/actions/workflows/lint.yml)

Video chat app made with Phoenix Framework

### Features
- Tailwind template [Windmill](https://github.com/estevanmaito/windmill-dashboard)
- Basic authentication and authorization
- Real-time chat via WebSockets
- Store chats in private rooms
- Track users' presence
- Peer to Peer webRTC VideoCall using [PeerJs](https://github.com/peers/peerjs)

## Docker image

You can run this project by building the Dockerfile or docker-compose or using this [prebuilt image](https://hub.docker.com/r/kurovale/kuro-cams)

## Quick Setup

  * Install dependencies with `mix deps.get`
  * Set postgres db environment variable DEV_DATABASE_URL="ecto://user:pass@host:5432/db"
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
