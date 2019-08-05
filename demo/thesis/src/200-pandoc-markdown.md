
# Pandoc Markdown 扩展语法
Pandoc 的目标与原始 Markdown 的最初目标有着方向性的不同。在 Markdown 原本的设计中，
HTML 是其主要输出对象；然而 Pandoc 则是针对多种输出格式而设计。因此，虽然 Pandoc 
同样也允许直接嵌入 HTML 标签，但并不鼓励这样的作法，取而代之的是 Pandoc 提供了许多
非 HTML 的方式，来让使用者输入像是定义列表、表格、数学公式以及脚注等诸如此类的重
要文件元素。

Pandoc Markdown 语法介绍可以在 [Pandoc 主页](http://www.pandoc.org/MANUAL.html#pandocs-markdown) 
找到。中文翻译请参考 PanBook 使用手册^[https://panbook.annhe.net/pub/PanBook-book-ctexbook-pc.pdf] [@panbook] 。

## 交叉引用
Pandoc Markdown 对象 ID 语法格式形如 `{#label}`，使用交叉引用，还需遵循 [@tbl:crossref] 中的 ID 前缀要求。

类型 | 前缀 | 示例
:---|:---|:------
图片| `fig:`|`{#fig:label}`
表格| `tbl:`|`{#tbl:label}`
公式| `eq:` |`{#eq:label}`
代码| `lst:`|`{#lst:label}`
章节| `sec:`|`{#sec:label}`
定理| `thm:`|`{#thm:label}`
定义| `def:`|`{#def:label}`
引理| `lem:`|`{#lem:label}`
推论| `cor:`|`{#cor:label}`
命题| `pro:`|`{#pro:label}`

: 交叉引用前缀规范 {#tbl:crossref}

基本的引用格式为 `[@label]`，注意，比如 有一个图片的 ID 是 `{#fig:myfigure}`，则引用为 `[@fig:myfigure]`。更复杂的引用格式请参考 PanBook 使用手册 [@panbook]。

## 代码
普通代码块和原生 Markdown 语法一致，如果需要包含 label 及 caption，可用 `{#label .class caption="My Caption"}` 格式，`.class` 可以有多个，一般第一个是代码语言类型。示例见 [@lst:hello]。

~~~{#lst:hello .go caption="示例代码"}
package main

import "fmt"
func main() {
    fmt.Println("hello world")
}
~~~

## 图片
直接使用 PanBook plot 扩展来展示图片，详情请参考 PanBook 使用手册 [@panbook]。效果见 [@fig:plot_gnuplot]。
```{#fig:plot_gnuplot .plot:gnuplot caption="gnuplot 示例" width=70%}
set terminal pngcairo  background "#ffffff" enhanced font "arial,8" fontscale 1.0 size 540, 384 
set output 'hidden2.1.png'
set isosamples 25,25
set xyplane at 0
unset key

set palette rgbformulae 31,-11,32
set style fill solid 0.5
set cbrange [-1:1]

set title "中文 Mixing pm3d surfaces with hidden-line plots"

f(x,y) = sin(-sqrt((x+5)**2+(y-7)**2)*0.5)

set hidden3d front
splot f(x,y) with pm3d, x*x-y*y with lines lc rgb "black"
```
### 子图
效果见 [@fig:plot_subfig]。

::: {#fig:plot_subfig}
```{#fig:sub_gnuplot .plot:gnuplot caption="gnuplot 示例" width=48% subfig=1}
set terminal pngcairo  background "#ffffff" enhanced font "arial,8" fontscale 1.0 size 540, 384 
set output 'hidden2.1.png'
set isosamples 25,25
set xyplane at 0
unset key

set palette rgbformulae 31,-11,32
set style fill solid 0.5
set cbrange [-1:1]

set title "中文 Mixing pm3d surfaces with hidden-line plots"

f(x,y) = sin(-sqrt((x+5)**2+(y-7)**2)*0.5)

set hidden3d front
splot f(x,y) with pm3d, x*x-y*y with lines lc rgb "black"
```
```{#fig:sub_gnuplot2 .plot:gnuplot caption="gnuplot 绘制数据图" width=48% subfig=1}
set datafile separator comma
set title 'Browser popularity'
set xlabel 'Year'
set ylabel '% usage'
set style data histogram
set style histogram clustered gap 1
set style fill solid 1 noborder
set xtics scale 0
plot for [i=2:5] 'data/usage.csv' using i:xtic(1) title columnheader
```

子图示例
:::

## 表格
效果请看 [@tbl:crossref]。

## 公式
以下是一个例子，显示效果见 [@eq:math_demo]：

```latex
$$\begin{cases}
a_1x+b_1y+c_1z=d_1\\
a_2x+b_2y+c_2z=d_2\\
a_3x+b_3y+c_3z=d_3\\
\end{cases}$$ {#eq:math_demo}
```

$$\begin{cases}
a_1x+b_1y+c_1z=d_1\\
a_2x+b_2y+c_2z=d_2\\
a_3x+b_3y+c_3z=d_3\\
\end{cases}$$ {#eq:math_demo}

## 参考文献

参考文献使用 biblatex 格式管理，引文和引用格式化使用 Citation Style Language^[https://www.zotero.org/styles]，Zotero 样式库^[https://citationstyles.org/] 可以下载到 csl 文件，通过 PanBook 参数 `--csl` 指定 csl 文件。

文献引用放在方括号中，以分号隔开。每一条引用都需要有一个 key，由 `@` 加上文献目录数据库中的文献 ID 组成，并且可以选择性地包含前缀、定位以及后缀。引用键必须以字母、数字或 `_` 开头，并且可以包含字母数字、`_` 和内部标点符号（`:.#$%&-+?<>~/`）。以下是一些范例：

```markdown
Blah blah [@panbook].
Blah blah [see @doe99, pp. 33-35; also @smith04, ch. 1].
Blah blah [@doe99, pp. 33-35, 38-39 and *passim*].
Blah blah [@smith04; @doe99].
```

更多信息请参考 PanBook 使用手册 [@panbook]。