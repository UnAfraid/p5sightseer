# p5sightseer

Build the docker image:
```
docker build -t p5sightseer-server . --build-arg STEAM_USERNAME=your steam account --build-arg STEAM_PASSWORD=your steam password --build-arg STEAM_GUARD_KEY=the steam guard key if you have it enabled
```

Note:
In cases you have steam guard key enabled first build may take a little longer then the key duration, re-run the build and it should be fine

Then run the build image
```
docker-compose up -d
```
