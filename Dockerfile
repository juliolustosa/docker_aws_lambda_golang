FROM amazonlinux:2017.03.1.20170812

# Instala pacotes base
RUN yum install -y \
    ca-certificates \
    curl \
    binutils \
    findutils \
    gcc \
    gcc-c++ \
    gcc64 \
    gcc64-c++ \
    gcc72 \
    gcc72-c++ \
    tar \ 
    gzip \
    make \
    openssl \
    git \
    python27 \
    python27-pip \
    openssh-clients

# Instala o GoLang
RUN curl https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz > /tmp/golang.tar.gz
RUN tar -C /usr/local -xzf /tmp/golang.tar.gz

# Instala o Cliente AWS
RUN pip install --upgrade pip
RUN pip install awscli

ENV GOPATH /go
ENV GOBIN "$GOPATH/bin"
ENV GOLIBS "$GOPATH/lib"
ENV INSTALL_DIRECTORY "/usr/local/go/bin"
ENV GOOS "linux"
ENV DEP_OS "linux"
ENV DEP_ARCH "x86_64"
ENV PATH "$PATH:/usr/local/go/bin:$GOPATH/bin"

# Cria diretorios
RUN mkdir -p "$GOPATH/src" "$GOBIN" "$GOLIBS" && chmod -R 777 "$GOPATH"

# Instala o GODEP
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh > install_godep.sh
RUN chmod +x install_godep.sh && \
    ./install_godep.sh \
    && rm install_godep.sh

RUN rm -rf /tmp/*
WORKDIR $GOPATH