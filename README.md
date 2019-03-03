This is a fork of [thbe/docker-cups](https://github.com/thbe/docker-cups), modified to work with the Canon iPF5000 large format printer. I need support for 32bit glibc and it was difficult to get it working in Alpine which by default use musl libc. So I swiched to use [bitnami/minideb](https://github.com/bitnami/minideb) instead.

The only downside is the file size, but ~350mb is not bad. It's alright.

I've included the CPrint Core package and the iPF5000 CPrint module in this repository. See [CANON_LEGAL](./CANON_LEGAL).

# CUPS on Docker

This is a Docker image to run a CUPS instance with built in Apples zeroconf and Canon iPF5000 large format printer support.

This Docker image is based on [Minideb](https://hub.docker.com/r/_/alpine/) image from Bitnami.

#### Table of Contents

- [Install Docker](https://github.com/iwconfig/minideb-cups-iPF5000#install-docker)
- [Build image](https://github.com/iwconfig/minideb-cups-iPF5000#build-image)
- [How to use this image](https://github.com/iwconfig/minideb-cups-iPF5000#how-to-use-this-image)
- [Next steps](https://github.com/iwconfig/minideb-cups-iPF5000#next-steps)
- [Important notes](https://github.com/iwconfig/minideb-cups-iPF5000#important-notes)
- [Advanced usage](https://github.com/iwconfig/minideb-cups-iPF5000#advanced-usage)
- [Technical details](https://github.com/iwconfig/minideb-cups-iPF5000#technical-details)
- [Development](https://github.com/iwconfig/minideb-cups-iPF5000#development)

## Install Docker

To use this image you have to [install Docker](https://docs.docker.com/engine/installation/) first.

Then you build the Docker image from [source code](https://github.com/iwconfig/minideb-cups-iPF5000#build-image).

## Build image

Clone the [minideb-cups-iPF5000](https://github.com/iwconfig/minideb-cups-iPF5000) repository from GitHub:

```
git clone https://github.com/iwconfig/minideb-cups-iPF5000.git
cd minideb-cups-iPF5000
docker build --rm --no-cache -t minideb-cups-ipf5000 .
```

## How to use this image

### Environment variables

You can use two environment variables that will be recognized by the start script.

#### `CUPS_PASSWORD`

If this environment variable is set, the string will be used as the password for the `root` user.

#### `CUPS_DEBUG`

If this environment variable is set, the scripts inside the container will run in debug mode.

### Start the CUPS instance

The instance can be started by the [start script](https://raw.githubusercontent.com/iwconfig/minideb-cups-iPF5000/master/start_cups.sh)
from GitHub:

```
wget https://raw.githubusercontent.com/iwconfig/minideb-cups-iPF5000/master/start_cups.sh
export CUPS_PASSWORD='SeCre!1'
chmod 755 start_cups.sh
./start_cups.sh
```

### Check server status

You can use the standard Docker commands to examine the status of the CUPS instance:

```
docker logs --tail 1000 --follow --timestamps cups
```

## Next steps

The next release of this Docker image should have a persistent CUPS configuration.

## Important notes

The username for the print server is `root`/`password` unless you don't change the password with the environment
variable as described in the [Environment variables](https://github.com/iwconfig/minideb-cups-iPF5000#how-to-use-this-image)
section.

## Advanced usage

### Bash shell inside container

If you need a shell inside the container you can run the following command:

```
docker exec -ti cups /bin/sh
```

### Add network tools ###

If you need network tools to debug your installation use the following command:

```
docker exec -ti cups /bin/sh
install_packages iputils-arping iputils-clockdiff iputils-ping iputils-tracepath iproute2
```

## Technical details

- Minideb base image
- CUPS binary from official Debian package repository

## Development

If you like to add functions or improve this Docker image, feel free to fork the repository and send me a merge request with the modification.
