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

RUN service docker start

# RUN curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose \
# &&  curl -L https://download.docker.com/linux/debian/dists/stretch/pool/stable/amd64/docker-ce_18.09.9~3-0~debian-stretch_amd64.deb -o /usr/local/bin/docker-ce.deb \
# &&  dpkg -i /usr/local/bin/docker-ce.deb \
# &&  service docker start


RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
USER jenkins
