##### A generic Dockerfile for an express API application

Build:
```
docker build --tag node-express:1.0 .
```

Run in foreground:
```
docker run -p 80:9000 node-express 
-t -a stdout \
-e USER_REPO=username/repo \
--name mynodeapp
```

Run as daemon process:
```
docker run -p 80:9000 node-express \
-e USER_REPO=username/repo \
 --name mynodeapp
```
