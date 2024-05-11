# V Rising Server on Linux

Runs a [V Rising](https://playvrising.com/) server on Linux using Wine in
Docker. There are a few other similar projects on GitHub but none fit my
requirements.

## Features

* Built on Debian 12 for portability
* Uses a non-root user for security
* Only includes the necessary packages `curl`, `wine`, and `xvfb` to bootstrap
* Simple `Dockerfile` and `docker-compose.yml` files
* One step deployment that creates a valid server on localhost
* Stores Steam, the V Rising server, and V Rising data in separate volumes so
each part can be updated independently

## Configuration

By default, the [settings directory](settings) is empty. You should add a
`ServerGameSettings.json` and `ServerHostSettings.json` to this directory to
configure the server. If these files are missing then a PvP server will be
created using the V Rising built-in defaults which is not recommended.

See the [StunlockStudios/vrising-dedicated-server-instructions](https://github.com/StunlockStudios/vrising-dedicated-server-instructions)
for more information on how to configure these settings.

## Build and Deploy

Building the container and deploying the service is simple.

### Build

```sh
docker compose build
```

### Deploy

```sh
docker compose up
```

There is also a [`Makefile`](Makefile) with shortcuts to these commands to build
and deploy the server more easily.

## Connect

To connect to the newly created server, go to Play -> Online Play -> PVP. Click
the `Direct Connect` button in the bottom middle of the screen. Enter `127.0.0.1`
as the Server Game Name, and make sure LAN server is **unchecked**, then click
the Connect button.
