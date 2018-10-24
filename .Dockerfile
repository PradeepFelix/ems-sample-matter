
#pull centos image from docker hub
FROM centos


ENV JAVA_VERSION 8u31
ENV BUILD_VERSION b13

#setting up wget package manager so that we can install java

RUN yum -y upgrade
RUN yum -y install wget


# Downloading & Config Java 8
RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/11.0.1+13/90cf5d8f270a4347a95050320eef3fb7/jdk-11.0.1_linux-x64_bin.rpm" -O jdk-11.0.1_linux-x64_bin.rpm


RUN yum -y install jdk-11.0.1_linux-x64_bin.rpm
RUN alternatives --install /usr/bin/java jar /usr/java/latest/bin/java 200000
RUN alternatives --install /usr/bin/javaws javaws /usr/java/latest/bin/javaws 200000
RUN alternatives --install /usr/bin/javac javac /usr/java/latest/bin/javac 200000



RUN wget http://mirror.cogentco.com/pub/apache/tomcat/tomcat-8/v8.0.53/bin/apache-tomcat-8.0.53-deployer.tar.gz

# untar and move to proper location
RUN gunzip apache-tomcat-8.0.53-deployer.tar.gz
RUN tar xvf apache-tomcat-8.0.53-deployer.tar
RUN mv apache-tomcat-8.0.53-deployer /opt/tomcat8
RUN chmod -R 755 /opt/tomcat8

ENV JAVA_HOME /opt/jdk1.8.0_53

EXPOSE 8088

CMD /opt/tomcat8/bin/catalina.sh run


#install Spring Boot artifact
#WORKDIR /
#ADD /maven/elm-matter.war elm-matter.war


#EXPOSE 8088

#CMD javaw - jar elm-matter.jar
#ENTRYPOINT ["java","-jar","elm-matter.jar"]


