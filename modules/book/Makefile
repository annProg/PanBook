COVER ?= R
DEVICE ?= pc
all: ctexbook elegantbook

ctexbook:
	panbook book -V cover:$(COVER) -V device:$(DEVICE)
elegantbook:
	panbook book --style=elegantbook -V device:$(DEVICE)

clean:
	panbook clean