SERVER ?= api.annhe.net
USER ?= root
PORT ?= 22
DIR ?= /pandoc-template

all: ctex ctex6in elegantbook epub release

ctex: 
	panbook pdf
ctex6in: 
	DEVICE=mobile panbook pdf
elegantbook: 
	TPL=elegantbook panbook pdf
epub: 
	panbook epub d
	mv build/pandoc-template-epub-*.epub build/pandoc-template-epub.epub

release:
	scp -P $(PORT) build/pandoc-template-ctex-pc.pdf $(USER)@$(SERVER):$(DIR)
	scp -P $(PORT) build/pandoc-template-ctex-mobile.pdf $(USER)@$(SERVER):$(DIR)
	scp -P $(PORT) build/pandoc-template-elegantbook-pc.pdf $(USER)@$(SERVER):$(DIR)
	scp -P $(PORT) build/pandoc-template-epub.epub $(USER)@$(SERVER):$(DIR)