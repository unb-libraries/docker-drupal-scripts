#!/usr/bin/env bash
pip install --user awscli
export PATH=$PATH:$HOME/.local/bin
$(aws ecr get-login --region $AWS_REGION)
