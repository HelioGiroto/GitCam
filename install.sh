#!/bin/bash

# Instala pacotes necessários para bater fotos e compará-las:
sudo apt install -y fswebcam imagemagick #cvlc

# Cria uma pasta local para armazenar suas fotos tiradas:
mkdir ~/album

# variáveis para impressão de nome da máquina e data de hoje:
DATA=$(date)
HOSTNAME=$(hostname)

# Fazendo o primeiro commit para gravar o usuário/senha na máquina local:
echo "# Instalado em ${DATA}" >> gitcam.sh
echo
echo "Conectando pela 1a. vez com o seu Github..."
echo
git add .
git commit -m "Instalado com sucesso na sua máquina: ${HOSTNAME}! "
git push

# Salva a senha e usuário do Github no seu .gitconfig
# Com isso o usuário não necessita mais fazer o login no Github manualmente (apenas na 1a. vez acima):
echo "" >> ~/.gitconfig
echo "[credential]" >> ~/.gitconfig
echo "        helper = store" >> ~/.gitconfig

# https://stackoverflow.com/questions/35942754/how-to-save-username-and-password-in-git-gitextension#answer-50700468

echo
echo "====================================="
echo "Já pode executar o programa gitcam.sh"
echo "Digite:" 
echo
echo "          bash gitcam.sh"
echo "====================================="
echo
echo "Do seu celular você já pode ver as imagens..."


# Para desfazer o login automático do Github, digite no Terminal:
	# echo "" > ~/.git-credentials
	# sed 's/\[credential\]/#&/; s/        helper/#&/' ~/.gitconfig

