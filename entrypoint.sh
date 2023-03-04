#!/usr/bin/env bash
set -e
mkdir $HOME/.bitcoin && mv /opt/bitcoin.conf $HOME/.bitcoin
bitcoind && tail -F ~/.bitcoin/regtest/debug.log
