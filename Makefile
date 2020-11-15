depend:
	go mod vendor
clean:
	docker-compose down
	-rm -rf builds/*
purge: clean
	docker image prune -f
build: purge
	docker-compose up --force-recreate --build
