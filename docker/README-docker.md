# VERA Docker stack

The docker stack for vera consists of three components:

1. The python backend
2. The mariadb 10.1 web database
3. The Yii based web interface

These components are encapsulated into the [docker compose file](./docker-compose.yaml) and [Makefile](./Makefile)

## Building the python backend image

The python backend server has numerous dependencies. These are mostly captured in its [Dockerfile](./PythonBackend.dockerfile). For now, some of the assets downloaded are mounted by the stack as a volume.

`liblinear{,-python}` is installed via debian, though we could switch to using the later packages inside assets.

To build the docker image, do: 

    docker build -t vera:1.0.0 -f ./PythonBackend.dockerfile .

This must be run in the top-level directory of the project; otherwise, you may need to change the paths or build context as the [requirements.txt](./requirements.txt) file is required.

For now, since we don't have a private docker registry, you will need to ensure that this image is available locally.

## Database prep

The DB is initialized using dump file provided [here](./web_interface/initial.sql), which is provided the standard mariadb image. This is mounted in as a volume at runtime to the docker stack and only run if there is no extant DB on the db data volume (per the rules in the docker image). 

Therefore, for any changes here to stick, you need to delete the old volume from the swarm!

## Web interface

The web interface uses the Yii _2.0_ images, but that's good enough for us.

The docker local DNS hostname (`webdb`) and password are _hardcoded_ into the Yii app as the connection string. 

TODO(nimish): these params should be injected in via env vars.

Yii 1.1 is EoL in 2020 so we need to move from it soon!

TODO(nimish): move to Flask

## Deploying the stack

For now, I'll assume we have a docker swarm set up with just one node. Multiple nodes need a coherent registry.


To deploy the stack:

    docker stack deploy -c ./docker-compose.yaml vera

To remove the stack and associated ephemeral components (networks, but NOT volumes, for example):

    docker stack rm vera

The stack is very simple and standardized. However, the bind mounts set inside it assume you are working in the project root directory. This is very important as Yii needs access to the runtime directory. We could switch to producing fully self-contained docker containers as our deployable, but that's a decent amount of work and would require CI + CD (TBD) as well as a registry.

## Ports and such

The web interface is set to listen to `8080` (inside the container: `80`). The mariadb is set to listen on `3306`. The python backend listens on `21320`. 

If all goes well, just navigate to http://localhost:8080 after the stack is up.

TODO(nimish): these ports should be injected in at runtime.

## TODO(nimish): assets

You also need to set up the assets directory using the scripts; it's bind mounted into the containers as a volume.

## TODO(nimish): Make

For convenience, the [Makefile](./Makefile) provides commands that automate some of the above. This is a WIP and you should understand what it runs before using it!











