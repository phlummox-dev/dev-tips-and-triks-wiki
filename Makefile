
.PHONY: serve docker-shel

IMG=elasticdog/tiddlywiki:5.1.23@sha256:ba678da4e860e83e6e427041e4d6dc77b6163931a88bdc28bf1286eb09125ed0
INSTANCE_NAME=phlummox-tipswiki

# to create new wiki:
#     tipswiki --init server


# serve on port 8080
serve:
	docker -D run --rm -it \
		-v $$PWD:/opt/work \
		--mount "type=bind,source=$${PWD}/tiddlywiki-data,target=/tiddlywiki" \
		--publish 127.0.0.1:8080:8080 \
		--name $(INSTANCE_NAME) \
		--user "$$(id -u):$$(id -g)" \
		$(IMG) \
		tipswiki --listen host=0.0.0.0

# run a `sh` shell
# NB: user is root; doesn't include --user "$$(id -u):$$(id -g)".
# Need to create a user of that name if wanting to serve from within
# the container. See 'create-user' 
docker-shell:
	docker -D run --rm -it \
		-v $$PWD:/opt/work \
		--publish 127.0.0.1:8080:8080 \
		--mount "type=bind,source=$${PWD}/tiddlywiki-data,target=/tiddlywiki" \
		--name $(INSTANCE_NAME) \
		--entrypoint=/bin/sh \
		$(IMG)

USER_ID = 1001
GROUP_ID = $(USER_ID)

# Intended to be run from within container
# (or just serve as a reference).
#
# Override USER_ID and GROUP_ID as needed, e.g.
#		make USER_ID=1000 create-user
# 
# Once user created, can serve with
#		su user -c 'tiddlywiki tipswiki --listen host=0.0.0.0'	
create-user:
	apk add sudo screen
	addgroup -g $(GROUP_ID) user
	adduser -g '' -G user -D -u $(USER_ID) user


clean:
	-rm -rf output
