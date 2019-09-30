# JBake docker

Unofficial Docker Image for [JBake](http://jbake.org/).

[![Docker Repository on Quay](https://quay.io/repository/jeci/jbake-docker/status "Docker Repository on Quay")](https://quay.io/repository/jeci/jbake-docker)


## Quick Start

``` bash
mkdir jbake_sample
docker run --rm -v $PWD/jbake_sample:/data quay.io/jeci/jbake-docker:2.6 -i
docker run --rm -v $PWD/jbake_sample:/data --net=host -ti quay.io/jeci/jbake-docker:2.6
# Then go http://localhost:8820/
ls jbake_sample/output
```

Without parameter, docker run `jbake -b -s` run `-h for help`

``` bash
docker run --rm -ti quay.io/jeci/jbake-docker:2.6 -h
```

More information on [project page](https://jeci.fr/projets/jbake-docker.html)
