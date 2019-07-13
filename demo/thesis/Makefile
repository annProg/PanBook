SERVER ?= panbook.annhe.net

all: thesis

thesis:
	panbook thesis

link:
	for item in `panbook thesis -l`;do echo "- [$$item](https://$(SERVER)/pub/thesis-thesis-$$item.pdf)";done

clean:
	panbook clean