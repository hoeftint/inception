FROM debian:bullseye

RUN apt-get update -y && apt-get install mariadb-server -y

COPY .tools/entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]