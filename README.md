# vdx-wildfly-build-docker
Docker image to build latest VDX and WildFly

## Building
```
docker build -t "rsvoboda/fedora-maven" fedora-maven/

docker build -t vdx-wildfly-build-docker .
docker run -it vdx-wildfly-build-docker cat /README.md
```
