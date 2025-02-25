start:
	docker-compose up -d --build

stop:
	docker-compose down

restart: stop start
