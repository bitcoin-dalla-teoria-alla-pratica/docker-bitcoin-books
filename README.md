# Docker Bitcoin in Action

<img src="https://i.ibb.co/CsLN0J2/bitcoin-Docker.png">


Per utilizzare questo repository, per prima cosa è necessario clonarlo.
```bash
git clone https://github.com/bitcoin-dalla-teoria-alla-pratica/Docker-bitcoin.git --depth 1
cd Docker-bitcoin
```
Successivamente sarà necessario clonare i repositori del libro/i

```bash
git clone https://github.com/bitcoin-dalla-teoria-alla-pratica/errata-corrige-e-sorgente-esempi.git --depth 1 &&
git clone https://github.com/bitcoin-dalla-teoria-alla-pratica/Bitcoin-in-action-book.git --depth 1
```

Infine dobbiamo lanciare il comando


```bash

docker-compose up

```

# Come utilizzare gli esempi del libro
Ipotizziamo di voler replicare l'esempio del capitolo 3 `P2SH - P2PK`

Entriamo dentro il container.
Individuiamolo con il comando
```bash
docker ps
```
e utilizziamo il valore sotto la colonna NAMES, ad esempio
```bash

docker exec -it docker-bitcoin-bitcoin-in-action-1 zsh

```
Successivamente ci muoviamo dentro il Capitolo 3
```bash
cd Bitcoin-in-action-book
cd Capitolo\ 3
cd P2SH\ -\ P2PK
./main.sh
```

Se vogliamo attivare il debug della transazione sarà necessario utilizzare il parametro DEBUG=1
```bash
./main.sh DEBUG=1
```

La differenza con il libro è minima, invece ti lanciare `sh main.sh` dovrete lanciare `./main.sh`

## Per uscire dal container
Per uscire dal container
```bash
exit
```

successivamente per fermare e rimuovere il container utilizzare il comando

```bash
docker-compose down
```