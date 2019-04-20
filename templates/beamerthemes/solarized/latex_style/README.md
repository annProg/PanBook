# My LaTeX template

- Add the following bash function to your bashrc
```sh
function tex_tpl() {
	git clone https://github.com/homerours/latex_style.git;
	if [ $# -eq 0 ]; then
		cp latex_style/example.tex ./;
	else
		cp latex_style/example.tex ./$1.tex;
	fi
	cp latex_style/gitignore ./.gitignore;
	rm -rf latex_style/.git;
	rm latex_style/README.md latex_style/example.tex latex_style/gitignore;
}
```

- Run `tex_tpl <document-name>`
