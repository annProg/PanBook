
## 数学
#### Extension: tex_math_dollars

所有介于两个`$`字元之间的内容将会被视为TeX数学公式处理。开头的`$`右侧必须立刻接上任意文
字，而结尾`$`的左侧同样也必须紧挨着文字。这样一来，`$20,000  and  $30,000`就不会被当作数学公
式处理了。如果基于某些原因，有必须使用`$`符号将其他文字括住的需求时，那么可以在`$`前使用反
斜线跳脱字元，这样`$`就不会被当作数学公式的分隔符。

TeX 数学公式会在所有输出格式中印出。至于会以什么方式演算编排(render) 则取决于输出的格式：

#### Markdown, LaTeX, Org-Mode, ConTeXt
公式会以字面文字呈现在两个$符号之间。

#### reStructuredText
公式会使用此处所描述的:math:这个“interpreted text role”来进行演算编排。

#### AsciiDoc
公式会以latexmath:[...]演算编排。

#### Texinfo
公式会在@math指令中演算编排。

#### groff man
公式会以去掉`$`后的字面文字演算编排。

#### MediaWiki
公式会在<math>标签中演算编排。

#### Textile
公式会在`<span class="math">`标签中演算编排。

#### RTF, OpenDocument, ODT
如果可以的话，公式会以unicode 字元演算编排，不然就直接使用字面字元。

#### Docbook
如果使用了`--mathml`旗标，公式就会在inlineequation或informalequation标签中
使用mathml演算编排。否则就会尽可能使用unicode字元演算编排。

#### Docx
公式会以OMML 数学标记的方式演算编排。

#### FictionBook2
如果有使用`--webtex`选项，公式会以Google Charts或其他相容的网路服务演算编排为
图片，并下载嵌入于电子书中。否则就会以字面文字显示。

#### HTML, Slidy, DZSlides, S5, EPUB
公式会依照以下命令列选项的设置，以不同的方法演算编排为HTML 代码。

预设方式是将TeX数学公式尽可能地以unicode字元演算编排，如同RTF、DocBook以及OpenDocument的
输出。公式会被放在附有属性`class="math"`的span标签内，所以可以在需要时给予不同的样式，使其
突出于周遭的文字内容。

如果使用了`--latexmathml`选项，TeX数学公式会被显示于`$`或`$$`字元中，并放在附带LaTeX类别
的`<span>`标签里。这段内容会用LaTeXMathML script演算编排为数学公式。（这个方法无法适用于
所有浏览器，但在Firefox中是有效的。在不支援LaTeXMathML的浏览器中，TeX数学公式会单纯的以
两个$字元间的字面文字呈现。）

如果使用了`--jsmath`选项，TeX数学公式会放在`<span>`标签（用于行内数学公式）或`<div>`标签
（用于区块数学公式）中，并附带类别属性math。这段内容会使用jsMath script来演算编排。

如果使用了`--mimetex`选项，mimeTeX CGI script会被呼叫来产生每个TeX数学公式的图片。这适用
于所有浏览器。`--mimetex`选项有一个可选的URL参数。如果没有指定URL，它会假设mimeTeX CGI 
script的位置在`/cgi-bin/mimetex.cig`。

如果使用了`--gladtex`选项，TeX数学公式在HTML的输出中会被`<eq>`标签包住。产生的htex档案之
后可以透过gladTeX处理，这会针对每个数学公式生成图片，并于最后生成一个包含这些图片连结的html
档案。所以，整个处理流程如下：
```
pandoc -s --gladtex myfile.txt -o myfile.htex
gladtex -d myfile-images myfile.htex
# produces myfile.html and images in myfile-images
```

