
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

#### 安装
需要安装 librsvg 用于 SVG 转 PDF。msys2 上使用 `pacman -S mingw64/mingw-w64-x86_64-librsvg` 安装。

目前支持以下画图引擎，如需使用，请安装对应软件并加入 PATH 环境变量

- dot,neato,fdp,sfdp,twopi,circo (from graphviz)
- ditaa （建议使用 go 语言版本 https://github.com/akavel/ditaa/releases）
- goseq （https://github.com/pandoc-ebook/goseq/releases）

#### 用法

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

#### 示例

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