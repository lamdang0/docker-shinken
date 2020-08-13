# docker-shinken
 
BUILD
------------------------------------------------------------
docker build -t shinken .

RUN
------------------------------------------------------------
docker run -itd \
-v $(pwd)/cfg/shinken/:/etc/shinken \
-v $(pwd)/cfg/nrpe.d/:/etc/nrpe.d \
-v $(pwd)/cfg/custom_plugins/:/usr/lib64/nagios/plugins \
-h shinkend \
-p 5666:5666 \
-p 7767:7767 \
-p 8080:8080 \
--name shinken shinken

RESTART DAEMON
------------------------------------------------------------
docker exec -it -u 0 shinken /restart

START DAEMON
------------------------------------------------------------
docker exec -it -u 0 shinken /start

STOP DAEMON
------------------------------------------------------------
docker exec -it -u 0 shinken /stop
