# vdx-wildfly-build-docker
Docker image to build latest VDX and WildFly

## Building
```
docker build -t "rsvoboda/fedora-maven" fedora-maven/

docker build -t vdx-wildfly-build-docker .
docker run -v ~/Downloads/vdx-wildfly-build-repos:/checkouts -it vdx-wildfly-build-docker /do-build.sh
```

## Fixing ownership
```
sudo chown -R $USER:$USER /home/$USER/Downloads/vdx-wildfly-build-repos
```

## Hints
To run just on CPUs:
```
docker run -v ~/Downloads/vdx-wildfly-build-repos:/checkouts -it --cpuset-cpus=0-1 vdx-wildfly-build-docker /do-build.sh
```
