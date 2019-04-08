# 定理类环境资料

- http://gedenkt.at/blog/theorems-in-pandoc/
- https://github.com/ickc/pandoc-amsthm
- https://bookdown.org/yihui/bookdown/markdown-extensions-by-bookdown.html

基本思路还是需要用filter

考虑用代码块语法

~~~
```{#id .prefix-theorem caption="caption"}
Here is my theorem
```
~~~

另外，为保持兼容性，将以`ElegantBook`模板的定理类环境为基准，在`Ctex`模板中实现类似的环境。新增模板也需要做兼容。