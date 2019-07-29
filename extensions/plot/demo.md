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

```{#fig:gnuplot .plot:gnuplot caption="gnuplot Demo"}
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