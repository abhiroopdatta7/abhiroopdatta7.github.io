[< Docker](docker.md)

## Commads

### Image

#### List
```sh
docker iamges
```
or
```sh
docker image ls
```

#### Pull
```sh
docker pull ${image-name}
```

#### Remove
```sh
docker rmi ${containor-id}
```



### Containers

#### Run

```sh
docker run --rm --name ${container-name} ${image-name}:${tag}
```

#### List

```sh
docker ps
```

or

```sh
docker container ls
```

The above command will only show the list of containers running. To show all the containers: 

```sh
docker ps -a
```

#### Pause

```sh
docker pause ${containor-id}
```

#### Unpause

```sh
docker unpause ${containor-id}
```

#### Stop

```sh
docker stop ${containor-id}
```

#### Start

```sh
docker start ${containor-id}
```

#### Attach
```sh
docker attach ${containor-id}
```

#### Kill

```sh
docker kill ${containor-id}
```

#### Remove
Removes the Docker Container.
```sh
docker rm ${containor-id}
```

#### Stats
```sh
docker stats ${containor-id}
```

#### Inspect
Shows the Information for the container.
```sh
docker inspect ${containor-id}
```

#### Top
Shows top-level processes within the container.
````sh
docker top ${containor-id}
````

#### Save
Save the Docker image to a local file.
```sh
docker save ${image} -o ${filename}
```

#### Load
Load Docker image from file
```sh
docker load ${filename}
```
