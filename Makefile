image?=ljocha/sitsem23
port?=9000

build:
	docker build -t ${image} .

run:
	docker run -ti -e PORT=${port} -p ${port}:${port} -u ${shell id -u} -v ${PWD}:/work ljocha/sitsem23

