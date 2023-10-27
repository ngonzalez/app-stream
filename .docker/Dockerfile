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

# entrypoint
COPY .docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

WORKDIR /app

COPY ../../rails .

RUN chown -R $USER: /app

ARG env_name="development"
ENV RAILS_ENV $env_name

ARG RAILS_LOG_TO_STDOUT="true"
ENV RAILS_LOG_TO_STDOUT $RAILS_LOG_TO_STDOUT

ARG COVERAGE="true"
ENV COVERAGE $COVERAGE

ARG COVERAGE_METHOD="line"
ENV COVERAGE_METHOD $COVERAGE_METHOD

# bundler
ARG BUNDLER_VERSION="2.4.20"
ENV BUNDLER_VERSION $BUNDLER_VERSION
RUN su -c "gem install bundler --no-document -v $BUNDLER_VERSION" $USER
RUN su -c "bundle install" $USER

ENTRYPOINT []

ARG puma_port="3000"
ENV PUMA_PORT $puma_port

EXPOSE $PUMA_PORT
CMD ["/usr/bin/entrypoint.sh", "--server"]
