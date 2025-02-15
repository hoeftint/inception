FROM debian:bullseye

COPY ./tools/entrypoint.sh /
RUN chmod +x /entrypoint.sh

RUN apt-get update -y && apt-get upgrade -y && apt-get install mariadb-server tini -y

# Allow remote connections from network
RUN sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

ENTRYPOINT ["tini", "--", "./entrypoint.sh"]