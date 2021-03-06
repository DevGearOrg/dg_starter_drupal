# DevGear Drupal Starter

DevGear Starter Kit for Drupal projects with Docker.  
Based on [wodby/docker4drupal](https://github.com/wodby/docker4drupal) project but simplified.

*Read this in other languages: [English](README.md), [Русский](README.ru.md).*

## Prerequirements:

We're using some popular tools to help acheave your goals:

1. Install Docker for your operational system: [Docker for Developers](https://www.docker.com/get-started)
2. Make sure you have working GNU Make or use makefile as "cheatsheet"
3. You should use Git to clone this StarterKit

## Quick start:

1. Create new project based on current file structure and content
2. Step into this folder in termial and execute `make run` command
3. Check result in your web browser following http://localhost
4. PhpMyAdmin runs on http://localhost:8080

## Makefile aliases reference:

- `make run` - wrapper around `docker-compose up`. Prepares and starts necessary containt
- `make stop` - suspends all working containers from this app
- `make restart` - stop and run alias
- `make prune` - stops and removes all containers and data images from this project
- `make clear` - like prune but deletes images
- `make drush` - runs Drush commands. Pass arguments right here
- `make logs` - connects to compose logs stram
