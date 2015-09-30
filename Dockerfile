FROM alejandrofcarrera/phusion.maven
MAINTAINER Alejandro F. Carrera

# Exports
ENV CATALINA_HOME="/opt/tomcat" \
	TOMCAT_FOLDER="apache-tomcat-7.0.64" \
	TOMCAT="http://ftp.cixug.es/apache/tomcat/tomcat-7/v7.0.64/bin/apache-tomcat-7.0.64.tar.gz"
ENV PATH $CATALINA_HOME/bin:$PATH

# Install Tomcat 7
RUN \
	curl -L "$TOMCAT" -o $(basename "$TOMCAT") && \
	tar -zxvf $(basename "$TOMCAT") && \
	rm $(basename "$TOMCAT") && \
	mv $TOMCAT_FOLDER $CATALINA_HOME && \
	rm $CATALINA_HOME/bin/*.bat
COPY files/tomcat-users.xml $CATALINA_HOME/conf/tomcat-users.xml

WORKDIR $CATALINA_HOME/webapps
COPY files/pom.xml pom.xml
COPY files/web.xml WEB-INF/web.xml

# Configure runit
ADD ./my_init.d/ /etc/my_init.d/
ONBUILD ./my_init.d/ /etc/my_init.d/

CMD ["/sbin/my_init"]

EXPOSE 8080
