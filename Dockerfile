FROM php:8.2-fpm

SHELL ["/bin/bash", "-c"]

RUN chmod 1777 /tmp
RUN  apt-get update -y && apt-get install -y procps 
 
#add user and group
RUN groupadd -f www-data && \
    (id -u www-data &> /dev/null || useradd -G www-data www-data -D)

#assign the created user same UID AND GUID OF the host for the mounted dir owner
ARG UID
ARG GID
 
RUN usermod -u $UID www-data
RUN groupmod -g $GID www-data

EXPOSE 9000

