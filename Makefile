start:
	docker-compose up -d --build

stop:
	docker-compose down -v

restart: stop start
