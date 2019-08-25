```
+--------+   +-------+    +-------+
|        | --+ ditaa +--> |       |
|  Text  |   +-------+    |diagram|
|Document|   |!magic!|    |       |
|     {d}|   |       |    |       |
+---+----+   +-------+    +-------+
	:                         ^
	|       Lots of work      |
	+-------------------------+
```		

see [@fig:dot].

```{#fig:dot .plot:dot caption="Graphviz Dot Demo"}
digraph G{
	"Markdown" -> "LaTeX" -> "PDF";
}
```

see [@fig:ditaa].

```{#fig:ditaa .plot:ditaa caption="Ditaa Demo"}
+--------+   +-------+    +-------+
|        | --+ ditaa +--> |       |
|  Text  |   +-------+    |diagram|
|Document|   |!magic!|    |       |
|     {d}|   |       |    |       |
+---+----+   +-------+    +-------+
	:                         ^
	|       Lots of work      |
	+-------------------------+
```		

see [@fig:goseq]

```{#fig:goseq .plot:goseq caption="Goseq Demo"}
Client->Server: Make request
Server->Database: Make database\nrequest
Database->Server: The result
Server->Client: The response
```

see [@fig:asciitosvg]

```{#fig:asciitosvg .plot:a2s caption="A2s Demo"}
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

gnuplot. See [@fig:gnuplot]

```{#fig:gnuplot .plot:gnuplot .testclass caption="gnuplot Demo" width=50%}
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

asymptote. See [@fig:asymptote]

```{#fig:asymptote .plot:asy caption="Asymptote Demo"}
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

## Sub Figure

See[@fig:subfig].

::: {#fig:subfig}
```{#fig:sub_asymptote .plot:asy caption="Asymptote Demo" width=40% subfig=1}
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
```{#fig:sub1_asymptote .plot:asy caption="Asymptote Demo" width=40% subfig=1}
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

This Para is Caption
:::

::: {#test .help}
Test
:::

see [@fig:abc].

```{#fig:abc .plot:abc caption="ABC notation"}
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

see [@fig:tikz]

```{#fig:tikz .plot:tikz caption="TIKZ" usepackage="\\usepackage{ctex}"}
\begin{tikzpicture}
	\draw (0,0)--(0,4);
	\draw (0,0)--(4,0);
	\draw (4,0) arc[start angle=0,end angle=90,radius=4cm];
\end{tikzpicture}
```