# SDH SCM Harvester Docker

Deploying and executing the __SCM Harvester Frontend__ of the *Smart Developer Hub* project with Docker.

## Usage instructions

### Building the Docker image

The first step consists in building the image defined by `Dockerfile` in the repository's root directory:

```bash
docker build -t sdh/scm-harvester .
```

### Running the container

In order to run the *SCM Harvester Frontend* it is necessary to define several environment variables:

* __HTTP_HOST__: the host through which the *SCM Harvester Frontend* will be available, so that proper dereferenciable URLs are generated. It can be specified using an IP address (*e.g.*, 192.168.99.100) or a the fully qualified domain name (*e.g.*, scmh.smartdeveloperhub.org).

* __HTTP_PORT__: the port to be used by the *SCM Harvester Frontend*. This port will have to be exposed by the container.

* __TARGET__: the GitLab Enhancer instance to be used by the *SCM Harvester Frontend*. The endpoint can be specified using an IP address (*e.g.*, http://192.168.1.33:5000/api) or a fully qualified domain name (*e.g.*, http://gitlab_enhancer.smartdeveloperhub.org:5000/api). 

Taking all of this into account a container could be executed as follows:

```bash
docker run -e "HTTP_HOST=192.168.99.100" \
           -e "HTTP_PORT=8088" \
           -e "TARGET=http://gitlab_enhancer.smartdeveloperhub.org:5000/api" \
           -p 8088:8088 \
           --name sdh-scm-harvester
           sdh/scm-harvester
```

### License

SDH-SCM-Harvester-Docker is distributed under the Apache License, version 2.0.
