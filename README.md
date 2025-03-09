# Docker Bitcoin in Action

<img src="https://i.ibb.co/CsLN0J2/bitcoin-Docker.png">

# Docker Bitcoin Books

## Clonazione del repository
Per utilizzare questo repository, per prima cosa è necessario clonarlo.
```bash
git clone https://github.com/bitcoin-dalla-teoria-alla-pratica/docker-bitcoin-books.git --depth 1
cd docker-bitcoin-books
```

Successivamente, cloniamo i repository del libro:
```bash
git clone https://github.com/bitcoin-dalla-teoria-alla-pratica/errata-corrige-e-sorgente-esempi.git --depth 1 &&
git clone --branch descriptor --depth 1 https://github.com/bitcoin-dalla-teoria-alla-pratica/Bitcoin-in-action-book.git
```

## Build dell'immagine Docker

Dobbiamo buildare l'immagine in base all'architettura del nostro sistema. Ad esempio, per un Mac con architettura ARM64, utilizziamo:
```bash
 docker buildx build --platform linux/arm64 --no-cache --load -t bitcoin-books .
```

Se non conosciamo l'architettura da utilizzare, possiamo lanciare il seguente comando per buildare l'immagine per più architetture:
```bash
 docker buildx build --platform linux/amd64,linux/arm64 --load -t bitcoin-books .
```

## Avvio dei container

Per avviare i container, utilizziamo:
```bash
docker-compose up
```
Se vogliamo avviarli in background (detached mode):
```bash
docker-compose up -d
```

## Come utilizzare gli esempi del libro

Ipotizziamo di voler replicare l'esempio del Capitolo 3 `P2SH - P2PK`.

1. Entriamo nel container:
   - Individuiamolo con il comando:
     ```bash
     docker ps
     ```
   - Utilizziamo il valore sotto la colonna `NAMES`, ad esempio:
     ```bash
     docker exec -it bitcoin-in-action zsh
     ```
2. Spostiamoci nella cartella del Capitolo 3 ed eseguiamo lo script:
   ```bash
   cd Bitcoin-in-action-book
   cd Capitolo\ 3/P2SH\ -\ P2PK
   ./main.sh
   ```
3. Per attivare il debug della transazione:
   ```bash
   ./main.sh DEBUG=1 
   ```
   **Nota:** La differenza con il libro è minima. Invece di lanciare `sh main.sh`, dobbiamo eseguire `./main.sh`.

Grazie al progetto [btcdeb](https://github.com/bitcoin-core/btcdeb), possiamo effettuare un debug passo-passo delle transazioni.

## Utilizzo di btc-rpc-explorer su Regtest

Grazie al progetto [btc-rpc-explorer](https://github.com/janoside/btc-rpc-explorer), abbiamo a disposizione un explorer su Regtest. Questo ci consente di visualizzare cosa sta accadendo sulla rete regtest di Bitcoin attraverso un'interfaccia grafica.

Per accedere all'explorer, apri il browser e vai su:
[http://localhost:3002/](http://localhost:3002/)

## Uscire e fermare i container

Per uscire dal container:
```bash
exit
```

Per fermare e rimuovere i container:
```bash
docker-compose down
```
Se vogliamo solo fermarli senza rimuoverli:
```bash
docker-compose stop
```

