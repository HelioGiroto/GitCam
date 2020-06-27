#!/bin/bash

sudo apt install -y fswebcam imagemagick #cvlc

# salva a senha e usuário do Github no seu .gitconfig:
echo "" >> ~/.gitconfig
echo "[credential]" >> ~/.gitconfig
echo "        helper = store" >> ~/.gitconfig

# Para resertar isso acima, digite:
	# echo "" > ~/.git-credentials
	# e apagar as lnhas acima de ~/.gitconfig

