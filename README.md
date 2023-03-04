# Docker Bitcoin in Action
Per utilizzare questo repository, per prima cosa è necessario clonarlo.
```bash
git clone https://github.com/bitcoin-dalla-teoria-alla-pratica/Docker-bitcoin.git --depth 1
```
Successivamente sarà necessario clonare i repositori del libro/i

```bash
git clone https://github.com/bitcoin-dalla-teoria-alla-pratica/errata-corrige-e-sorgente-esempi.git --depth 1
git clone https://github.com/bitcoin-dalla-teoria-alla-pratica/Bitcoin-in-action-book.git -b docker --depth 1
```

Infine dobbiamo lanciare il comando


```bash

docker-compose up

```

# Come utilizzare gli esempi del libro
Ipotizziamo di voler replicare l'esempio del capitolo 3 `P2SH - P2PK`

Entriamo dentro il container
```bash

docker exec -it bitcoindocker-bitcoin-in-action-1 zsh

```
Successivamente ci muoviamo dentro il Capitolo 3
```bash
cd Bitcoin-in-action-book
cd Capitolo\ 3
cd P2SH\ -\ P2PK
./main.sh
```

