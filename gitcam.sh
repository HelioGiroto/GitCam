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


# Deleta todos fotos antigas do album que são iguais:
rm ./album/[0-9]*

# espera 3 segundos para tirar a primeira foto:
sleep 3

# tira primeira foto:
fswebcam -q --png -1 ./album/0.png

# sufixo recebe 1 (para nome do arq.png):
sufixo=1

# laço infinito:
while :
do
	# intervalo de um segundo:
	sleep 1

	# nome que será dado a foto atual:
	foto_atual=$sufixo.png

	# nome da foto anterior:
	foto_ant=$((sufixo-1)).png

	# Tira uma foto que receberá o nome de foto atual:
	fswebcam -q --png -1 ./album/$foto_atual
	
	# compara as duas fotos e define variável tolerancia.
	# caso as 2 fotos sejam iguais recebe valor 0, senão receberá outro valor diferente:
	tolerancia=$(compare -fuzz 50% -quiet -metric ae ./album/$foto_atual ./album/$foto_ant null: 2>&1)

	# Verifica a tolerancia:
	if [[ $tolerancia -ne 0 ]] 
	then
		# cvlc --play-and-exit ~/beep.mp3		# sudo apt install vlc-bin
		# tee DETECT_$foto_atual ~/Dropbox/$foto_atual < $foto_atual &> /dev/null

		# variavel momento recebe a data e hora:
		momento=$(date)

		# modifica o album.json:
		# addiciona, commita e faz push para github: 
		git add .
		git commit -m "${momento}"
		git push

	fi

	# acrescenta mais 1 à variavel sufixo:
	sufixo=$((sufixo+1))
done


