
## 标题
有两种不同形式的标题语法，Setext 以及Atx。Setext风格的标题是由一行文字底下接着一
行=符号（用于一阶标题）或-符号（用于二阶标题）所构成；Atx风格的标题是由一到六个#符
号以及一行文字所组成，你可以在文字后面加上任意数量的#符号。由行首起算的#符号数量决
定了标题的阶层，如代码[@lst:markdownTitle]所示。
```{#lst:markdownTitle .markdown caption="Markdown标题"}
Setext A level-one header
==================

Setext A level-two header
------------------

# Atx level-one

## Atx level-two

### Atx  level-three
```

#### Extension: blank_before_header
原始markdown语法在标题之前并不需要预留空白行。Pandoc则需要（除非标题位于文件最开始的
地方）。这是因为以#符号开头的情况在一般文字段落中相当常见，这会导致非预期的标题。例如[@lst:blank_before_header]。
```{#lst:blank_before_header caption="标题前置空行"}
I like several of their flavors of ice cream:
#22, for example, and #5.
```

这也是[@sec:note]所述注意事项的原因。

### 标题标识符
#### Extension: header_attributes
在标题文字所在行的行尾，可以使用以下语法为标题加上属性：
```
{#identifier .class .class key=value key=value}
```
虽然这个语法也包含加入类别(class)以及键／值形式的属性(attribute)，
但目前只有标识符(identifier/ID)在输出时有实际作用（且只在部分格式
的输出，包括：HTML, LaTeX, ConTeXt, Textile, AsciiDoc）。举例来说，
下面是将标题加上foo标识符的几种方法：
```markdown
# My header {#foo}

## My header ##    {#foo}

My other header   {#foo}
---------------
```
（此语法与PHP Markdown Extra相容。）

具有unnumbered类别的标题将不会被编号，即使--number-sections的选项是开启
的。单一连字符号( -)等同于.unnumbered，且更适用于非英文文件中。因此，
```markdown
# My header {-}
```
与下面这行是等价的
```markdown
# My header {.unnumbered}
```