Check what is going to a container in case it is up, but you cannot access it:
```
docker logs --tail 50 --follow --timestamps <container>
```

Check port status using PowerShell
```
netstat -aon | findstr '3000'
```

Starting rails server from the Docker container:
```
rails server -b 0.0.0.0
```
or
```
rdebug-ide --host 0.0.0.0 --port 1234 --dispatcher-port 26162 -- bin/rails s
```

Possible solution for remote debugging:
- https://europepmc.github.io/techblog/rails/2017/11/03/rubymine-remote-debug-rails-in-docker.html
