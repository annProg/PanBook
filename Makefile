SERVER ?= api.annhe.net
USER ?= root
PORT ?= 22
DIR ?= /PanBook
HIGHLIGHT ?= --highlight-style=tango
DEBUG ?= 

OWNER ?= annProg
REPO ?= PanBook
TAG ?= $(shell git rev-parse --short HEAD)
DIVISION = --top-level-division=chapter
CJK ?= -V CJKmainfont:思源宋体 -V CJKoptions:BoldFont=思源黑体,ItalicFont=KaiTi,SmallCapsFont=微软雅黑

all: ctex ctex6in elegantbook epub online
book: ctex ctex6in elegantbook

ctex: 
	panbook book -V cover:R $(DIVISION) $(CJK) $(DEBUG) $(HIGHLIGHT)
ctex6in: 
	panbook book -V cover:R -V device:mobile $(DIVISION) $(CJK) $(DEBUG) $(HIGHLIGHT)
elegantbook: 
	panbook book --style=elegantbook $(DIVISION) $(CJK) $(DEBUG) $(HIGHLIGHT)
epub:
	rm -f build/*.epub
	panbook book --style=epub $(DEBUG) $(HIGHLIGHT)
	mv build/$(REPO)-*.epub build/$(REPO).epub
	
up: release upload

release:
	git tag -a $(TAG) -m "$(TAG)"
	git push origin $(TAG)
	curl -H "Content-Type:application/json" -H "Authorization: token $$GITHUB_TOKEN" -XPOST "https://api.github.com/repos/$(OWNER)/$(REPO)/releases" -d '{"tag_name":"$(TAG)"}'
upload:
	ID=`curl -s -H "Authorization: token $$GITHUB_TOKEN" "https://api.github.com/repos/$(OWNER)/$(REPO)/releases/tags/$(TAG)" |grep '"id"' |head -n 1 |awk '{print $$2}' |tr -d ','`; echo "ID: $$ID";\
	cd build/; \
	for FILE in `ls $(REPO)-*.pdf` $(REPO).epub;do \
		echo $$FILE;\
		curl -H "Authorization: token $$GITHUB_TOKEN" -H "Content-Type: $$(file -b --mime-type $$FILE)" "https://uploads.github.com/repos/$(OWNER)/$(REPO)/releases/$$ID/assets?name=$$(basename $$FILE)" --data-binary @$$FILE; echo; \
	done

online:
	scp -P $(PORT) build/$(REPO)-book-*.pdf $(USER)@$(SERVER):$(DIR)
	scp -P $(PORT) build/$(REPO).epub $(USER)@$(SERVER):$(DIR)
	