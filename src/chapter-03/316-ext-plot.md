
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
- abc （安装 abcm2ps，可以在 http://abcplus.sourceforge.net/ 下载 windows 和 linux 的二进制文件）

### 用法

使用代码块语法

- 为正常使用交叉引用，id 格式须符合 `fig:<label>`
- 样式格式须为 `plot:<plot engine>`，比如 `plot:dot`
- 其他样式需在 `plot:<plot engine>` 之后
- 可像 图片语法（见 [@sec:image]） 一样设置 `key=val` 格式属性，比如 `width=50%`
- 可以使用 pandoc-crossref 的子图语法（见 [@sec:crossref]），区别是 图片代码块 必须有 `subfig` 属性来给子图分组，格式 `subfig=group number`，分组数字相同的将在同一行显示。

~~~markdown
```{#fig:<label> .plot:<engine> .class caption="<caption>" key=val}
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

```{#fig:plot_dot .plot:dot caption="Dot 示例" width=30%}
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

```{#fig:plot_ditaa .plot:ditaa caption="Ditaa 示例" width=50%}
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
```{#fig:plot_goseq .plot:goseq caption="Goseq Demo" width=50%}
Client->Server: Make request
Server->Database: Make database\nrequest
Database->Server: The result
Server->Client: The response
```
~~~

```{#fig:plot_goseq .plot:goseq caption="Goseq Demo" width=50%}
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

```{#fig:plot_a2s .plot:a2s caption="A2s Demo" width=45%}
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

```{#fig:plot_gnuplot2 .plot:gnuplot caption="gnuplot 绘制数据图" width=70%}
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

### Asymptote

示例如下，效果见 [@fig:plot_asy]。

~~~markdown
```{#fig:plot_asy .plot:asy caption="Asymptote 示例" width=40%}
import math;
import graph;
size(0,400);

real f(real t) {return 2*cos(t);}
pair F(real x) {return (x,f(x));}

draw(polargraph(f,0,pi,operator ..));

defaultpen(fontsize(20pt));

xaxis("$x$");
yaxis("$y$");

real theta=radians(50);
real r=f(theta);
draw("$\theta$",arc((0,0),0.5,0,degrees(theta)),red,Arrow,PenMargins);

pair z=polar(r,theta);
draw(z--(z.x,0),dotted+red);
draw((0,0)--(z.x,0),dotted+red);
label("$r\cos\theta$",(0.5*z.x,0),0.5*S,red);
label("$r\sin\theta$",(z.x,0.5*z.y),0.5*E,red);
dot("$(x,y)$",z,N);
draw("r",(0,0)--z,0.5*unit(z)*I,blue,Arrow,DotMargin);

dot("$(a,0)$",(1,0),NE);
dot("$(2a,0)$",(2,0),NE);
```
~~~

```{#fig:plot_asy .plot:asy caption="Asymptote 示例" width=40%}
import math;
import graph;
size(0,400);

real f(real t) {return 2*cos(t);}
pair F(real x) {return (x,f(x));}

draw(polargraph(f,0,pi,operator ..));

defaultpen(fontsize(20pt));

xaxis("$x$");
yaxis("$y$");

real theta=radians(50);
real r=f(theta);
draw("$\theta$",arc((0,0),0.5,0,degrees(theta)),red,Arrow,PenMargins);

pair z=polar(r,theta);
draw(z--(z.x,0),dotted+red);
draw((0,0)--(z.x,0),dotted+red);
label("$r\cos\theta$",(0.5*z.x,0),0.5*S,red);
label("$r\sin\theta$",(z.x,0.5*z.y),0.5*E,red);
dot("$(x,y)$",z,N);
draw("r",(0,0)--z,0.5*unit(z)*I,blue,Arrow,DotMargin);

dot("$(a,0)$",(1,0),NE);
dot("$(2a,0)$",(2,0),NE);
```

### 乐谱（abc notation）
示例如下，效果见 [@fig:plot_abc]。

~~~markdown
```{#fig:plot_abc .plot:abc caption="ABC notation"}
X:1
T:Speed the Plough
M:4/4
C:Trad.
K:G
|:GABc dedB|dedB dedB|c2ec B2dB|c2A2 A2BA|
  GABc dedB|dedB dedB|c2ec B2dB|A2F2 G4:|
|:g2gf gdBd|g2f2 e2d2|c2ec B2dB|c2A2 A2df|
  g2gf g2Bd|g2f2 e2d2|c2ec B2dB|A2F2 G4:|
```
~~~

```{#fig:plot_abc .plot:abc caption="ABC notation"}
X:1
T:Speed the Plough
M:4/4
C:Trad.
K:G
|:GABc dedB|dedB dedB|c2ec B2dB|c2A2 A2BA|
  GABc dedB|dedB dedB|c2ec B2dB|A2F2 G4:|
|:g2gf gdBd|g2f2 e2d2|c2ec B2dB|c2A2 A2df|
  g2gf g2Bd|g2f2 e2d2|c2ec B2dB|A2F2 G4:|
```

### tikz

示例如下，效果见 [@fig:plot_tikz]。如需引入自定义包，请使用 `usepackage` 属性。

~~~markdown
```{#fig:plot_tikz .plot:tikz caption="TIKZ 示例" usepackage="\\usepackage{ctex}"}
\begin{tikzpicture}
	\draw (0,0)--(0,4);
	\draw (0,0)--(4,0);
	\draw (4,0) arc[start angle=0,end angle=90,radius=4cm];
\end{tikzpicture}
```
~~~

```{#fig:plot_tikz .plot:tikz caption="TIKZ 示例"}
\begin{tikzpicture}
	\draw (0,0)--(0,4);
	\draw (0,0)--(4,0);
	\draw (4,0) arc[start angle=0,end angle=90,radius=4cm];
\end{tikzpicture}
```

### 子图
代码如下，效果见 [@fig:plot_subfig]。

~~~markdown
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
~~~

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