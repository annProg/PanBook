# elegantlatex相关文档类不兼容unicode-math，需要设置mathspec为false
# https://github.com/ElegantLaTeX/ElegantBook/issues/9
# https://tex.stackexchange.com/questions/448577/build-failure-using-unicode-math-and-newtx-simultaneously?rq=1
pdf:
	pandoc 1.md -o 1.pdf --pdf-engine=xelatex -V documentclass=elegantnote -V mathspec=false