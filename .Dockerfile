
#pull centos image from docker hub
FROM centos

#setting up wget package manager so that we can install java
RUN yum -y upgrade
RUN yum -y install wget


# Downloading Java 
RUN wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/11.0.1+13/90cf5d8f270a4347a95050320eef3fb7/jdk-11.0.1_linux-x64_bin.rpm" -O jdk-11.0.1_linux-x64_bin.rpm

#installing java
RUN yum -y install jdk-11.0.1_linux-x64_bin.rpm

#installing tomcat 
WORKDIR /usr/local
RUN wget http://www-us.apache.org/dist/tomcat/tomcat-9/v9.0.12/bin/apache-tomcat-9.0.12.tar.gz
RUN tar -xvf apache-tomcat-9.0.12.tar.gz
RUN mv apache-tomcat-9.0.12 tomcat
RUN echo "export CATALINA_HOME="/usr/local/tomcat"" >> ~/.bashrc
RUN source ~/.bashrc

#configuration changes required to manage tomcat - such as login screen of tomcat
ADD tomcat-users.xml /usr/local/tomcat/conf/
ADD context.xml /usr/local/tomcat/webapps/manager/META-INF/

#deploying the spring application into tomcat
ADD /maven/elms-matter.war /usr/local/tomcat/webapps/elms-matter.war

#starting up and running the tomcat service
WORKDIR /usr/local/tomcat/bin
CMD ["./catalina.sh", "run"]