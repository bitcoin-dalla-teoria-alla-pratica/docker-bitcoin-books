# Docker Bitcoin in Action
Per utilizzare questo repository, per prima cosa è necessario clonarlo.
```bash

```
Successivamente sarà necessario clonare i repositori dei libri

```bash
git clone https://github.com/bitcoin-dalla-teoria-alla-pratica/errata-corrige-e-sorgente-esempi.git --depth 1

git clone https://github.com/bitcoin-dalla-teoria-alla-pratica/Bitcoin-in-action-book.git --depth 1
```

Successivamente sarà necessario lanciare 


```git clone https://github.com/bitcoin-dalla-teoria-alla-pratica/Bitcoin-in-action-book.git --depth 1
docker-compose up
```

# Come utilizzare gli esempi del libro
Quando il container starà andando e sarete in grado di vedere i log, entrate all'interno del container con il comando

```

```

# Build and Run image

```jsx
docker build -t barno-bitcoin . && docker run -t -i -v $PWD/datadir:/root/.bitcoin -p 18443:18443 -p 18444:18444 --name barno-bitcoin-container --rm barno-bitcoin
```

# Da dentro

```jsx
docker exec -it barno-bitcoin-container bash
```

# Da fuori

## Btcdeb

```jsx
docker exec -it barno-bitcoin-container btcc OP_DUP OP_HASH160 897c81ac37ae36f7bc5b91356cfb0138bfacb3c1 OP_EQUALVERIFY OP_CHECKSIG
```

## bitcoin-cli

Root del progetto

```jsx
bitcoin-cli --datadir=$PWD/datadir --conf=$PWD/bitcoin.conf getblockchaininfo
```

# Port

### Mainnet

- JSON-RPC/REST: 8332
- P2P: 8333

### Testnet

- Testnet JSON-RPC: 18332
- P2P: 18333

### Regtest

- JSON-RPC/REST: 18443 (*since 0.16+*, otherwise *18332*)
- P2P: 18444