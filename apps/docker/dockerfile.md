# Dockerfile instructions

[Dockerfile reference](https://docs.docker.com/engine/reference/builder/)

Instruction|Description
-----------|------------
`FROM <image>`|Set the base image
`FROM <image> AS <name>`|Set the base image and name the build stage
`RUN <command>`|Execute a command
`RUN ["exec", "param1", "param2"]`|Execute a command
`CMD ["exec", "param1", "param2"]`|Execute a command when the container starts
`ENTRYPOINT ["exec", "param1"]`|Configure the container to run as an executable
`ENV <key>=<value>`|Set an environment variable
`EXPOSE <port>`|Expose a port
`COPY <src> <dest>`|Copy files from source to destination
`COPY --from=<name> <src> <dest>`|Copy files from a build stage to destination
`WORKDIR <path>`|Set the working directory
`VOLUME <path>`|Create a mount point
`USER <user>`|Set the user
`ARG <name>`|Define a build argument
`ARG <name>=<default>`|Define a build argument with a default value
`LABEL <key>=<value>`|Set a metadata label
`HEALTHCHECK <command>`|Set a healthcheck command

## Best practices

* Use the official base images from https://hub.docker.com/
* Use the COPY instruction instead of ADD unless you need to extract a tar file
* Use the COPY --chown instruction to set the owner of copied files

## Build

In the directory with Dockerfile:

```sh
docker build .
```
