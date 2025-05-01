USE_SUDO := $(shell which docker >/dev/null && docker ps 2>&1 | grep -q "permission denied" && echo sudo)
DOCKER := $(if $(USE_SUDO), sudo docker, docker)
DIRNAME := $(notdir $(CURDIR))

build:
	$(DOCKER) compose build

up:
	$(DOCKER) compose up -d

down:
	$(DOCKER) compose down

logs:
	$(DOCKER) compose logs -f
