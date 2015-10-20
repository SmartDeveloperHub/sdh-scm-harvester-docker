FROM alejandrofcarrera/phusion.maven
MAINTAINER Alejandro F. Carrera

# Exports
ENV HARVESTER_HOME="/opt/scm-harvester"
ENV GITLAB_ENHANCER="http://192.168.0.10:5000/api"

COPY files/pom.xml $HARVESTER_HOME/pom.xml

# Configure runit
ADD ./my_init.d/ /etc/my_init.d/
ONBUILD ADD ./my_init.d/ /etc/my_init.d/

WORKDIR /opt/scm-harvester
RUN mvn

CMD ["/sbin/my_init"]

EXPOSE 80
