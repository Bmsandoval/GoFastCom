depend:
	go mod vendor
purge:
	docker-compose down
	docker rm $(docker ps -a -q)
	docker rmi $(docker images -q)
build:
	# CGO_ENABLED=1 GOOS=linux go build -mod=vendor -a -installsuffix cgo -o app .
	#CC=x86_64-w64-mingw32-gcc CGO_ENABLED=1 go build -mod=vendor -a -o app .
#	docker volume create random_volume_name
#	docker run random_volume_name:~/ ubuntu-libs
	docker build -t bmsandoval/gofastcom:latest -f deployment/Dockerfile .
	#docker-compose up --force-recreate
	docker run --rm -v ./:/gofastcom . -n bmsandoval/gofastcom:latest


