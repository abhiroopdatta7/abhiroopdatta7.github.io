[< Docker](README.md)

## Commads

### Image

#### List
```she
docker iamges
```
or
```she
docker image ls
```

#### Pull
```shell
docker pull ${image-name}
```

#### Remove
```shell
docker rmi ${containor-id}
```



### Containers

#### Run

```shell
docker run --rm --name ${container-name} ${image-name}:${tag}
```

#### List

```shel
docker ps
```

or

```shell
docker container ls
```

The above command will only show the list of containers running. To show all the containers: 

```shell
docker ps -a
```

#### Pause

```shell
docker pause ${containor-id}
```

#### Unpause

```shell
docker unpause ${containor-id}
```

#### Stop

```shell
docker stop ${containor-id}
```

#### Start

```shell
docker start ${containor-id}
```

#### Attach
```shell
docker attach ${containor-id}
```

#### Kill

```shell
docker kill ${containor-id}
```

#### Remove
Removes the Docker Container.
```shell
docker rm ${containor-id}
```

#### Stats
```shell
docker stats ${containor-id}
```

#### Inspect
Shows the Information for the container.
```shell
docker inspect ${containor-id}
```

#### Top
Shows top-level processes within the container.
````shell
docker top ${containor-id}
````

#### Save
Save the Docker image to a local file.
```shell
docker save ${image} -o ${filename}
```

#### Load
Load Docker image from file
```shell
docker load ${filename}
```
