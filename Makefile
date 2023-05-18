DOCKER := $(if $(shell docker ps >/dev/null 2>&1 && echo ok), docker, sudo docker)
DIRNAME := $(notdir $(CURDIR))

build:
	$(DOCKER) compose build

clean:
	$(DOCKER) system prune -f

purge: clean
	$(DOCKER) volume prune -f

up:
	$(DOCKER) compose up -d

down:
	$(DOCKER) compose down
