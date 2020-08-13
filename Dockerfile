FROM centos:6
MAINTAINER testing_shinken

ENV SHINKEN_VERSION 2.4.3

EXPOSE 7767 
EXPOSE 5666
EXPOSE 8080


COPY ["tmp/*","/root/tmp/"]
#COPY ["cfg/*","/"]

RUN ["sh","-x","/root/tmp/install-package.sh"]
RUN chown -R shinken:shinken /etc/shinken/*
RUN chmod 755 /usr/lib64/nagios/plugins/*

#ENTRYPOINT ["/root/tmp/start.sh"] 
ENTRYPOINT ["/docker-entrypoint.sh"]



