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
