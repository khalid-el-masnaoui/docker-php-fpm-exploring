# PHP-FPM container custom image

## _Custom php-fpm image with all functionalities_

Exploring docker by creating custom php-fpm with all functionalities, and mapping the container user UID with the host UID to make shared files (via volumes) accessibles.
The php-fpm service is running as a non-root (www-data user).

## PHP-FPM Configurations :gear:

The PHP-FPM image under this repository does not use default configs instead it relays on custom configurations , which you can customize them per your need underthe folder  _**/configurations**_ (php.ini is default, since we are not focusing on php-cli). PHP-FPM is running under mysql user with UID mapped to the host local user's UID


## Docker :hammer_and_wrench:
The current php-fpm service will be listening on unix socket connection.
By default, the Docker will expose ports 9000/tcp for port mappings (in case php-fpm is listening to tcp instead of unix socket connections), so change this within the
Dockerfile if necessary. When ready, simply use the Dockerfile to
build the image.

#####  Installation  :electric_plug:
Clone this repository and follow the simple steps:

```bash
# clone
$ git clone git@github.com:khalid-el-masnaoui/docker-php-fpm-exploring.git

#cd into the working diretcory
$ cd docker-php-fpm-exploring

#image build
$ docker build . -t cs-php-fpm -f Dockerfile --build-arg="UID=$(id -u)" --build-arg="GID=$(id -g)"
```

This will create the custom php-fpm image and configure the service with the custom configurations.

Once done, run the Docker image and map the port to whatever you wish on
your host. In this example, we simply use unix sockets for connections

```sh
#running the container container
$ docker run -it  --rm   --name php-fpm --mount type=bind,source=./logs,destination=/var/log/php cs-php-fpm

#the bind mounts are for developement purposes
```

Verify the php-fpm service is running correctly 

```sh
docker exec -it php-fpm bash -c "ps -ef"
#if all went will - you will be seeing something similar
UID          PID    PPID  C STIME TTY          TIME CMD
www-data       1       0  0 15:25 pts/0    00:00:00 php-fpm: master process (/usr/local/etc/php-fpm.conf)
www-data       7       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data       8       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data       9       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      10       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      11       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      12       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      13       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      14       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      15       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      16       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      17       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      18       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      19       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      20       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      21       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      22       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      23       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      24       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      25       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      26       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      27       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      28       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      29       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      30       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      31       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      32       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      33       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      34       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      35       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      36       1  0 15:25 pts/0    00:00:00 php-fpm: pool www
www-data      37       0 33 15:25 pts/1    00:00:00 ps -ef
```

