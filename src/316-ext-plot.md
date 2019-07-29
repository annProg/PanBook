
## plot

::: {.info caption="扩展信息"}
使用场景
  ~ 使用 graphviz，ditaa 等图形描述语言画图

启用状态
  ~ 默认在所有模块中启用

格式支持  
  ~ \LaTeX，EPUB

语法系列
  ~ fenced_divs 参见 [@sec:fenced_divs]  
:::

### 安装
需要安装 librsvg 用于 SVG 转 PDF。msys2 上使用 `pacman -S mingw64/mingw-w64-x86_64-librsvg` 安装。

目前支持以下画图引擎，如需使用，请安装对应软件并加入 PATH 环境变量

- dot,neato,fdp,sfdp,twopi,circo (from graphviz)
- ditaa （建议使用 go 语言版本 https://github.com/akavel/ditaa/releases）
- goseq （https://github.com/pandoc-ebook/goseq/releases）
- a2s （https://github.com/pandoc-ebook/asciitosvg/releases）
- gnuplot

### 用法

使用代码块语法

- 为正常使用交叉引用，id 格式须符合 `fig:<label>`
- 样式格式须为 `plot:<plot engine>`，比如 `plot:dot`

~~~markdown
```{#fig:<label> .plot:<engine> caption="<caption>"}
digraph G {
	Markdown -> LaTeX;
}
```
~~~

### graphviz

dot 代码如下，图片见 [@fig:plot_dot]。

~~~markdown
```{#fig:plot_dot .plot:dot caption="Dot 示例"}
digraph {
  "A" [shape="circle"];
  "B" [shape="rectangle"];
  "C" [shape="diamond"];
 
  "A" -> "B" [label="A to B"];
  "B" -> "C" [label="B to C"];
  "A" -> "C" [label="A to C"];
}
```
~~~

```{#fig:plot_dot .plot:dot caption="Dot 示例"}
digraph {
  "A" [shape="circle"];
  "B" [shape="rectangle"];
  "C" [shape="diamond"];
 
  "A" -> "B" [label="A to B"];
  "B" -> "C" [label="B to C"];
  "A" -> "C" [label="A to C"];
}
```

### ditaa
ditaa 代码如下，图片见 [@fig:plot_ditaa]。

~~~markdown
```{#fig:plot_ditaa .plot:ditaa caption="Ditaa 示例"}
+--------+   +-------+    +-------+
|        +=--+ ditaa +--> |       |
|  Text  |   +-------+    |diagram|
|Document|   |!magic!|    |       |
|     {d}|   |       |    |       |
+---+----+   +-------+    +-------+
	:                         ^
	|       Lots of work      |
	+-------------------------+
```		
~~~

```{#fig:plot_ditaa .plot:ditaa caption="Ditaa 示例"}
+--------+   +-------+    +-------+
|        +=--+ ditaa +--> |       |
|  Text  |   +-------+    |diagram|
|Document|   |!magic!|    |       |
|     {d}|   |       |    |       |
+---+----+   +-------+    +-------+
	:                         ^
	|       Lots of work      |
	+-------------------------+
```	

### goseq 时序图
goseq 代码如下，图片见 [@fig:plot_goseq]。更多信息请参考：https://github.com/lmika/goseq。

~~~markdown
```{#fig:plot_goseq .plot:goseq caption="Goseq Demo"}
Client->Server: Make request
Server->Database: Make database\nrequest
Database->Server: The result
Server->Client: The response
```
~~~

```{#fig:plot_goseq .plot:goseq caption="Goseq Demo"}
Client->Server: Make request
Server->Database: Make database\nrequest
Database->Server: The result
Server->Client: The response
```

### asciitosvg
asciitosvg 代码如下，图片见 [@fig:plot_a2s]。更多信息请参考 https://github.com/asciitosvg/asciitosvg。

~~~markdown
```{#fig:plot_a2s .plot:a2s caption="A2s Demo"}
 .-------------------------.
 |                         |
 | .---.-. .-----. .-----. |
 | | .-. | +-->  | |  <--| |
 | | '-' | |  <--| +-->  | |
 | '---'-' '-----' '-----' |
 |  ascii     2      svg   |
 |                         |
 '-------------------------'

https://github.com/asciitosvg

[1,0]: {"fill":"#88d","a2s:delref":1}
```
~~~

```{#fig:plot_a2s .plot:a2s caption="A2s Demo"}
 .-------------------------.
 |                         |
 | .---.-. .-----. .-----. |
 | | .-. | +-->  | |  <--| |
 | | '-' | |  <--| +-->  | |
 | '---'-' '-----' '-----' |
 |  ascii     2      svg   |
 |                         |
 '-------------------------'

https://github.com/asciitosvg

[1,0]: {"fill":"#88d","a2s:delref":1}
```

### gnuplot
gnuplot 代码如下，效果见 [@fig:plot_gnuplot]。

~~~markdown
```{#fig:plot_gnuplot .plot:gnuplot caption="gnuplot 示例"}
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
~~~

```{#fig:plot_gnuplot .plot:gnuplot caption="gnuplot 示例"}
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

使用 gnuplot 绘制数据图时，建议将数据文件放在 `src/data/` 目录下，示例如下，效果见 [@fig:plot_gnuplot2]。

~~~markdown
```{#fig:plot_gnuplot2 .plot:gnuplot caption="gnuplot 绘制数据图"}
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
~~~

```{#fig:plot_gnuplot2 .plot:gnuplot caption="gnuplot 绘制数据图"}
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