FROM ubuntu:18.04 as steamcmd
LABEL maintainer="unafraid89@gmail.com"

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Sofia
ENV STEAMCMDDIR=/home/steam/steamcmd

RUN mkdir -p $STEAMCMDDIR
RUN apt update && apt-get install -y --no-install-recommends --no-install-suggests curl lib32stdc++6 lib32gcc1 ca-certificates libsdl2-2.0-0
RUN cd $STEAMCMDDIR && curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxf -
RUN $STEAMCMDDIR/steamcmd.sh +login anonymous +quit

FROM steamcmd
LABEL maintainer="unafraid89@gmail.com"

ARG STEAM_USERNAME
ARG STEAM_PASSWORD
ARG STEAM_GUARD_KEY
ARG P5_SIGHT_SEER_STEAM_ID=655780
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Sofia
ENV STEAMCMDDIR=/home/steam/steamcmd

RUN mkdir -p /home/steam/Games/Sightseer/Worlds
RUN $STEAMCMDDIR/steamcmd.sh +login "$STEAM_USERNAME" "$STEAM_PASSWORD" "$STEAM_GUARD_KEY" +force_install_dir /home/steam/Games/Sightseer/ +app_update $P5_SIGHT_SEER_STEAM_ID validate +quit

RUN apt-get install -y --no-install-recommends --no-install-suggests mono-complete
ADD docker-entrypoint.sh /docker-entrypoint.sh

RUN apt-get clean autoclean -y && apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

WORKDIR /home/steam/Games/Sightseer/Worlds/

ENTRYPOINT ["/docker-entrypoint.sh"]
