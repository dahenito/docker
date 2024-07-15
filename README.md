# docker

This repo introduces new [subcommands](docs/app.md) to the [docker cli](https://github.com/docker/cli) for managing docker applications.

A docker "application" (app) is any binary with optional set of auxiliary files specified by a Dockerfile that can execute natively on the host (including docker itself). These new subcommands facilitate the building and distribution of these apps.

For app examples, please see: [https://github.com/dahenito](https://github.com/dahenito)

To get started, check out this [PR](https://github.com/docker/cli/pull/5240) and build for your host arch. This is one time only and would not be necessary if the new commands become part of the standard docker cli.

```bash
git clone https://github.com/qiangli/docker-cli.git app
cd app/
git checkout 5239-app-command

docker buildx bake
```

If successful, the new docker cli with app support `docker app` should be available under `build/`.

Build again and install the new docker cli as app into the default location `$DOCKER_APP_BASE` (~/.docker/app/)

```bash
build/docker app install --privileged -v /var/run/docker.sock:/var/run/docker.sock https://github.com/dahenito/docker.git
```

After installation is completed, add the new docker cli to your `PATH`

```bash
export PATH=~/.docker/app/bin:$PATH
```

Now you should be able to build and install apps on your local file system or hosted on any web site.

```bash
docker app install https://github.com/dahenito/go.git@1.22.5
docker app install https://github.com/dahenito/node.git
docker app install https://github.com/dahenito/python.git
```
