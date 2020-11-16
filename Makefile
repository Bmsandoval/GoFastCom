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
	@echo "Container is now created"
run-tail:
	@echo "Tailing logs..."
	@echo "To exit, type ctrl+C."
	@echo "After exiting, you can resume tailing the logs by running 'make run-tail'"
	@echo ""
	sudo docker-compose logs -f gofastcom
