FROM bitnami/minideb:stretch
#
# BUILD:
#   wget https://raw.githubusercontent.com/iwconfig/minideb-cups-iPF5000/master/Dockerfile
#   docker build --rm --no-cache -t minideb-cups-iPF5000 .
#
# USAGE:
#   wget https://raw.githubusercontent.com/iwconfig/minideb-cups-iPF5000/master/start_cups.sh
#   ./start_cups.sh
#

# Set metadata
LABEL maintainer="Leonard Högström <snelhingst@gmail.com>"
LABEL version="1.0"
LABEL description="Creates an Minideb container serving a CUPS instance accessible through airplay as well, with support for Canon iPF5000 large format printer."

# Set environment
ENV LANG en_US.UTF-8
ENV TERM xterm

# Install CUPS/AVAHI, syslogd and 32bit glibc.
RUN apt-get update && install_packages libc6-i386 cups avahi-daemon inotify-tools inetutils-syslogd

# Create and go to tmp dir
WORKDIR /tmp/cprint

# Copy CPrint package and module
COPY w98c4mux.tar.gz w995mux.tar.gz ./

# Install CPrint package and module
RUN tar --strip-components=1 -xf w98c4mux.tar.gz && tar --strip-components=1 -xf w995mux.tar.gz \
    && ./setup && ./setup_iPF5000 \
    && rm -rf /tmp/cprint

# Set workdir
WORKDIR /opt/cups

# Copy configuration files
COPY root /

# Prepare CUPS container
RUN chmod 755 /srv/run.sh

# Expose SMB printer sharing
EXPOSE 137/udp 139/tcp 445/tcp

# Expose IPP printer sharing
EXPOSE 631/tcp

# Expose avahi advertisement
EXPOSE 5353/udp

# Start CUPS instance
CMD ["/srv/run.sh"]
