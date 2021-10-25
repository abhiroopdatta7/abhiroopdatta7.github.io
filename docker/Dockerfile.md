[< Docker](README.md)

# Dockerfile

## Dockerfile instructions

### FROM

The `FROM` instruction initializes a new build stage and sets the [*Base Image*](https://docs.docker.com/glossary/#base-image) for subsequent instructions. As such, a valid `Dockerfile` must start with a `FROM` instruction. The image can be any valid image.

From formats are:

```dockerfile
FROM [--platform=<platform>] <image> [AS <name>]
```

Or

```dockerfile
FROM [--platform=<platform>] <image>[:<tag>] [AS <name>]
```

Or

```dockerfile
FROM [--platform=<platform>] <image>[@<digest>] [AS <name>]
```

Example:

```dockerfile
FROM ubuntu:20.04
```



### LABEL

You can add labels to your image to help organize images by project, record licensing information, to aid in automation, or for other reasons. For each label, add a line beginning with `LABEL` and with one or more key-value pairs. 

```dockerfile
LABEL org.label-schema.vendor="ABC INC."
LABEL maintainer="dev@abc.com"
LABEL org.label-schema.name="docker-image-project1"
LABEL org.label-schema.description="Run time for Project-1"
LABEL org.label-schema.url="http://github.com/abc/project1"

```



### RUN

RUN has 2 forms:

- `RUN <command>` (*shell* form, the command is run in a shell, which by default is `/bin/sh -c` on Linux or `cmd /S /C` on Windows)
- `RUN ["executable", "param1", "param2"]`

The `RUN` instruction will execute any commands in a new layer on top of the current image and commit the results. The resulting committed image will be used for the next step in the `Dockerfile`.

Layering `RUN` instructions and generating commits conforms to the core concepts of Docker where commits are cheap and containers can be created from any point in an image’s history, much like source control.

The *exec* form makes it possible to avoid shell string munging, and to `RUN` commands using a base image that does not contain the specified shell executable.

```dockerfile
RUN /bin/bash -c 'source $HOME/.bashrc; echo $HOME'
```

Or,

```
RUN ["/bin/bash", "-c", "echo hello"]
```

### CMD

The `CMD` instruction has three forms:

- `CMD ["executable","param1","param2"]` (*exec* form, this is the preferred form)
- `CMD ["param1","param2"]` (as *default parameters to ENTRYPOINT*)
- `CMD command param1 param2` (*shell* form)

```dockerfile
FROM


Learn more about the "FROM" Dockerfile command. ubuntu
CMD echo "This is a test." | wc -
```

Or,

```dockerfile
FROM ubuntu
CMD ["/usr/bin/wc","--help"]
```



### EXPOSE

```dockerfile
EXPOSE <port> [<port>/<protocol>...]
```

The `EXPOSE` instruction informs Docker that the container listens on the specified network ports at runtime. You can specify whether the port listens on TCP or UDP, and the default is TCP if the protocol is not specified.

The `EXPOSE` instruction does not actually publish the port. To actually publish the port when running the container, use the `-p` flag on `docker run` to publish and map one or more ports.

```dockerfile
EXPOSE <port> [<port>/<protocol>...]
```

By default, `EXPOSE` assumes TCP. You can also specify UDP.

```dockerfile
EXPOSE 80/tcp
EXPOSE 80/udp
```

### ENV

The `ENV` instruction sets the environment variable `<key>` to the value `<value>`. This value will be in the environment for all subsequent instructions in the build stage and can be [replaced inline](https://docs.docker.com/engine/reference/builder/#environment-replacement) in many as well. 

```dockerfile
ENV <key>=<value> ...
```

Example:

```dockerfile
DEBIAN_FRONTEND=noninteractive
```

### ADD or COPY

```dockerfile
ADD [--chown=<user>:<group>] <src>... <dest>
ADD [--chown=<user>:<group>] ["<src>",... "<dest>"]
```

The `ADD` instruction copies new files, directories or remote file URLs from `<src>` and adds them to the filesystem of the image at the path `<dest>`.

```dockerfile
ADD test.txt relativeDir/
```

```
ADD --chown=55:mygroup files* /somedir/
ADD --chown=bin files* /somedir/
ADD --chown=1 files* /somedir/
ADD --chown=10:11 files* /somedir/
```

### ENTRYPOINT

An `ENTRYPOINT` allows you to configure a container that will run as an executable.

ENTRYPOINT has two forms:

The *exec* form, which is the preferred form:

```dockerfile
ENTRYPOINT ["executable", "param1", "param2"]
```

The *shell* form:

```dockerfile
ENTRYPOINT command param1 param2
```

Command line arguments to `docker run <image>` will be appended after all elements in an *exec* form `ENTRYPOINT`, and will override all elements specified using `CMD`. This allows arguments to be passed to the entry point, i.e., `docker run <image> -d` will pass the `-d` argument to the entry point. You can override the `ENTRYPOINT` instruction using the `docker run --entrypoint` flag.

```dockerfile
FROM ubuntu
ENTRYPOINT ["top", "-b"]
CMD ["-c"]
```

### VOLUME

The `VOLUME` instruction creates a mount point with the specified name and marks it as holding externally mounted volumes from native host or other containers. The value can be a JSON array, `VOLUME ["/var/log/"]`, or a plain string with multiple arguments, such as `VOLUME /var/log` or `VOLUME /var/log /var/db`.

```dockerfile
VOLUME ["/data"]
```

```dockerfile
FROM ubuntu
RUN mkdir /myvol
RUN echo "hello world" > /myvol/greeting
VOLUME /myvol
```

This Dockerfile results in an image that causes `docker run` to create a new mount point at `/myvol` and copy the `greeting` file into the newly created volume.

### USER

If a service can run without privileges, use `USER` to change to a non-root user. Start by creating the user and group in the `Dockerfile` with something like `RUN groupadd -r postgres && useradd --no-log-init -r -g postgres postgres`.

### WORKDIR

For clarity and reliability, you should always use absolute paths for your `WORKDIR`. Also, you should use `WORKDIR` instead of proliferating instructions like `RUN cd … && do-something`, which are hard to read, troubleshoot, and maintain.

```dockerfile
WORKDIR /path/to/workdir
```

## ARG

The `ARG` instruction defines a variable that users can pass at build-time to the builder with the `docker build` command using the `--build-arg <varname>=<value>` flag. If a user specifies a build argument that was not defined in the Dockerfile, the build outputs a warning.

```dockerfile
ARG <name>[=<default value>]
```

Example:

```dockerfile
ARG BUILD_BASE_IMAGE=ubuntu:18.04
FROM $BUILD_BASE_IMAGE
```

Then, the image can be build with this command:

```dockerfile
docker build --build-arg BUILD_BASE_IMAGE=ubuntu:20.04 .
```

### ONBUILD

The `ONBUILD` instruction adds to the image a *trigger* instruction to be executed at a later time, when the image is used as the base for another build. The trigger will be executed in the context of the downstream build, as if it had been inserted immediately after the `FROM` instruction in the downstream `Dockerfile`.

```dockerfile
ONBUILD <INSTRUCTION>
```

### SHELL

The `SHELL` instruction allows the default shell used for the *shell* form of commands to be overridden. The default shell on Linux is `["/bin/sh", "-c"]`, and on Windows is `["cmd", "/S", "/C"]`. 

```dockerfile
SHELL ["executable", "parameters"]
```

Example:

```dockerfile
FROM ubuntu:20.04
RUN echo default
SHELL ["/bin/bash", "-command"]
RUN echo default
```

### STOPSIGNAL

The `STOPSIGNAL` instruction sets the system call signal that will be sent to the container to exit. This signal can be a signal name in the format `SIG<NAME>`, for instance `SIGKILL`, or an unsigned number that matches a position in the kernel’s syscall table, for instance `9`. The default is `SIGTERM` if not defined.

```dockerfile
STOPSIGNAL signal
```

## Single Stage

```dockerfile
# syntax=docker/dockerfile:1
FROM ubuntu:20.04
COPY . /app
RUN make /app
CMD python /app/app.py
```

Each instruction creates one layer:

- `FROM` creates a layer from the `ubuntu:20.04` Docker image.
- `COPY` adds files from your Docker client’s current directory.
- `RUN` builds your application with `make`.
- `CMD` specifies what command to run within the container.

## Multi-Stage

```dockerfile
ARG BUILD_BASE_IMAGE
ARG RUN_BASE_IMAGE
ARG VERSION

FROM $BUILD_BASE_IMAGE AS builder
USER root
WORKDIR /home/build/app
COPY . .
RUN make

FROM $RUN_BASE_IMAGE
USER root
WORKDIR /home/app
ENV VERSION=$VERSION
ENV LD_LIBRARY_PATH=/usr/local/lib/x86_64-linux-gnu:/usr/local/lib/
COPY --from=builder /home/build/app .
ENTRYPOINT "/home/app/bin-app"

```



## Note:

### Exclude with .dockerignore

To exclude files not relevant to the build (without restructuring your source repository) use a `.dockerignore` file. This file supports exclusion patterns similar to `.gitignore` files. For information on creating one, see the [.dockerignore file](https://docs.docker.com/engine/reference/builder/#dockerignore-file).

### Don’t install unnecessary packages

To reduce complexity, dependencies, file sizes, and build times, avoid installing extra or unnecessary packages just because they might be “nice to have.” For example, you don’t need to include a text editor in a database image.

### Decouple applications

Each container should have only one concern. Decoupling applications into multiple containers makes it easier to scale horizontally and reuse containers. For instance, a web application stack might consist of three separate containers, each with its own unique image, to manage the web application, database, and an in-memory cache in a decoupled manner.

Limiting each container to one process is a good rule of thumb, but it is not a hard and fast rule. For example, not only can containers be [spawned with an init process](https://docs.docker.com/engine/reference/run/#specify-an-init-process), some programs might spawn additional processes of their own accord. For instance, [Celery](https://docs.celeryproject.org/) can spawn multiple worker processes, and [Apache](https://httpd.apache.org/) can create one process per request.

Use your best judgment to keep containers as clean and modular as possible. If containers depend on each other, you can use [Docker container networks](https://docs.docker.com/network/) to ensure that these containers can communicate.

### Minimize the number of layers

In older versions of Docker, it was important that you minimized the number of layers in your images to ensure they were performant. The following features were added to reduce this limitation:

- Only the instructions `RUN`, `COPY`, `ADD` create layers. Other instructions create temporary intermediate images, and do not increase the size of the build.
- Where possible, use [multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/), and only copy the artifacts you need into the final image. This allows you to include tools and debug information in your intermediate build stages without increasing the size of the final image.