NAME = jaulasid
BUILDER = podman
DATE := $(shell date +%Y%m%d)

  default: build

  build:
	$(BUILDER) image build -t $(NAME):$(DATE) .
	$(BUILDER) image tag $(NAME):$(DATE) $(NAME):latest

  push:
	$(BUILDER) image push $(NAME):$(DATE)
	$(BUILDER) image push $(NAME):latest

  debug:
	$(BUILDER) container run --rm -it $(NAME):$(DATE) /bin/bash

  run:
	$(BUILDER) container run --rm $(NAME):$(DATE)

  release: build push
