# V Rising Server on Linux

Runs a [V Rising](https://playvrising.com/) server on Linux using Wine in
Docker. There are a few other similar projects on GitHub but none fit my
requirements.

## Features

* Built on Debian 11 for portability
* Uses a non-root user for security
* Only includes the necessary packages `curl`, `wine`, and `xvfb` to bootstrap
* Simple `Dockerfile` and `docker-compose.yml` files
* One step deployment that creates a valid server on localhost
* Stores Steam, the V Rising server, and V Rising data in separate volumes so
each part can be updated independently

## Configuration

You should replace the `ServerGameSettings.json` and `ServerHostSettings.json`
in the [settings directory](settings) with your own, otherwise a standard PvE
server will be created. If the settings directory is empty then it will create a
PvP server using the V Rising built-in defaults which is not recommended.

See the [StunlockStudios/vrising-dedicated-server-instructions](https://github.com/StunlockStudios/vrising-dedicated-server-instructions)
for more information on how to configure these settings.

## Build and Deploy

Building the container and deploying the service is simple.

### Build

```sh
docker build . --tag vrising-docker
docker swarm init || true  # this only needs to be run once
```

### Deploy

```sh
docker stack deploy -c docker-compose.yml vrising-docker
```

There is also a [`Makefile`](Makefile) with shortcuts to these commands to build
and deploy the server more easily.
