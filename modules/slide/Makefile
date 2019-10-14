THEME ?= metropolis
DEBUG ?=

all: run

run:
	panbook slide --style=$(THEME) $(DEBUG)

all-theme:
	for theme in `panbook slide -l`;do \
		panbook slide --style=$$theme $(DEBUG); \
	done
clean:
	panbook clean