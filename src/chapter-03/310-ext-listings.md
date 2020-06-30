
## listings

::: {.info caption="扩展信息"}
使用场景
  ~ 提供 listings 及 pandoc 原生代码环境样式定义。为 pandoc 原生代码块环境实现阴影和自动换行。

启用状态
  ~ 默认在所有模块中启用

格式支持  
  ~ \LaTeX 

语法系列
  ~ 无
:::

#### 示例

此扩展提供的 listings 样式如下：

```latex
\lstset{
	basicstyle=\small\linespread{1}\ttfamily,
	keywordstyle=\color[rgb]{0.13,0.29,0.53}\textbf,
	commentstyle=\color{gray},
	identifierstyle=\color[rgb]{0.00,0.00,0.00},
	stringstyle=\color[rgb]{0.31,0.60,0.02},
	frame=shadowbox,
	rulesepcolor=\color{red!20!green!20!blue!20},
	backgroundcolor=\color[rgb]{0.97,0.97,0.97},
	tabsize=4,
	breaklines=tr,
	showstringspaces=false,
}
```

用户可通过命令行参数替换为自己的样式：

```bash
$ panbook ext -h listings
        -G ext-listings:<true|false>                        enable listings(default true)
        -G ext-listings-lstset:<custom listings set file>   change listings set file
```