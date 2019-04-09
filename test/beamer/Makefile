all: build clean

build:
	pandoc -t beamer 1.md -o 1.pdf --pdf-engine=xelatex -V CJKmainfont=SimSun

clean:
	rm -f *.log *.aux *.out