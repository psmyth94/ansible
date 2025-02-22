#!/usr/bin/env bash

set -e

# second argument is vault password file (default .vault.password.txt)
BECOME_FILE="$1"
if [ -z "$1" ]; then
  BECOME_FILE="$HOME/.become.password.txt"
fi

if [ ! -f "$BECOME_FILE" ]; then
  echo "$BECOME_FILE does not exists"
  exit 1
fi

BECOME_PASS=$(cat "$BECOME_FILE")

VAULT_FILE="$2"
if [ -z "$2" ]; then
  VAULT_FILE="$HOME/.vault.password.txt"
fi

if [ ! -f "$VAULT_FILE" ]; then
  echo "$VAULT_FILE does not exists"
  exit 1
fi

# Run Ansible bootstrap playbook
echo "Running Ansible playbook..."
ANSIBLE_VAULT_PASSWORD_FILE=$VAULT_FILE \
  molecule test \
  -e "ansible_become_pass=${BECOME_PASS} dotfiles_repo=https://github.com/psmyth94/.dotfiles dotfiles_version=main dotfiles_dir=${HOME}/.dotfiles"
