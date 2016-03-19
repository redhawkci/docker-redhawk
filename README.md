# REDHAWK docker
A basic [Docker](https://www.docker.com/) image of a [REDHAWK](http://redhawksdr.org) development environment.

The image can be pulled from the [Docker Hub Registry](https://registry.hub.docker.com/u/redhawkci/redhawk/)

Both the OMNI Naming Service and OMNI Event services are started by default and managed via supervisor. 
```sh
docker run --detach --name=redhawk-2.0 --restart=always redhawkci/redhawk:2.0-el6
```

To connect to the running container:
```sh
docker exec -it redhawk-2.0 bash
```
