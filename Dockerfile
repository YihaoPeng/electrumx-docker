FROM ubuntu
MAINTAINER followtheart "followtheart@outlook.com"

# use aliyun source
ADD sources-aliyun.com.list /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y software-properties-common --no-install-recommends \
    && add-apt-repository -y ppa:jonathonf/python-3.6 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       python3.6 python3.6-dev libleveldb-dev wget git \
       libssl-dev daemontools nano build-essential \
    && rm /usr/bin/python3 \
    && ln -s /usr/bin/python3.6 /usr/bin/python3 \
    && wget https://bootstrap.pypa.io/get-pip.py -O- | python3.6 \
    && pip install scrypt \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  \
    && mkdir /log /db /env \
    && useradd -s /bin/bash -m electrumx \
    && cd /home/electrumx \
    && git clone https://github.com/UnitedBitcoin/electrumx.git \
    && chown -R electrumx:electrumx electrumx && cd electrumx \
    && chown -R electrumx:electrumx /log /db /env \
    && python3.6 setup.py install

USER electrumx

VOLUME /db /log /env

COPY env/* /env/

RUN cd ~ \
    && mkdir -p ~/service ~/scripts/electrumx \
    && cp -R ~/electrumx/contrib/daemontools/* ~/scripts/electrumx \
    && chmod +x ~/scripts/electrumx/run \
    && chmod +x ~/scripts/electrumx/log/run \
    && sed -i '$d' ~/scripts/electrumx/log/run \
    && sed -i '$a\exec multilog t s500000 n10 /log' ~/scripts/electrumx/log/run  \
    && cp /env/* /home/electrumx/scripts/electrumx/env/ \
    && ln -s ~/scripts/electrumx  ~/service/electrumx

USER root

CMD ["bash","-c","cp /env/* /home/electrumx/scripts/electrumx/env/ && svscan /home/electrumx/service"]
