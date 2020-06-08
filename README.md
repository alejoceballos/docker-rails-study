Check what is going to a container in case it is up, but you cannot access it:
```
docker logs --tail 50 --follow --timestamps <container>
```

Checking all docker volumes 
```shell script
docker volume inspect $(docker volume ls -q)
```

Completely wipe out your docker doing:
```shell script
docker rm -f $(docker ps -aq)
docker image rm -f $(docker image ls -q)
docker volume rm $(docker volume ls -q)
docker network rm $(docker network ls -q)
```

Note, some aliases come in handy:
```shell script
alias d=docker
alias dc=docker-compose
alias dx='winpty docker exec -it'
alias dockerwipethemall='docker rm -f $(docker ps -aq) ; docker image rm -f $(docker image ls -q) ; docker volume rm $(docker volume ls -q) ; docker network rm $(docker network ls -q)' 
```
