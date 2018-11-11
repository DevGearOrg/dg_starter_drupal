include .env

.PHONY: up run restart stop prune clear shell drush logs

up: run
run:
	@echo "Starting up containers for $(PROJECT_NAME)..."
	docker-compose pull
	docker-compose up -d --remove-orphans

stop:
	@echo "Stopping containers for $(PROJECT_NAME)..."
	@docker-compose stop

restart: stop run

prune:
	@echo "Removing containers for $(PROJECT_NAME)..."
	@docker-compose down -v

clear:
	docker-compose down --rmi local -v
	docker-compose rm -s -f -v

drush:
	docker exec $(shell docker ps --filter name='$(PROJECT_NAME)_php' --format "{{ .ID }}") drush -r /var/www/html $(filter-out $@,$(MAKECMDGOALS))

logs:
	@docker-compose logs -f $(filter-out $@,$(MAKECMDGOALS))

new:
	cp .env.example .env
	@echo -n "Edin .env file" && read ans && [ $$ans == y ]

%:
	@: