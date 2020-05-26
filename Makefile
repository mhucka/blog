help:
	cat Makefile

push:
	rsync -avxz --delete --exclude '*~' _site/ www.cds.caltech.edu:public_html/blog


# start (or restart) the services in detached mode
preview: .FORCE
	cd _site && live-server --no-css-inject --watch=. --mount=/blog:.

# start (or restart) the services
# 2020-05-22 <mhucka@caltech.edu> note: this is what actually rebuilds _site,
# not (as you might think) the "make build" command.
server: .FORCE
	docker-compose down --remove-orphans || true;
	docker-compose up

# 2020-05-26 <mhucka@caltech.edu> create files targetting CDS deployment.
prod: .FORCE
	docker-compose down --remove-orphans || true;
	docker-compose -f docker-compose-prod.yml up

server-detached: .FORCE
	docker-compose down || true;
	docker-compose up -d

# build or rebuild the services WITHOUT cache
build: .FORCE
	chmod 777 Gemfile.lock
	docker-compose stop || true; docker-compose rm || true;
	docker build --no-cache -t hamelsmu/fastpages-nbdev -f _action_files/fastpages-nbdev.Dockerfile .
	docker build --no-cache -t hamelsmu/fastpages-jekyll -f _action_files/fastpages-jekyll.Dockerfile .
	docker-compose build --force-rm --no-cache

# rebuild the services WITH cache
quick-build: .FORCE
	docker-compose stop || true;
	docker build -t hamelsmu/fastpages-nbdev -f _action_files/fastpages-nbdev.Dockerfile .
	docker build -t hamelsmu/fastpages-jekyll -f _action_files/fastpages-jekyll.Dockerfile .
	docker-compose build 

# convert word & nb without Jekyll services
convert: .FORCE
	docker-compose up converter

# stop all containers
stop: .FORCE
	docker-compose stop
	docker ps | grep fastpages | awk '{print $1}' | xargs docker stop

# remove all containers
remove: .FORCE
	docker-compose stop  || true; docker-compose rm || true;

# get shell inside the notebook converter service (Must already be running)
bash-nb: .FORCE
	docker-compose exec watcher /bin/bash

# get shell inside jekyll service (Must already be running)
bash-jekyll: .FORCE
	docker-compose exec jekyll /bin/bash

# restart just the Jekyll server
restart-jekyll: .FORCE
	docker-compose restart jekyll

.FORCE:
