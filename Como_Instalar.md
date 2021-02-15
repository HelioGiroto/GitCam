# INSTRUÇÕES

0- É preciso ter uma conta no Github!

1- Faz fork do projeto.

2- Ativa a 'Github Pages' do seu fork:
	(para acessar as fotos em: https://usuario.github.io/GitCam/).

3- Faz clone do seu fork no seu Terminal linux:
	($ git clone ...url-do-seu-fork.git)

4- Roda: $ bash install.sh
	(Em caso de erro: É preciso certificar-se que foram configurados nome e email de usuário do git). Digite:
	$ git config --global user.name "John Doe"
	$ git config --global user.email johndoe@example.com
	(Outro erro: é possivel que se tenha que mudar a senha no próprio site do Github se persista algum erro de autenticação. Razões desconhecidas).

* O script install.sh fará que se faça 'git push' automaticamente sem operação manual. Mas para resetar isso é preciso deixar vazios os arquivos ~/.git-credentials e ~/.gitconfig ou pelo menos comentar as seguintes linhas:

	# echo "" > ~/.git-credentials
	# sed 's/\[credential\]/#&/; s/        helper/#&/' ~/.gitconfig


5- Roda: $ bash gitcam.sh

6- Abre no celular a 'Github Page' do seu fork (que será um PWA)
	(em: https://usuario.github.io/GitCam/)

7- Disfrute...
