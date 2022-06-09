DOCKER := $(if $(shell docker ps >/dev/null 2>&1 && echo ok), docker, sudo docker)

EMPTY :=
SPACE := $(EMPTY) $(EMPTY)
DIRNAME := $(lastword $(subst /,$(SPACE),$(subst $(SPACE),_,$(CURDIR))))

.PHONY: build bootstrap clean purge deploy rm

build:
	$(DOCKER) build . --tag $(DIRNAME)

bootstrap:
	$(DOCKER) swarm init || true

clean:
	$(DOCKER) system prune -f

purge: clean
	$(DOCKER) volume prune -f

deploy:
	$(DOCKER) stack deploy -c docker-compose.yml $(DIRNAME)

rm:
	$(DOCKER) stack rm $(DIRNAME)
