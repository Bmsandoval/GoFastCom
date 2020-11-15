depend:
	go mod vendor
clean:
	sudo docker-compose down
	-rm -rf builds/*
purge: clean
	sudo docker image prune -f
run-local:
	go run .
build: purge
	sudo docker-compose up --force-recreate --build
