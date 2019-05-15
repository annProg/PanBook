all: tex pdf
tex:
	pandoc 1.md -o 1.tex -M abstract="HelloWorld" -V keywords="hello" -V keywords="world" -V documentclass=artical -s
pdf:
	pandoc 1.md -o 1.pdf -V abstract="Hello World" -V keywords="hello" -V keywords="world"