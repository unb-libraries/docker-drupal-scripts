#!/usr/bin/env bash
sudo apt-get update
sudo apt-get install -o Dpkg::Options::="--force-confold" --force-yes -y docker-engine
