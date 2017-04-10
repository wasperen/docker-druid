# docker-druid

A docker image to run Druid version 0.9.2 (http://druid.io).

The entrypoint.sh takes the following commands:

* init - which (re-)initializes the Druid configuration.

Or, to start up a Druid service:
* broker
* historical
* coordinator
* middleManager
* overlord

This project also includes a docker-compose file to spin up a druid cluster using the default configurations that 
are downloaded from http://static.druid.io/artifacts/releases/druid-0.9.2-bin.tar.gz

## example usage
Using `docker-compose` you can spin up the whole cluster on a docker machine (or cluster).

`docker-compose up`

This will bring up five containers -- one for each of the services -- and connect them up within a virtual network.

Use `docker-compose down' to bring the cluster back down and destroy the containers. (NB: you will lose any data if you have not taken additional measures to prevent this. For instance by creating volumes or hooking up with HDFS.)

## volumes
To persist storage between container destroys, you will need to connect the following volumes to persistent storage:
_TODO_

## plugins
Currently there are no plugin being installed. This is just the bare-bone default implementation.