FROM jupyter/notebook

RUN apt-get install wget
RUN wget -q -O- https://s3.amazonaws.com/download.fpcomplete.com/ubuntu/fpco.key | apt-key add -
RUN echo 'deb http://download.fpcomplete.com/ubuntu/trusty stable main'| tee /etc/apt/sources.list.d/fpco.list

RUN apt-get update && \
    apt-get install stack magic libmagic-dev liblapack-dev libblas-dev libgtk-3-dev libtinfo-dev -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /srv/

WORKDIR /srv/
RUN git clone --depth=1 --branch=master https://github.com/gibiansky/IHaskell.git

WORKDIR /srv/IHaskell
RUN stack setup

RUN LANG=en_US.UTF-8 stack build
RUN LANG=en_US.UTF-8 stack install

WORKDIR /tmp
