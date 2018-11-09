# DevGear Drupal Starter

DevGear Starter Kit for Drupal projects with Docker.

## Prerequirements:

We're using some popular tools to help acheave your goals:

1. Install Docker for your operational system: [Docker for Developers](https://www.docker.com/get-started)
2. Make sure you have working GNU Make or use makefile as "cheatsheet"
3. You should use Git to clone this StarterKit

## Quick start:

1. Create new project based on current file structure and content
2. Step into this folder in termial and execite `make run` command
3. Check result in your web browser following http://localhost

## Makefile aliases reference:

1. `make run` - wrapper around `docker-compose up`. Prepares and starts necwssary containt
2. `make stop` - suspends all working containers from this app
3. `make clear` - stops and removes all containers and data images from this project
