
# Pandoc Markdown语法简介
Pandoc 的目标与原始Markdown 的最初目标有着方向性的不同。在Markdown 原本的设计中，
HTML 是其主要输出对象；然而Pandoc 则是针对多种输出格式而设计。因此，虽然Pandoc 
同样也允许直接嵌入HTML 标签，但并不鼓励这样的作法，取而代之的是Pandoc 提供了许多
非HTML 的方式，来让使用者输入像是定义列表、表格、数学公式以及脚注等诸如此类的重
要文件元素。

Pandoc Markdown语法介绍可以在[Pandoc主页](http://www.pandoc.org/MANUAL.html#pandocs-markdown) 
找到。以下翻译大部分部分摘自[tzengyuxiao的翻译](http://pages.tzengyuxio.me/pandoc/)，
在此向译者表示感谢。

## 段落
一个段落指的是一行以上的文字，跟在一行以上的空白行之后。换行字元会被当作是空白处
理，因此你可以依自己喜好排列段落文字。如果你需要强制换行，在行尾放上两个以上的空
白字元即可。

#### Extension: escaped_line_breaks
一个反斜线后跟着一个换行字元，同样也有强制换行的效果。这也是在表格单元格中添加换
行的唯一形式。

## 标题
有两种不同形式的标题语法，Setext 以及Atx。Setext风格的标题是由一行文字底下接着一
行=符号（用于一阶标题）或-符号（用于二阶标题）所构成；Atx风格的标题是由一到六个#符
号以及一行文字所组成，你可以在文字后面加上任意数量的#符号。由行首起算的#符号数量决
定了标题的阶层，如代码\ref{code:markdownTitle}所示。
```{#code:markdownTitle caption="测试"}
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
地方）。这是因为以#符号开头的情况在一般文字段落中相当常见，这会导致非预期的标题。例如：
```
I like several of their flavors of ice cream:
#22, for example, and #5.
```

这也是前一章所述注意事项\ref{title:note}的原因。

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
```
# My header {#foo}

## My header ##    {#foo}

My other header   {#foo}
---------------
```
（此语法与PHP Markdown Extra相容。）

具有unnumbered类别的标题将不会被编号，即使--number-sections的选项是开启
的。单一连字符号( -)等同于.unnumbered，且更适用于非英文文件中。因此，
```
# My header {-}
```
与下面这行是等价的
```
# My header {.unnumbered}
```

## 引用
Markdown使用email的习惯来建立引用区块。一个引用区块可以由一或多个段落
或其他的区块元素（如列表或标题）组成，并且其行首均是由一个>符号加上一
个空白作为开头。（>符号不一定要位在该行最左边，但也不能缩进超过三个空白）。

```
> This is a block quote. This
> paragraph has two lines.
>
> 1. This is a list inside a block quote.
> 2. Second item.
```
效果如下：

> This is a block quote. This
> paragraph has two lines.
>
> 1. This is a list inside a block quote.
> 2. Second item.

有一个「偷懒」的形式：你只需要在引用区块的第一行行首输入>即可，后面的
行首可以省略符号：
```
> This is a block quote. This
paragraph has two lines.

> 1. This is a list inside a block quote.
2. Second item.
```
由于区块引用可包含其他区块元素，而区块引用本身也是区块元素，所以，引用
是可以嵌套入其他引用的。

```
> This is a block quote.
>
>> A block quote within a block quote.
```
#### Extension: blank_before_blockquote

原始markdown语法在区块引用之前并不需要预留空白行。Pandoc则需要（除非区
块引用位于文件最开始的地方）。这是因为以>符号开头的情况在一般文字段落中
相当常见（也许由于断行所致），这会导致非预期的格式。因此，除非是指定为
markdown_strict格式，不然以下的语法在pandoc中将不会产生出嵌套区块引用：
```
> This is a block quote.
>> Nested.
```

## 代码
### 缩进式代码块
由四个空格或一个tab缩进的文本取做代码块，区块中的特殊字符、空格和换行都会
被保留，而缩进的空格和tab会在输出中移除，但在代码块中的空行不必缩进。

    #!/bin/bash

    echo "Hello Markdown"
	echo "Hello LaTeX"
### 围栏式代码块
#### Extension: fenced_code_blocks

除了标准的缩进式代码块之外，Pandoc还支持围栏式代码块， 代码块以三个或三个以
上的\~符号行开始，以等于或多于开始行\~个数符号行结束， 若是代码块中含有\~，只需
使开始行和结束行中的\~符号个数多于代码块中的即可

```
~~~~~
~~~~
code here
~~~~
~~~~~~
```

#### Extension: backtick_code_blocks

与`fenced_code_blocks`相同，只不过使用反引号 \` 替换波浪线 \~ 而已


#### Extension: fenced_code_attributes

```{#code:fencedcode .numberLines startFrom="100" caption="围栏式代码块"}
~~~~ {#code:mycode .haskell .numberLines startFrom="100" caption="围栏式代码块"}
qsort []     = []
qsort (x:xs) = qsort (filter (< x) xs) ++ [x] ++
               qsort (filter (>= x) xs)
~~~~~~
```
这里的mycode为ID，haskell与numberLines是类别，而startsFrom则是值为
100的属性。numberLines和startFrom配合使用可以显示代码行号，如果没有
指定startFrom，则默认从1开始。caption指定代码块标题，如果没有设置
caption，则默认使用ID作为caption。有些输出格式可以利用这些信息来作语法
高亮。目前使用到这些信息的输出格式仅有HTML与LaTeX。如果指定的输出格
式及语言类别有语法高亮支持，那么上面那段代码区块将会以高亮并带有行号
的方式呈现。

仅指定高亮语言时，可以简写为以下形式：

```
~~~haskell
qsort [] = []
~~~
```

## 行区块

#### Extension: line_blocks

行区块是一连串以竖线( |)加上一个空格所构成的连续行。行与行间的区隔在
输出时将会以原样保留，行首的空白字元数目也一样会被保留；反之，这些行
将会以markdown的格式处理。这个语法在输入诗句或地址时很有帮助。
```
| The limerick packs laughs anatomical
| In space that is quite economical.
|    But the good ones I've seen
|    So seldom are clean
| And the clean ones so seldom are comical

| 200 Main St.
| Berkeley, CA 94718
```

如果有需要的话，书写时也可以将完整一行拆成多行，但后续行必须以空白作为开始。
下面范例的前两行在输出时会被视为一整行：
```
| The Right Honorable Most Venerable and Righteous Samuel L.
  Constable, Jr.
| 200 Main St.
| Berkeley, CA 94718
```

效果：

| The limerick packs laughs anatomical
| In space that is quite economical.
|    But the good ones I've seen
|    So seldom are clean
| And the clean ones so seldom are comical

| 200 Main St.
| Berkeley, CA 94718

这是从reStructuredText借来的语法。


## 列表
### 无序列表
无序列表是以项目符号作列举的列表。每条项目都以项目符号( *, +或-)作开头。
下面是个简单的例子：
```
* one
* two
* three
```
显示如下

* one
* two
* three

这会产生一个「紧凑」列表。如果你想要一个「宽松」列表，也就是说以段落格式处
理每个项目内的文字内容，那么只要在每个项目间加上空白行即可：
```
* one

* two

* three
```
项目符号不能直接从行首最左边处输入，而必须以一至三个空白字元作缩进。项目符号
后必须跟着一个空白字元。

列表项目中的接续行，若与该项目的第一行文字对齐（在项目符号之后），看上去会较
为美观：
```
* here is my first
  list item.
* and my second.
```
但markdown 也允许以下「偷懒」的格式：
```
* here is my first
list item.
* and my second.
```
#### 四个空白规则
一个列表项目可以包含多个段落以及其他区块等级的内容。然而，后续的段落必须接在空
白行之后，并且以四个空白或一个tab 作缩进。因此，如果项目里第一个段落与后面段落
对齐的话（也就是项目符号前置入两个空白），看上去会比较整齐美观：
```
  * First paragraph.

    Continued.

  * Second paragraph. With a code block, which must be indented
    eight spaces:

        { code }
```
列表项目也可以包含其他列表。在这情况下前置的空白行是可有可无的。嵌套列表必须以四
个空白或一个tab 作缩进：
```
* fruits
    + apples
        - macintosh
        - red delicious
    + pears
    + peaches
* vegetables
    + brocolli
    + chard
```	
上一节提到，markdown 允许你以「偷懒」的方式书写，项目的接续行可以不和第一行对齐。不过，
如果一个列表项目中包含了多个段落或是其他区块元素，那么每个元素的第一行都必须缩进对齐。
```
+ A lazy, lazy, list
item.

+ Another one; this looks
bad but is legal.

    Second paragraph of second
list item.
```
**注意：**尽管针对接续段落的「四个空白规则」是出自于官方的markdown syntax guide，但是作
为对应参考用的Markdown.pl实作版本中并未遵循此一规则。所以当输入时若接续段落的缩进少于四
个空白时，pandoc所输出的结果会与Markdown.pl的输出有所出入。

在markdown syntax guide中并未明确表示「四个空白规则」是否一体适用于所有位于列表项目里的
区块元素上；规范文件中只提及了段落与代码区块。但文件暗示了此规则适用于所有区块等级的内容
（包含嵌套列表），并且pandoc以此方向进行解读与实作。

### 有序列表
有序列表与无序列表相类似，唯一的差别在于列表项目是以列举编号作开头，而不是项目符号。

在原始markdown 中，列举编号是阿拉伯数字后面接着一个句点与空白。数字本身代表的数值会被忽
略，因此下面两个列表并无差别：

```
1.  one
2.  two
3.  three
```
上下两个列表的输出是相同的。
```
5.  one
7.  two
1.  three
```

#### Extension: fancy_lists

与原始markdown不同的是，Pandoc除了使用阿拉伯数字作为有序列表的编号外，也可以使用大写或
小写的英文字母，以及罗马数字。列表标记可以用括号包住，也可以单独一个右括号，抑或是句号。
如果列表标记是大写字母接着一个句号，句号后请使用至少两个空白字元。

#### Extension: startnum

除了列表标记外，Pandoc 也能判读列表的起始编号，这两项资讯都会保留于输出格式中。举例来说，
下面的输入可以产生一个从编号9 开始，以单括号为编号标记的列表，底下还跟着一个小写罗马数字
的子列表：
```
 9)  Ninth
10)  Tenth
11)  Eleventh
       i. subone
      ii. subtwo
     iii. subthree
```
当遇到不同形式的列表标记时，Pandoc 会重新开始一个新的列表。所以，以下的输入会产生三份列表：
```
(2) Two
(5) Three
1.  Four
*   Five
```
如果需要预设的有序列表标记符号，可以使用#.：
```
#.  one
#.  two
#.  three
```

### 定义列表
#### Extension: definition_lists

Pandoc支援定义列表，其语法的灵感来自于PHP Markdown Extra以及reStructuredText：
```
Term 1

:   Definition 1

Term 2 with *inline markup*

:   Definition 2

        { some code, part of Definition 2 }

    Third paragraph of definition 2.
```
每个专有名词(term) 都必须单独存在于一行，后面可以接着一个空白行，也可以省略，但一定
要接上一或多笔定义内容。一笔定义需由一个冒号或波浪线作开头，可以接上一或两个空白作为
缩进。定义本身的内容主体（包括接在冒号或波浪线后的第一行）应该以四个空白缩进。一个专
有名词可以有多个定义，而每个定义可以包含一或多个区块元素（段落、代码区块、列表等），
每个区块元素都要缩进四个空白或一个tab。

如果你在定义内容后面留下空白行（如同上面的范例），那么该段定义会被当作段落处理。在某
些输出格式中，这意谓著成对的专有名词与定义内容间会有较大的空白间距。在定义与定义之间，
以及定义与下个专有名词间不要留空白行，即可产生一个比较紧凑的定义列表：
```
Term 1
  ~ Definition 1
Term 2
  ~ Definition 2a
  ~ Definition 2b
```

### 编号范例列表
#### Extension: example_lists

这个特别的列表标记@可以用来产生连续编号的范例列表。列表中第一个以@标记的项目
会被编号为'1'，接着编号为'2'，依此类推，直到文件结束。范例项目的编号不会局限
于单一列表中，而是文件中所有以@为标记的项目均会次序递增其编号，直到最后一个。
举例如下：
```
(@)  My first example will be numbered (1).
(@)  My second example will be numbered (2).

Explanation of examples.

(@)  My third example will be numbered (3).
```

编号范例可以加上标签，并且在文件的其他地方作参照：
```
(@good)  This is a good example.

As (@good) illustrates, ...
```
标签可以是由任何英文字母、底线或是连字符号所组成的字串。

### 紧凑与宽松列表
在与列表相关的「边界处理」上，Pandoc与Markdown.pl有着不同的处理结果。考虑如下代码：
```
+   First
+   Second:
    -   Fee
    -   Fie
    -   Foe

+   Third
```
Pandoc会将以上列表转换为「紧凑列表」（在“First”, “Second”或“Third”之中没有\<p\>标签），
而markdown则会在“Second”与“Third” （但不包含“First”）里面置入\<p\>标签，这是因为“Third”
之前的空白行而造成的结果。Pandoc依循着一个简单规则：如果文字后面跟着空白行，那么就会被
视为段落。既然“Second”后面是跟着一个列表，而非空白行，那么就不会被视为段落了。至于子列
表的后面是不是跟着空白行，那就无关紧要了。（注意：即使是设定为markdown_strict格式，
Pandoc仍是依以上方式处理列表项目是否为段落的判定。这个处理方式与markdown官方语法规范里
的描述一致，然而却与Markdown.pl的处理不同。）

### 结束一个列表
如果你在列表之后放入一个缩排的代码区块，会有什么结果？
```
-   item one
-   item two

    { my code block }
```	
问题大了！这边pandoc（其他的markdown实作也是如此）会将{ my code block }视为item two这个
列表项目的第二个段落来处理，而不会将其视为一个代码区块。

要在item two之后「切断」列表，你可以插入一些没有缩排、输出时也不可见的内容，例如HTML的
注解：
```
-   item one
-   item two

<!-- end of list -->

    { my code block }
```	
当你想要两个各自独立的列表，而非一个大且连续的列表时，也可以运用同样的技巧：
```
1.  one
2.  two
3.  three

<!-- -->

1.  uno
2.  dos
3.  tres
```

## 分隔线
一行中若包含三个以上的*, -或_符号（中间可以以空白字元分隔），则会产生一条分隔线：
```
*  *  *  *

---------------
```
----------

