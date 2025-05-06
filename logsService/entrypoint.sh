#!/bin/sh

echo "Executando seed dos sistemas fixos..."
node src/scripts/create-fixed-systems.js

echo "Iniciando servidor..."
node src/app.js