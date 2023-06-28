FROM ubuntu:22.04

# should be overwritten by build args on linux systems
ARG USER_ID=1000
ARG USER_GROUP_ID=1000

ARG USER_NAME="mlagents"
ARG GROUP_NAME=$USER_NAME

# prevent questions from apt-get install, etc.
ENV DEBIAN_FRONTEND=noninteractive

COPY initial_scripts/ /tmp/scripts/

RUN /tmp/scripts/configure_apt.sh

# setup system language
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN /tmp/scripts/apt_install.sh ca-certificates sudo git locales tzdata
RUN /tmp/scripts/setup_locale.sh
RUN /tmp/scripts/setup_timezone.sh

# setup a user
RUN addgroup --gid $USER_GROUP_ID mlagents
RUN adduser --uid $USER_ID --gid $USER_GROUP_ID --gecos "" $USER_NAME
RUN usermod -aG sudo $USER_NAME

# copy the other scripts - split up to reduce rebuild times
COPY scripts/ /tmp/scripts/
RUN /tmp/scripts/apt_install.sh python3 python3-pip python3-venv

ENTRYPOINT [ "/bin/bash", "/tmp/scripts/entrypoint.sh", "${USER_NAME}" ]
