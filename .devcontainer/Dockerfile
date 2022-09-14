FROM elixir:1.14-alpine

RUN apk -U upgrade && \
apk add --no-cache \
build-base \
inotify-tools \
libpq-dev \
git \
nano

RUN git config --global init.defaultBranch main
RUN mix local.hex --force
RUN mix archive.install hex phx_new --force