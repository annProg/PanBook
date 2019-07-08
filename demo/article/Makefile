DEBUG ?= 
SERVER ?= panbook.annhe.net

all: build clean
build: ctexart elegantnote elegantpaper

ctexart:
	panbook art $(DEBUG)
elegantnote:
	panbook art --style=elegantnote $(DEBUG)
elegantpaper:
	panbook art --style=elegantpaper $(DEBUG)
link:
	for item in `panbook art -l`;do echo "- [$$item](https://$(SERVER)/pub/article-art-$$item.pdf)";done

clean:
	panbook clean