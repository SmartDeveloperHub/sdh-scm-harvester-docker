FROM alejandrofcarrera/phusion.maven
MAINTAINER Alejandro F. Carrera

# Exports
ENV CATALINA_HOME="/opt/tomcat" \
	TOMCAT_FOLDER="apache-tomcat-7.0.65" \
	TOMCAT="http://apache.rediris.es/tomcat/tomcat-7/v7.0.65/bin/apache-tomcat-7.0.65.tar.gz"
ENV PATH $CATALINA_HOME/bin:$PATH

ENV GITLAB_ENHANCER=http://enhancer:5000/api

# Install Tomcat 7
RUN curl -L "$TOMCAT" -o $(basename "$TOMCAT")
RUN tar -zxvf $(basename "$TOMCAT")
RUN rm $(basename "$TOMCAT")
RUN mv $TOMCAT_FOLDER $CATALINA_HOME
RUN rm $CATALINA_HOME/bin/*.bat
COPY files/tomcat-users.xml $CATALINA_HOME/conf/tomcat-users.xml

WORKDIR $CATALINA_HOME/webapps
COPY files/web.xml WEB-INF/web.xml

# Configure runit
ADD ./my_init.d/ /etc/my_init.d/
ONBUILD ADD ./my_init.d/ /etc/my_init.d/

VOLUME ["/opt/tomcat/webapps/"]
CMD ["/sbin/my_init"]

EXPOSE 8080
