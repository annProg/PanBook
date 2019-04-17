SERVER ?= api.annhe.net
USER ?= root
PORT ?= 22
DIR ?= /PanBook

OWNER ?= annProg
REPO ?= PanBook
TAG ?= $(shell git rev-parse --short HEAD)

all: ctex ctex6in ctexart elegantbook elegantnote elegantpaper epub online
pdf: ctex ctex6in elegantbook

ctex: 
	panbook pdf -E cover=R
ctex6in: 
	panbook pdf -E cover=R -E device=mobile
ctexart:
	panbook pdf --class=ctexart
elegantbook: 
	panbook pdf --class=elegantbook
elegantnote: 
	panbook pdf --class=elegantnote
elegantpaper: 
	panbook pdf --class=elegantpaper	
epub:
	rm -f build/*.epub
	panbook epub -d
	mv build/$(REPO)-*.epub build/$(REPO).epub
	
up: release upload

release:
	git tag -a $(TAG) -m "$(TAG)"
	git push origin $(TAG)
	curl -H "Content-Type:application/json" -H "Authorization: token $$GITHUB_TOKEN" -XPOST "https://api.github.com/repos/$(OWNER)/$(REPO)/releases" -d '{"tag_name":"$(TAG)"}'
upload:
	ID=`curl -s -H "Authorization: token $$GITHUB_TOKEN" "https://api.github.com/repos/$(OWNER)/$(REPO)/releases/tags/$(TAG)" |grep '"id"' |head -n 1 |awk '{print $$2}' |tr -d ','`; echo "ID: $$ID";\
	cd build/; \
	for FILE in `ls *.pdf` $(REPO).epub;do \
		echo $$FILE;\
		curl -H "Authorization: token $$GITHUB_TOKEN" -H "Content-Type: $$(file -b --mime-type $$FILE)" "https://uploads.github.com/repos/$(OWNER)/$(REPO)/releases/$$ID/assets?name=$$(basename $$FILE)" --data-binary @$$FILE; echo; \
	done

online:
	scp -P $(PORT) build/$(REPO)-latex-*.pdf $(USER)@$(SERVER):$(DIR)
	scp -P $(PORT) build/$(REPO).epub $(USER)@$(SERVER):$(DIR)
	