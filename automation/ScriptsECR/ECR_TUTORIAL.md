# Instruções para colocar imagens no ECR

1. Antes de tudo, é necessário fazer um login para acessar o ECR, que utiliza o ID da conta da AWS e a região:

		aws ecr get-login-password --region {$REGIAOAWS} | docker login --username AWS --password-stdin {$IDAWS}.dkr.ecr.{$REGIAOAWS}.amazonaws.com

2. Fazer um docker pull na maquina local da imagem que se deseja armazenar no ECR:

		docker pull {$IMAGEM}:tag
		
3. Fazer uma tag da imagem e dar um nome a ela:

		docker tag mongo:latest $REPOSITORY_URI/$IMAGE_REPO_NAME:IMAGE
		
4. Finalmente, para dar o push no repositorio:

		docker push $REPOSITORY_URI/$IMAGE_REPO_NAME:IMAGE
		
5. Agora será possivel dar docker pull a partir das imagens no ECR:

		docker pull $REPOSITORY_URI/IMAGE_REPO_NAME:IMAGE					