# AUTHOR:         Milo de Vries <milo@xdh.nl
# DESCRIPTION:    Redis with custom conf

FROM redis
COPY redis.conf /usr/local/etc/redis/redis.conf
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
