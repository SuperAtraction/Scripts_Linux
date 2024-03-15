#!/bin/bash

# Vérification de privilèges
if [ "$(id -u)" != "0" ]; then
    echo "Ce script doit être exécuté avec des privilèges sudo."
    exit 1
fi

commands=("sudo" "nmap" "grep" "sed" "awk" "xdg-open")
for cmd in "${commands[@]}"; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "La commande $cmd n'est pas disponible sur ce système."
        exit 1
    fi
done

if [ -e "nmap.sh" ]; then
    ./nmap.sh
else
    echo "Impossible de trouver le fichier nmap.sh"
fi
