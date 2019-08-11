::: {.abstract keywords="\LaTeX{}，PanBook，Markdown，论文排版"}
本文介绍了基于 Pandoc 使用 Markdown 写作论文的一种方案。Markdown 是一种简单易学的标记语言。相对于 \LaTeX ，使用 Markdown 作为写作语言，能够让作者专注于内容而非排版，排版工作则由 Pandoc 基于预定义的 \LaTeX 模板生成 PDF。本方案既能获得 \LaTeX 排版效果，又避免了 \LaTeX 的复杂性，尤其适合 \LaTeX 新手，对于熟悉 \LaTeX 的作者也不失为不错的替代选择。另外，由于 Markdown 内容和 \LaTeX 模板分离，作者只需维护一份源码，通过编译生成不同样式的文档，降低了维护成本。
:::

# 使用方法
本章简要介绍 panbook^[https://github.com/annProg/PanBook] 的安装，基本使用方法及 Pandoc's Markdown 语法。建议读者阅读 PanBook 使用手册^[https://panbook.annhe.net/pub/PanBook-book-ctexbook-pc.pdf] [@panbook] 获取更详细的内容。

## 快速入门
以 Windows 10 为例，演示如何使用。首先需要安装依赖软件。

- 安装 [msys2](https://www.msys2.org/) （ Linux 及 OS X 请忽略此步骤）
- 安装 [texlive](http://mirror.ctan.org/systems/texlive/Images/) 2018 或以上版本
- 安装 [Pandoc](https://pandoc.org/installing.html) 2.7.3 或以上版本
- 下载 [pandoc-crossref](https://github.com/lierdakil/pandoc-crossref/releases) 对应版本安装到 path 目录下（建议和 Pandoc 放同一目录）

然后下载 PanBook。打开终端（ msys2 ），假设工作目录为 /d/dev ，克隆代码并设置环境变量：

```bash
$ cd /d/dev
$ git clone https://github.com/annProg/PanBook
# 将 PanBook，TeXLive 及 Pandoc 加入环境变量
$ tail -n 1 ~/.bashrc
export PATH=$PATH:/d/texlive/2018/bin/win32:/d/dev/PanBook:/c/Users/myname/AppData/Local/Pandoc
```

完成环境变量设置之后，在任意空目录下执行 `panbook thesis`，会自动初始化写作环境，生成示例源码。然后在 src 目录下开始写作。目录规范见 [@lst:panbookdirs]。

```{#lst:panbookdirs .bash caption="PanBook 目录规范"}
.
|-- extensions              # 自定义扩展
|-- fonts                   # 自定义字体
|-- src                     # Markdown 源码目录
|   |-- images              # 插图目录
|   |-- metadata.yaml       # 书籍元数据文件
|   |-- frontmatter.md      # 前言文件
|   |-- backmatter.md       # 后记文件
|   |-- 100-chapter1.md     # 正文，命名须保证能按正确章节顺序列出
|   `-- 200-chapter2.md
|-- styles                   # 自定义风格
|-- templates                # 自定义模板 
`-- build                    # 电子书构建目录
```

## 指定风格（style）
风格（style），也可以理解为模板（为了和 pandoc 模板区分），是预定义的文档样式。通过 `--style` 参数指定，缺省时，会使用默认风格 (thesis)，通过命令 `panbook thesis -l` 查看模块支持的风格列表：

```bash
$ panbook thesis -l
thesis
```

支持和计划支持的学校论文模板如 [@tbl:thesis_styles] 所示。

学校 | style 名称 |状态
:---|:--|:-----
demo|thesis|完成
湖南大学|hnu| WIP
清华大学|thu| WIP
上海交通大学|sjtu| WIP
南京大学|nju| WIP
山东大学|sdu| WIP
中国科学院大学|ucas|WIP
电子科技大学|uestc| WIP
北京航空航天大学|buaa| WIP

: 支持的论文模板 {#tbl:thesis_styles}

## 调试模式
加 `-d` 选项，会输出详细的 `latexmk` 编译过程，加 `--trace` 选项，可以输出更多的调试信息。

## 注意事项 {#sec:note}

- Markdown 源码文件需要使用 UTF-8 编码
- Pandoc 扩展的 Markdown 语法要求在标题前留出一个空行，因此按章节拆分的多个 Markdown 文件，开头需要空一行，否则 pandoc 不能正确识别标题
- 请勿将正文文件命名为 *frontmatter.md 或者 *backmatter.md ，这 2 个文件有特殊用途

## 论文元数据
在 src/metadata.yaml 中使用 Yaml 语言^[http://www.ruanyifeng.com/blog/2016/07/yaml.html] 定义书籍的数据及可用的模板变量，示例见 [@lst:metayaml]。
```{#lst:metayaml .yaml caption="Metadata"}
---
title: 基于 Markdown 的论文写作方法
etitle: A Thesis Writing Method Based On Markdown
author:          # 作者（数组）
  - 作者
xuehao: 201907131122
college: 计算机学院
supervisor: \LaTeX  教授
date: \today     # 日期
lof: false        # 是否生成插图列表页
lot: false        # 是否生成表格列表页
# 不引用，但是显示在参考文献列表里。通配符 @* 表示全部在列表里显示
nocite: |
  @pandocManual
...
```

查看模板文件，可以获取模板支持的所有变量（形如`$var$`)。也可以通过修改模板来添加自定义的变量。

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

# 后记 {-}

参考文献不要放到`backmatter.md`中。用`{-}`表示标题不编号。

::: {#refs}
# 参考文献 {-}
:::