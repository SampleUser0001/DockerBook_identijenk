FROM jenkins:latest

USER root

RUN cat /etc/apt/sources.list

# RUN echo "deb http://deb.debian.org/debian stretch main" >  /etc/apt/sources.list && \
#     echo "deb http://security.debian.org stretch/updates main" >> /etc/apt/sources.list

# RUN curl https://apt.dockerproject.org/gpg > docker.gpg.key && echo "c836dc13577c6f7c133ad1db1a2ee5f41ad742d11e4ac860d8e658b2b39e6ac1 docker.gpg.key" | sha256sum -c && apt-key add docker.gpg.key && rm docker.gpg.key

RUN echo "deb http://deb.debian.org/debian stretch main" \
         > /etc/apt/sources.list.d/docker.list \
         && gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys 28806A878AE423A28372792ED75899B9A724937A \
         && apt-get update \
         && apt-get install -y apt-transport-https \
         && apt-get install -y sudo \
         && apt-get install -y docker-engine \
         && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
USER jenkins
