#!/bin/bash

# GITCAM.SH

# Este Shell Script funciona como um detector de presença e/ou 
# uma câmera de vigilância que toma fotos constantemente através
# da video-camera do computador. 

# Cada foto é comparada com a foto anterior para ver se há
# diferença entre elas. Caso haja, o beep é acionado (opcional)
# e a foto recente é enviada ao Github do usuário para que
# possa ser vista de qualquer dispositivo e lugar do mundo.

# Ao invés do beep, se pode executar um comando que enviaria um
# alerta ao email, twitter do usuário. Avisando que algo diferente
# aconteceu no local vigiado.

# Requer instalar (além do Dropbox for Linux) os pacotes:
# sudo apt install -y fswebcam imagemagick cvlc

# Autor: Hélio Giroto

# Só para garantir que tenha ao menos uma foto nesta pasta local:
touch ~/album/0.png

# Nro (nome) da última foto tomada e salva na pasta local album:
ULTIMA_FOTO=$(ls ~/album | sort -n | tail -n1 | sed 's/\.png//')

# Define o nome da primeira foto que será tomada:
PRIMEIRA_FOTO=$((ULTIMA_FOTO+1))

# espera 3 segundos para tirar a primeira foto:
sleep 3

# tira primeira foto:
fswebcam -q --png -1 ~/album/${PRIMEIRA_FOTO}.png

# PROX_FOTO recebe 1 (para nome do arq.png):
PROX_FOTO=$((PRIMEIRA_FOTO+1))

# laço infinito:
while :
do
	# intervalo de um segundo para tirar uma nova foto:
	sleep 1

	# nome que será dado a foto atual:
	FOTO_ATUAL=$PROX_FOTO.png

	# nome da foto anterior:
	FOTO_ANT=$((PROX_FOTO-1)).png

	# Tira uma foto que receberá o nome de foto atual:
	fswebcam -q --png -1 ~/album/$FOTO_ATUAL
	
	# compara as duas fotos e define variável tolerancia.
	# caso as 2 fotos sejam iguais recebe valor 0, senão receberá outro valor diferente:
	tolerancia=$(compare -fuzz 50% -quiet -metric ae ~/album/$FOTO_ATUAL ~/album/$FOTO_ANT null: 2>&1)

	# Verifica a tolerancia:
	if [[ $tolerancia -ne 0 ]]
	then
		# cvlc --play-and-exit ~/beep.mp3		# sudo apt install vlc-bin
		# tee DETECT_$FOTO_ATUAL ~/Dropbox/$FOTO_ATUAL < $FOTO_ATUAL &> /dev/null


		# copia foto atual para a pasta album do gitcam:
		cp ~/album/$FOTO_ATUAL ./album/$FOTO_ATUAL

		# variavel momento recebe a data e hora:
		momento=$(date)

		# modifica (appenda) o album.json (PARA DAR ALERTA NO APP PWA DO CELULAR DO USUÁRIO):

		# addiciona, commita e faz push para github:
		git add .
		git commit -m "${momento}"
		git push

	fi

	# acrescenta mais 1 à variavel PROX_FOTO:
	PROX_FOTO=$((PROX_FOTO+1))
done


