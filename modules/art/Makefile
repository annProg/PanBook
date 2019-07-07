DEBUG ?= 

all: build clean
build: ctexart elegantnote elegantpaper

ctexart:
	panbook art $(DEBUG)
elegantnote:
	panbook art --style=elegantnote $(DEBUG)
elegantpaper:
	panbook art --style=elegantpaper $(DEBUG)

clean:
	panbook clean