
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
公式会在\<math\>标签中演算编排。

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
```bash
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