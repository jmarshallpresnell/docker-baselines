##### A generic Dockerfile for a node application

Build:
```
docker build --tag base-node-container:1.0 .
```

Run in foreground:
```
docker run -p 80:9000 base-node-container \
-t -a stdout \
-e USER_REPO=username/repo \
--name mynodeapp
```

Run as daemon process:
```
docker run -p 80:9000 base-node-container \
-e USER_REPO=username/repo \
 --name mynodeapp
```