如果使用了`--webtex`选项，TeX数学公式会被转换为`<img>`标签并连结到一个用以转换公式为图片的
外部script。公式将会编码为URL可接受格式并且与指定的URL参数串接。如果没有指定URL，那么将会
使用Google Chart API (  http://chart.apis.google.com/chart?cht=tx&chl=)。

如果使用了`--mathjax`选项，TeX数学公式将会被包在`\(...\)`（用于行内数学公式）或`\[...\]`（用
于区块数学公式）之间显示，并且放在附带类别math的`<span>`标签之中。这段内容会使用MathJax script
演算编排为页面上的数学公式。

## Raw HTML

#### Extension: raw_html

Markdown允许你在文件中的任何地方插入原始HTML（或DocBook）指令（除了在字面文字上下文处，
此时的`<`, `>`和&都会按其字面意义显示）。（技术上而言这不算扩充功能，因为原始markdown本身就
有提供此功能，但做成扩充形式便可以在有特殊需要的时候关闭此功能。）

输出HTML, S5, Slidy, Slideous, DZSlides, EPUB, Markdown 以及Textile 等格式时，原始HTML 代
码会不作修改地保留至输出档案中；而其他格式的输出内容则会将原始HTML 代码去除掉。

#### Extension: markdown_in_html_blocks

原始markdown允许你插入HTML「区块」：所谓的HTML区块是指，上下各由一个空白行所隔开，开始与结尾
均由所在行最左侧开始的一连串对称均衡的HTML标签。在这个区块中，任何内容都会当作是HTML来分析，
而不再视为markdown；所以（举例来说），*符号就不再代表强调。

当指定格式为markdown_strict时，Pandoc会以上述方式处理；但预设情况下，Pandoc能够以markdown语法
解读HTML区块标签中的内容。举例说明，Pandoc能够将底下这段
```
<table>
    <tr>
        <td>*one*</td>
        <td>[a link](http://google.com)</td>
    </tr>
</table>
```
转换为
```
<table>
    <tr>
        <td><em>one</em></td>
        <td><a href="http://google.com">a link</a></td>
    </tr>
</table>
```
而Markdown.pl则是保留该段原样。

这个规则只有一个例外：那就是介于`<script>`与`<style>`之间的文字都不会被拿来当作markdown解读。

这边与原始markdown的分歧，主要是为了让markdown能够更便利地混入HTML区块元素。比方说，一段
markdown文字可以用`<div>`标签将其前后包住来进行样式指定，而不用担心里面的markdown不会被解
译到。

## Raw TeX

#### Extension: raw_tex

除了HTML 之外，pandoc 也接受文件中嵌入原始LaTeX, TeX 以及ConTeXt 代码。行内TeX 指令会被保留
并不作修改地输出至LaTeX 与ConTeXt 格式中。所以，举例来说，你可以使用LaTeX 来导入BibTeX 的引
用文献：
```
This result was proved in \cite{jones.1967}.
```
请注意在LaTeX 环境下时，像是底下
```
\begin{tabular}{|l|l|}\hline
Age & Frequency \\ \hline
18--25  & 15 \\
26--35  & 33 \\
36--45  & 22 \\ \hline
\end{tabular}
```
位在begin与end标签之间的内容，都会被当作是原始LaTeX资料解读，而不会视为markdown。

行内LaTeX 在输出至Markdown, LaTeX 及ConTeXt 之外的格式时会被忽略掉。

## LaTeX 巨集

#### Extension: latex_macros

当输出格式不是LaTeX时，pandoc会分析LaTeX的`\newcommand`和`\renewcommand`定义，并套用
其产生的巨集到所有LaTeX数学公式中。所以，举例来说，下列指令对于所有的输出格式均有作
用，而非仅仅作用于LaTeX格式：
```
\newcommand{\tuple}[1]{\langle #1 \rangle}

$\tuple{a, b, c}$
```
在LaTeX的输出中，`\newcommand`定义会单纯不作修改地保留至输出结果。

## 连结

Markdown 接受以下数种指定连结的方式。

### 自动连结
如果你用角括号将一段URL 或是email 位址包起来，它会自动转换成连结：

<http://google.com>

<sam@green.eggs.ham>

### 行内连结
一个行内连结包含了位在方括号中的连结文字，以及方括号后以圆括号包起来的URL。（你可以选
择性地在URL 后面加入连结标题，标题文字要放在引号之中。）
```
This is an [inline link](/url), and here's [one with
a title](http://fsf.org "click here for a good time!").
```

This is an [inline link](/url), and here's [one with
a title](http://fsf.org "click here for a good time!").

方括号与圆括号之间不能有空白。连结文字可以包含格式（例如强调），但连结标题则否。

### 参考连结
一个明确的参考连结包含两个部分，连结本身以及连结定义，其中连结定义可以放在文件的任何地
方（不论是放在连结所在处之前或之后）。

连结本身是由两组方括号所组成，第一组方括号中为连结文字，第二组为连结标签。（在两个方括号
间可以有空白。）连结定义则是以方括号框住的连结标签作开头，后面跟着一个冒号一个空白，再接
着一个URL，最后可以选择性地（在一个空白之后）加入由引号或是圆括号包住的连结标题。

以下是一些范例：
```
[my label 1]: /foo/bar.html  "My title, optional"
[my label 2]: /foo
[my label 3]: http://fsf.org (The free software foundation)
[my label 4]: /bar#special  'A title in single quotes'
```
连结的URL 也可以选择性地以角括号包住：
```
[my label 5]: <http://foo.bar.baz>
```
连结标题可以放在第二行，效果见[my label 3]：
```
[my label 3]: http://fsf.org
  "The free software foundation"
```

[my label 3]: http://fsf.org
  "The free software foundation"

需注意连结标签并不区分大小写。所以下面的例子会建立合法的连结：
```
Here is [my link][FOO]

[Foo]: /bar/baz
```
在一个隐性参考连结中，第二组方括号的内容是空的，甚至可以完全地略去：
```
See [my website][], or [my website].

[my website]: http://foo.bar.baz
```
注意：在Markdown.pl以及大多数其他markdown实作中，参考连结的定义不能存在于嵌套结构中，例
如清单项目或是区块引言。Pandoc lifts this arbitrary seeming restriction。所以虽然下面的
语法在几乎所有其他实作中都是错误的，但在pandoc中可以正确处理：

```
> My block [quote].
>
> [quote]: /foo
```

### 内部连结
要连结到同一份文件的其他章节，可使用自动产生的ID（参见HTML, LaTeX与ConTeXt的标题识别符一
节后半）。
```
See the [Introduction](#introduction).
```
或是
```
See the [Introduction].

[Introduction]: #introduction
```
内部连结目前支援的格式有HTML（包括HTML slide shows 与EPUB）、LaTeX 以及ConTeXt。

## 图片

在连结语法的前面加上一个!就是图片的语法了。连结文字将会作为图片的替代文字（alt text）：
```
![la lune](Pictures/background.pdf "Voyage to the moon")

![movie reel]

[movie reel]: movie.gif
```
效果如图\ref{fig:markdown}。

![Markdown\label{fig:markdown}](images/markdown.jpg "Markdown")

### 附上说明的图片
#### Extension: implicit_figures

一个图片若自身单独存在一个段落中，那么将会以附上图片说明(caption)的图表(figure)形式呈
现。（在LaTeX中，会使用图表环境；在HTML中，图片会被放在具有figure类别的div元素中，并会附
上一个具有caption类别的p元素。）图片的替代文字同时也会用来作为图片说明。

```
![This is the caption](/url/of/image.png)
```
如果你只是想要个一般的行内图片，那么只要让图片不是段落里唯一的元素即可。一个简单的方法
是在图片后面插入一个不断行空格：
```
![This image won't be a figure](/url/of/image.png)\
```

## 交叉引用
Pandoc扩展的Markdown语法可以为代码块添加ID属性及语言类型属性，形如`{#id .language}`，其中ID属性可以用来做交叉引用，使用`\ref{id}`在正文中引用代码块。例如代码块\ref{code:demo}。

