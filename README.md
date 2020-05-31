Check what is going to a container in case it is up, but you cannot access it:
```
docker logs --tail 50 --follow --timestamps <container>
```

Check port status using PowerShell
```shell script
netstat -aon | findstr '3000'
```

Starting rails server from the Docker container:
```shell script
rails server -b 0.0.0.0
```
or
```shell script
docker exec <container> rails server -b 0.0.0.0
```

Checking all docker volumes 
```shell script
docker volume inspect $(docker volume ls -q)
```

Possible solution for remote debugging:
- https://europepmc.github.io/techblog/rails/2017/11/03/rubymine-remote-debug-rails-in-docker.html
```
rdebug-ide --host 0.0.0.0 --port 1234 --dispatcher-port 26162 -- bin/rails s
```

Completely wipe out your docker doing:
```shell script
docker rm -f $(docker ps -aq)
docker image rm -f $(docker image ls -q)
docker volume rm $(docker volume ls -q)
docker network rm $(docker network ls -q)
```
