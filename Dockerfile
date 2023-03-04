FROM debian

RUN  apt-get update \
    && apt-get install -y \
    autoconf \
    build-essential \
    bc \
    curl \
    git \
    wget \
    jq \
    libssl-dev \
    libtool \
    net-tools \
    openssl \
    python3-pip \
    pkg-config \
    procps \
    sed \
    vim \
    xxd \
    ca-certificates \
    gnupg \
    dc \
    zsh \
    && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install base58


RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.3/zsh-in-docker.sh)" -- -t robbyrussell


WORKDIR /opt

#--depth 1 last release/commit
RUN git clone https://github.com/bitcoin-core/btcdeb.git --depth 1 && \  
 cd btcdeb && \ 
./autogen.sh && \
./configure && \
make && \
make install


#RUN https://github.com/grondilu/bitcoin-bash-tools.git --depth && \
#. bitcoin-bash-tools/bitcoin.sh



#--depth 1 last release/commit
#RUN git clone https://github.com/bitcoin-dalla-teoria-alla-pratica/errata-corrige-e-sorgente-esempi.git --depth 1 && \  
#git clone https://github.com/bitcoin-dalla-teoria-alla-pratica/Bitcoin-in-action-book.git --depth 1

#ENV PATH="${PATH}:/opt/Bitcoin-in-action-book/Utility:/opt/btcdeb"



ARG VERSION=24.0
#https://github.com/bitcoin/bitcoin/blob/master/contrib/verify-commits/trusted-keys
ARG BITCOIN_CORE_SIGNATURE=71A3B16735405025D447E8F274810B012346C9A6
ARG ARCH=x86_64



RUN cd /tmp \
    && gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys ${BITCOIN_CORE_SIGNATURE} \
    && wget https://bitcoincore.org/bin/bitcoin-core-${VERSION}/SHA256SUMS.asc \
    https://bitcoincore.org/bin/bitcoin-core-${VERSION}/SHA256SUMS \
    https://bitcoincore.org/bin/bitcoin-core-${VERSION}/bitcoin-${VERSION}-${ARCH}-linux-gnu.tar.gz \
    && gpg --verify --status-fd 1 --verify SHA256SUMS.asc SHA256SUMS 2>/dev/null | grep "^\[GNUPG:\] VALIDSIG.*${BITCOIN_CORE_SIGNATURE}\$" \
    && sha256sum --ignore-missing --check SHA256SUMS \
    && tar -xzvf bitcoin-${VERSION}-${ARCH}-linux-gnu.tar.gz -C /opt \
    && /opt/bitcoin-${VERSION}/bin/test_bitcoin --show_progress \
    && rm /opt/bitcoin-${VERSION}/bin/bitcoin-qt && rm -Rf /tmp/* \
    && cp /opt/bitcoin-${VERSION}/bin/bitcoin* /usr/local/bin/. 



COPY bitcoin.conf /opt/bitcoin.conf
RUN echo "export PATH=$PATH:/opt/Bitcoin-in-action-book/Utility:/opt/btcdeb" >> ~/.bashrc
RUN echo "export PATH=$PATH:/opt/Bitcoin-in-action-book/Utility:/opt/btcdeb" >> ~/.zshrc


COPY "entrypoint.sh" /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
