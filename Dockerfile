FROM jenkins:latest

USER root

RUN cat /etc/debian_version
RUN uname -r

RUN apt-get update \
&& apt-get install -y apt-transport-https \
&& apt-get install -y sudo \
&& apt-get install -y ca-certificates \
&& apt-get install -y curl \
&& apt-get install -y software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable edge test"

RUN apt-get update \
&&  apt-get install -y docker-compose \
&&  apt-get install -y docker-ce \
&&  apt-get install -y docker-ce-cli

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

USER jenkins
COPY plugins.txt /usr/local/bin/plugins.txt

# RUN cd /usr/local/bin; install-plugins.sh ./plugins.txt
RUN /usr/local/bin/install-plugins.sh /usr/share/jenkins/plugins.txt
