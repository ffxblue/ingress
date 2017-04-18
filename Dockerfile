FROM golang

RUN apt-get update && apt-get install mercurial

WORKDIR /go/src

COPY . /go/src

RUN go get github.com/tools/godep
RUN godep get \
      k8s.io/ingress/controllers/gce/controller \
      bitbucket.org/ww/goautoneg 

RUN apt-get install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     software-properties-common \
     python-software-properties

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

RUN apt-get update

RUN apt-get install -y \
      docker-ce

ADD docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]
