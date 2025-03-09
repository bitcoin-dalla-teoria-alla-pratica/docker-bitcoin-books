FROM debian:12-slim

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG VERSION=28.1

# Determina automaticamente l'architettura corretta
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then echo "ARCH=x86_64" >> /etc/environment; fi \
    && if [ "$TARGETPLATFORM" = "linux/arm64" ]; then echo "ARCH=aarch64" >> /etc/environment; fi 

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
    python3-base58 \
    && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.3/zsh-in-docker.sh)" -- -t robbyrussell

WORKDIR /opt

# Clona e compila btcdeb
RUN git clone https://github.com/bitcoin-core/btcdeb.git --depth 1 && \  
    cd btcdeb && \ 
    ./autogen.sh && \
    ./configure && \
    make && \
    make install

# Scarica e verifica Bitcoin Core per l'architettura corretta
RUN set -e; \      
    export ARCH=$(grep ARCH /etc/environment | cut -d '=' -f2); \
    cd /tmp; \
    apt-get update && apt-get install -y dirmngr; \
    gpg --batch --keyserver hkps://keyserver.ubuntu.com --recv-keys \
        101598DC823C1B5F9A6624ABA5E0907A0380E6C3 \
        152812300785C96444D3334D17565732E08E5E41 \
        E61773CD6E01040E2F1BD78CE7E2984B6289C93A \
        9DEAE0DC7063249FB05474681E4AED62986CD25D \
        C388F6961FB972A95678E327F62711DBDCA8AE56 \
        9D3CC86A72F8494342EA5FD10A41BDC3F4FAFF1C \
        637DB1E23370F84AFF88CCE03152347D07DA627C \
        F2CFC4ABD0B99D837EEBB7D09B79B45691DB4173 \
        E86AE73439625BBEE306AAE6B66D427F873CB1A3 \
        F19F5FF2B0589EC341220045BA03F4DBE0C63FB4 \
        F4FC70F07310028424EFC20A8E4256593F177720 \
        A0083660F235A27000CD3C81CE6EC49945C17EA6 \
        0CCBAAFD76A2ECE2CCD3141DE2FFD5B1D88CA97D || { echo "Errore nell'importazione delle chiavi GPG"; exit 1; }; \
    wget -q https://bitcoincore.org/bin/bitcoin-core-${VERSION}/SHA256SUMS.asc \
             https://bitcoincore.org/bin/bitcoin-core-${VERSION}/SHA256SUMS \
             https://bitcoincore.org/bin/bitcoin-core-${VERSION}/bitcoin-${VERSION}-${ARCH}-linux-gnu.tar.gz || { echo "Errore nel download dei file"; exit 1; }; \
    gpg --verify SHA256SUMS.asc SHA256SUMS || { echo "Verifica della firma GPG fallita"; exit 1; }; \
    sha256sum --ignore-missing --check SHA256SUMS || { echo "Verifica SHA256 fallita"; exit 1; }; \
    tar -xzvf bitcoin-${VERSION}-${ARCH}-linux-gnu.tar.gz -C /opt || { echo "Errore nell'estrazione"; exit 1; }; \
    /opt/bitcoin-${VERSION}/bin/test_bitcoin --show_progress || { echo "Test Bitcoin Core fallito"; exit 1; }; \
    rm /opt/bitcoin-${VERSION}/bin/bitcoin-qt && rm -Rf /tmp/*; \
    cp /opt/bitcoin-${VERSION}/bin/bitcoin* /usr/local/bin/.


COPY bitcoin.conf /opt/bitcoin.conf
# Imposta il PATH per btcdeb e utility
COPY bitcoin.conf /opt/bitcoin.conf
RUN echo "export PATH=$PATH:/opt/Bitcoin-in-action-book/Utility:/opt/btcdeb" >> ~/.bashrc
RUN echo "export PATH=$PATH:/opt/Bitcoin-in-action-book/Utility:/opt/btcdeb" >> ~/.zshrc

COPY "entrypoint.sh" /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
