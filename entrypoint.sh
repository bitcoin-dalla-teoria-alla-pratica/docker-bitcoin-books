#!/usr/bin/env bash
set -e

# Check if .bitcoin directory exists
if [ ! -d "$HOME/.bitcoin" ]; then
  mkdir "$HOME/.bitcoin"
fi

# Check if bitcoin.conf exists, then move it
if [ -f "/opt/bitcoin.conf" ]; then
  cp /opt/bitcoin.conf "$HOME/.bitcoin"
fi

bitcoind || echo "Errore nell'avvio di bitcoind"
tail -F ~/.bitcoin/regtest/debug.log
sleep infinity