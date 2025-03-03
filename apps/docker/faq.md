# Docker FAQs

From https://blog.techwithpatil.com/blogs/medium-articles/devops-sre-interview-questions-and-answers/top-10-common-devops-sre-interview-questions-and-answers-on-dockerfiles


## What is the Difference Between RUN and CMD?

RUN: Executes commands during the image build process, creating a new layer. Typically used for installing software packages.

```
RUN apt-get update && apt-get install -y curl
```

CMD: Specifies the default command to run when the container starts. It executes at runtime, not during the build process.

```
CMD ["node", "app.js"]
```

## How to Use Multi-Stage Builds in Dockerfiles?

Multi-stage builds allow you to use multiple FROM statements in your Dockerfile to create temporary stages that help keep the final image smaller.

```
# Build stage
FROM golang:1.17 AS builder
WORKDIR /app
COPY . .
RUN go build -o myapp

# Production stage
FROM alpine:latest
COPY --from=builder /app/myapp /myapp
CMD ["/myapp"]
```

## What is the Purpose of the EXPOSE Instruction?

EXPOSE: Documents the ports on which the container listens at runtime. It does not publish the ports but serves as a hint for users running the container.

To make the ports accessible, use the -p flag with docker run.

```
EXPOSE 8080
```

## What is the Difference Between ARG and ENV?

ARG: Defines a variable that users can pass at build time using docker build --build-arg. It is not available at runtime.

```
ARG VERSION=1.0
RUN echo $VERSION
ENV NODE_ENV=production
```

ENV: Sets environment variables that are available both during build time and at runtime.

```
ENV NODE_ENV=production
```

## How Do You Optimize Docker Images for Size?

1. Use multi-stage builds to separate build dependencies from runtime dependencies.

```
# Build stage
FROM node:14 AS build
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .

# Production stage
FROM node:14-alpine
WORKDIR /app
COPY --from=build /app .
CMD ["node", "app.js"]
```

2. Combine commands in RUN statements to reduce the number of layers.

```
RUN apt-get update && apt-get install -y curl git
```

3. Use smaller base images, like Alpine, to minimize the image size.

## How Can You Persist Data Across Container Restarts?

Use Docker volumes or bind mounts to persist data outside of the container’s filesystem. This ensures data remains available even when the container is restarted or recreated.

```
docker run -v mydata:/data myapp
```

## What is the Purpose of the LABEL Instruction?

LABEL: Adds metadata to the image, such as maintainer information, version, or description. This helps with the documentation and management of images.

```
LABEL maintainer="you@example.com" version="1.0" description="A sample app"
```

## Why Might You Use HEALTHCHECK in a Dockerfile?

HEALTHCHECK: Defines a command to test whether the container is functioning correctly. If the health check fails, Docker can automatically restart the container or take other corrective actions.

```
HEALTHCHECK --interval=30s --timeout=5s CMD curl -f http://localhost/ || exit 1
```

## How Can You Handle Secrets in Dockerfiles?

Avoid hardcoding secrets in Dockerfiles. Instead, use Docker secrets, environment variables, or external tools like HashiCorp Vault to manage sensitive information securely.

```
ENV API_KEY=${API_KEY}
```

## What is the Difference Between CMD and ENTRYPOINT?

CMD: Provides defaults for an executing container. It can be overridden by passing arguments to docker run.

```
CMD ["nginx", "-g", "daemon off;"]
```

ENTRYPOINT: Configures a container to run as an executable. Commands and arguments provided with docker run are appended to the ENTRYPOINT instruction.

```
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
```
