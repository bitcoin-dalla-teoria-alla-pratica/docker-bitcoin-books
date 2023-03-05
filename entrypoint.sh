#!/usr/bin/env bash
set -e

# Check if .bitcoin directory exists
if [ ! -d "$HOME/.bitcoin" ]; then
  mkdir "$HOME/.bitcoin"
fi

# Move bitcoin.conf to .bitcoin directory
cp /opt/bitcoin.conf "$HOME/.bitcoin"

bitcoind && tail -F ~/.bitcoin/regtest/debug.log
