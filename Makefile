VERSION     = 1
REPO	    = unera

build:
	docker build . \
	    -t $(REPO)/docker-resolver:$(VERSION) \
	    -t $(REPO)/docker-resolver:latest

upload:
	docker push $(REPO)/docker-resolver:$(VERSION)
	docker push $(REPO)/docker-resolver:latest
