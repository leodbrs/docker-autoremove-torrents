FROM python:3.8.5-slim

WORKDIR /app

RUN apt-get update \
    && apt-get install cron -y -q \
    && pip install autoremove-torrents \
    && apt-get clean

ADD cron.sh /usr/bin/cron.sh
RUN chmod +x /usr/bin/cron.sh

RUN touch /var/log/autoremove-torrents.log

COPY config.example.yml config.yml

ENV OPTS='-c /app/config.yml'
ENV CRON='*/5 * * * *'

ENTRYPOINT ["/bin/sh", "/usr/bin/cron.sh"]