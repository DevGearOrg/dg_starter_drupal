include .env

.PHONY: up run restart stop prune clear shell drush logs
DRUPAL_ROOT ?= /var/www/html

up:
	docker-compose up --remove-orphans -d

run:
	@echo "Starting up containers for $(PROJECT_NAME)..."
	docker-compose pull
	docker-compose up --remove-orphans $(ARGS)

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

ps:
	@docker ps --filter name='$(PROJECT_NAME)*'

drush:
	docker exec $(shell docker ps --filter name='$(PROJECT_NAME)_php' --format "{{ .ID }}") drush -r $(DRUPAL_ROOT) $(filter-out $@,$(MAKECMDGOALS))

shell:
	docker exec -ti -e COLUMNS=$(shell tput cols) -e LINES=$(shell tput lines) $(shell docker ps --filter name='$(PROJECT_NAME)_php' --format "{{ .ID }}") sh

logs:
	@docker-compose logs -f $(filter-out $@,$(MAKECMDGOALS))

new:
	@echo -n "This operation deletes all your data and generates new site. Continue? y/n" && read ans && [ $$ans == y ]
	$(MAKE) clear
	chown -R $(USER) ./public_html/
	chmod -R 777 ./public_html/
	rm -rf ./public_html/*
	$(MAKE) up
	docker-compose run --rm php drush dl -v  --drupal-project-rename="../html" drupal-7 -y
	docker-compose run --rm php drush site-install standard --account-name=$(ACCOUNT_NAME) --account-pass=$(ACCOUNT_PASS) --db-url=mysql://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST)/$(DB_NAME) --site-name=$(PROJECT_NAME) -y
	mkdir ./public_html/sites/all/modules/developer
	mkdir ./public_html/sites/all/modules/contrib
	docker-compose run --rm php drush dl -vy $(ADDITIONAL_MODULES)

backup:
	$(MAKE) drush sql-dump > tmp/`date +"%m.%d.%Y-%H:%M"`.sql

%:
	@: