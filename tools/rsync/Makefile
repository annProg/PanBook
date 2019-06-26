build:
	docker build -t annprog/rsync:latest .
test:
	docker run --rm -e PLUGIN_SRC=/tmp/a.pdf -e PLUGIN_DEST=172.17.0.1::panbook -v $(pwd):/tmp annprog/rsync