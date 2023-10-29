FROM ruby:3.3-rc-bookworm

# apt
RUN echo 'deb http://ftp.fr.debian.org/debian/ unstable main contrib non-free' > /etc/apt/sources.list
RUN apt-get update -yqq

# USER
ARG user="appuser"
ENV USER $user
RUN echo "USER=$USER" > /etc/profile.d/user.sh
RUN useradd -m $USER -s /bin/bash
RUN apt-get install -yqq sudo
RUN echo "$USER ALL=(ALL:ALL) NOPASSWD:ALL" >> /etc/sudoers

# systemd
RUN apt-get install -yq --no-install-recommends systemd systemd-sysv
FROM debian:${TAG}
COPY --from=0 / /
ENV container docker
STOPSIGNAL SIGRTMIN+3
VOLUME [ "/sys/fs/cgroup", "/run", "/run/lock" ]

# systemd: puma, sidekiq
RUN cp -f .docker/config/puma.service /etc/systemd/system/puma.service
RUN cp -f .docker/config/puma.target /etc/systemd/system/puma.target
RUN cp -f .docker/config/sidekiq.service /etc/systemd/system/sidekiq.service
RUN cp -f .docker/config/sideki.target /etc/systemd/system/sidekiq.target
RUN systemctl daemon-reload

# entrypoint
COPY .docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

WORKDIR /app

COPY ../rails .

RUN chown -R $USER: /app

ARG env_name="development"
ENV RAILS_ENV $env_name

ARG RAILS_LOG_TO_STDOUT="true"
ENV RAILS_LOG_TO_STDOUT $RAILS_LOG_TO_STDOUT

# apt dependencies
RUN apt-get install -yq ffmpeg lame libtag1-dev

# bundler
ARG BUNDLER_VERSION="2.4.20"
ENV BUNDLER_VERSION $BUNDLER_VERSION
RUN su -c "gem install bundler --no-document -v $BUNDLER_VERSION" $USER
RUN su -c "bundle install" $USER

ENTRYPOINT []

ARG puma_port="5000"
ENV PUMA_PORT $puma_port

EXPOSE $PUMA_PORT
CMD ["/usr/bin/entrypoint.sh", "--server"]
