FROM digitalrebar/base
MAINTAINER Victor Lowther <victor@rackn.com>

# Set our command
ENTRYPOINT ["/sbin/docker-entrypoint.sh"]

VOLUME /etc/goiardi/data

# Get packages
RUN apt-get update && \
    apt-get -y install make build-essential cpanminus perl perl-doc libdbd-pg-perl jq \
                       coreutils postgresql && \
     /usr/local/go/bin/go get -v github.com/ctdk/goiardi && \
     cpanm --quiet --notest App::Sqitch && \
     mkdir -p /etc/goiardi /var/cache/goiardi && \
     apt-get -y purge make build-essential

COPY goiardi.conf /etc/goiardi/
COPY entrypoint.d/*.sh /usr/local/entrypoint.d/
COPY goiardi.json /etc/consul.d/goiardi.json
