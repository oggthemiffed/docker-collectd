# docker-collectd

A simple container that will run an instance of collectd allowing a instance of collectd to be run.

The main uses of this are:
* A simple way to test scripts that are being developed as plugins
* Run as a containerised instance that can run as a container in a production environment, to collect data about the docker, remote services and other items.
* A runner container to run custom plugins.

## Running the container

To get a simple container running just run the following command
```
docker run \ 
    -v /path/to/host/config/folder:/opt/collectd/extra-configs \
    pibcak/docker-collectd:latest
```

This will run the container with no configured collectors.

## Configuring connectors

To configure a connector we can supply a set of configuration files (standard collectd configuration files). 

Within these files you can use jinja2 templating