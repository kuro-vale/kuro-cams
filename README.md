# KuroCams

[![Tests](https://github.com/kuro-vale/kuro-cams/actions/workflows/tests.yml/badge.svg)](https://github.com/kuro-vale/kuro-cams/actions/workflows/tests.yml)
[![Lint](https://github.com/kuro-vale/kuro-cams/actions/workflows/lint.yml/badge.svg)](https://github.com/kuro-vale/kuro-cams/actions/workflows/lint.yml)

> [![PWD](https://raw.githubusercontent.com/play-with-docker/stacks/master/assets/images/button.png)](https://labs.play-with-docker.com/?stack=https://raw.githubusercontent.com/kuro-vale/kuro-cams/main/pwd-stack.yml) !!! Some web browser block cameras for non HTTPS websites, play with docker may not be a good fit to fully test the app

Video chat app made with Phoenix Framework

### Features
- Tailwind template [Windmill](https://github.com/estevanmaito/windmill-dashboard)
- Basic authentication and authorization
- Real-time chat via WebSockets
- Store chats in private rooms
- Track users' presence
- Peer to Peer webRTC VideoCall using [PeerJs](https://github.com/peers/peerjs)

## Screenshots
#### Home
![Screenshot_20230105_171453](https://user-images.githubusercontent.com/87244716/210890494-a656a376-3982-48d3-99be-6a5b1e5d922a.png)
#### Chats
![Screenshot_20230105_171530](https://user-images.githubusercontent.com/87244716/210890565-33c159c5-68e8-4034-bdf4-33b72ad2d754.png)
#### Video Chats (Schizophrenia moment HAHAHA)
![Screenshot_20230105_172546](https://user-images.githubusercontent.com/87244716/210892053-2622d4d5-e14e-4a80-89fe-ef14e8edbed9.png)


## Deploy

Follow any of these methods and open http://localhost:4000/ to see the WebApp.

### Docker

Run the command below to quickly deploy this project on your machine, see the [docker image](https://hub.docker.com/r/kurovale/kuro-cams) for more info.

```bash
docker run -d -p 4000:4000 kurovale/kuro-cams:sqlite
```

## Quick Setup

  * Install dependencies with `mix deps.get`
  * Set postgres db environment variable DEV_DATABASE_URL="ecto://user:pass@host:5432/db"
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
