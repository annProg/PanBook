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