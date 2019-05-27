THEME ?= metropolis

all: run

run:
	panbook slide --style=$(THEME)

all-theme:
	for theme in `panbook slide -l`;do \
		panbook slide --style=$$theme; \
	done
clean:
	panbook clean