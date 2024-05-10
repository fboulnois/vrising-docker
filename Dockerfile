FROM debian:12-slim

ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get install -y curl wine xvfb \
  && rm -rf /var/lib/apt/lists/*

RUN useradd -m vrising \
  && mkdir -p /home/vrising/.wine/drive_c/SteamCmd \
  && mkdir -p /home/vrising/.wine/drive_c/VRisingData \
  && mkdir -p /home/vrising/.wine/drive_c/VRisingServer \
  && curl https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip | zcat > /home/vrising/.wine/drive_c/SteamCmd/steamcmd.exe \
  && chown -R vrising:vrising /home/vrising/.wine

ENV WINEPATH="C:\\SteamCmd;C:\\VRisingServer" \
  SteamAppId=1604030

USER vrising

WORKDIR /home/vrising

EXPOSE 9876/udp
EXPOSE 9877/udp

STOPSIGNAL SIGINT

COPY docker-entrypoint.sh /usr/local/bin
COPY settings/ /home/vrising

ENTRYPOINT [ "docker-entrypoint.sh" ]
