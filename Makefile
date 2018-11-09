run:
	docker-compose up

stop:
	docker-compose down

clear:
	docker-compose rm -s -v

clear_all:
	docker-compose down --rmi local -v
	docker-compose rm -s -f -v
