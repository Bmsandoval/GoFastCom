depend:
	go mod vendor
clean:
	sudo docker-compose down
	-rm -rf builds/*
purge: clean
	sudo docker image prune -f
run-local:
	go run .
run-docker: purge
	sudo docker-compose up --force-recreate --build -d
	-echo "Container is now created, tailing logs..."
run-tail:
	-echo "Tailing logs..."
	-echo "To exit, type ctrl+<c>."
	-echo "After exiting, you can resume tailing the logs by running 'make run-tail'"
	sudo docker-compose logs -f gofastcom
