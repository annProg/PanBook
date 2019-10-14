COVER ?= R
DEVICE ?= pc
DEBUG ?= 

all: ctexbook elegantbook

ctexbook:
	panbook book -V cover:$(COVER) -V device:$(DEVICE) $(DEBUG)
elegantbook:
	panbook book --style=elegantbook -V device:$(DEVICE) $(DEBUG)

clean:
	panbook clean