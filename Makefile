SERVER ?= api.annhe.net
USER ?= root
PORT ?= 22
DIR ?= /pandoc-template

OWNER ?= annProg
REPO ?= pandoc-template
TAG ?= $(shell git rev-parse --short HEAD)

all: ctex ctex6in elegantbook epub online
pdf: ctex ctex6in elegantbook

ctex: 
	panbook pdf
ctex6in: 
	DEVICE=mobile panbook pdf
elegantbook: 
	TPL=elegantbook panbook pdf
epub:
	rm -f build/*.epub
	panbook epub d
	mv build/pandoc-template-epub-*.epub build/pandoc-template-epub.epub
	
up: release upload

release:
	git tag -a $(TAG) -m "$(TAG)"
	git push origin $(TAG)
	curl -H "Authorization: token $$GITHUB_TOKEN" -XPOST "https://api.github.com/repos/$(OWNER)/$(REPO)/releases" -d "tag_name=$(TAG)"
upload:
	ID=`curl -H "Authorization: token $$GITHUB_TOKEN" "https://api.github.com/repos/$(OWNER)/$(REPO)/releases/tags/$(TAG)" |grep '"id"' |head -n 1 |awk '{print $$2}' |tr -d ','`; echo "ID: $$ID";\
	cd build/; \
	for FILE in `ls *.pdf` $(REPO).epub;do \
		echo $$FILE;\
		curl -H "Authorization: token $$GITHUB_TOKEN" -H "Content-Type: $$(file -b --mime-type $$FILE)" "https://uploads.github.com/repos/$(OWNER)/$(REPO)/releases/$$ID/assets?name=$$(basename $$FILE)" --data-binary @$$FILE; echo; \
	done

online:
	scp -P $(PORT) build/pandoc-template-ctex-pc.pdf $(USER)@$(SERVER):$(DIR)
	scp -P $(PORT) build/pandoc-template-ctex-mobile.pdf $(USER)@$(SERVER):$(DIR)
	scp -P $(PORT) build/pandoc-template-elegantbook-pc.pdf $(USER)@$(SERVER):$(DIR)
	scp -P $(PORT) build/pandoc-template-epub.epub $(USER)@$(SERVER):$(DIR)
	