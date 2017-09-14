
## 表格
有四种表格的形式可以使用。前三种适用于等宽字型的编辑环境，例如Courier。第四种则
不需要直行的对齐，因此可以在比例字型的环境下使用。

### 简单表格
#### Extension: simple_tables,table_captions

简单表格看起来像这样子：

  Right     Left     Center     Default
-------     ------ ----------   -------
     12     12        12            12
    123     123       123          123
      1     1          1             1

Table:  Demonstration of simple table syntax.

代码为：
```
  Right     Left     Center     Default
-------     ------ ----------   -------
     12     12        12            12
    123     123       123          123
      1     1          1             1

Table:  Demonstration of simple table syntax.
```

表头与资料列分别以一行为单位。直行的对齐则依照表头的文字和其底下虚线的相对位置来决定：

- 如果虚线与表头文字的右侧有切齐，而左侧比表头文字还长，则该直行为靠右对齐。
- 如果虚线与表头文字的左侧有切齐，而右侧比表头文字还长，则该直行为靠左对齐。
- 如果虚线的两侧都比表头文字长，则该直行为置中对齐。
- 如果虚线与表头文字的两侧都有切齐，则会套用预设的对齐方式（在大多数情况下，这将会是靠左对齐）。
- 表格底下必须接着一个空白行，或是一行虚线后再一个空白行。表格标题为可选的（上面的范例中有出现）。标题需是一个以Table:（或单纯只有:）开头作为前缀的段落，输出时前缀的这部份会被去除掉。表格标题可以放在表格之前或之后。

表头也可以省略，在省略表头的情况下，表格下方必须加上一行虚线以清楚标明表格的范围。例如：

-------     ------ ----------   -------
     12     12        12             12
    123     123       123           123
      1     1          1              1
-------     ------ ----------   -------

代码：
```
-------     ------ ----------   -------
     12     12        12             12
    123     123       123           123
      1     1          1              1
-------     ------ ----------   -------
```

当省略表头时，直行的对齐会以表格内容的第一行资料列决定。所以，以上面的表格为例，
各直行的对齐依序会是靠右、靠左、置中以及靠右对齐。

### 多行表格
#### Extension: multiline_tables,table_captions

多行表格允许表头与表格资料格的文字能以多行呈现（但不支援横跨多栏或纵跨多列的
资料格）。以下为范例：

-------------------------------------------------------------
 Centered   Default           Right Left
  Header    Aligned         Aligned Aligned
----------- ------- --------------- -------------------------
   First    row                12.0 Example of a row that
                                    spans multiple lines.

  Second    row                 5.0 Here's another one. Note
                                    the blank line between
                                    rows.
-------------------------------------------------------------

Table: Here's the caption. It, too, may span
multiple lines.

代码：
```
-------------------------------------------------------------
 Centered   Default           Right Left
  Header    Aligned         Aligned Aligned
----------- ------- --------------- -------------------------
   First    row                12.0 Example of a row that
                                    spans multiple lines.

  Second    row                 5.0 Here's another one. Note
                                    the blank line between
                                    rows.
-------------------------------------------------------------

Table: Here's the caption. It, too, may span
multiple lines.
```


看起来很像简单表格，但两者间有以下差别：

- 在表头文字之前，必须以一列虚线作为开头（除非有省略表头）。
- 必须以一列虚线作为表格结尾，之后接一个空白行。
- 资料列与资料列之间以空白行隔开。
- 在多行表格中，表格分析器会计算各直行的栏宽，并在输出时尽可能维持各直行在原始文件中的相对比例。因此，要是你觉得某些栏位在输出时不够宽，你可以在markdown 的原始档中加宽一点。

和简单表格一样，表头在多行表格中也是可以省略的：

----------- ------- --------------- -------------------------
   First    row                12.0 Example of a row that
                                    spans multiple lines.

  Second    row                 5.0 Here's another one. Note
                                    the blank line between
                                    rows.
----------- ------- --------------- -------------------------

: Here's a multiline table without headers.

代码：
```
----------- ------- --------------- -------------------------
   First    row                12.0 Example of a row that
                                    spans multiple lines.

  Second    row                 5.0 Here's another one. Note
                                    the blank line between
                                    rows.
----------- ------- --------------- -------------------------

: Here's a multiline table without headers.
```

多行表格中可以单只包含一个资料列，但该资料列之后必须接着一个空白行（然后才是标
示表格结尾的一行虚线）。如果没有此空白行，此表格将会被解读成简单表格。

### 格框表格
#### Extension: grid_tables,table_captions

格框表格看起来像这样：

: Sample grid table.

+---------------+---------------+--------------------+
| Fruit         | Price         | Advantages         |
+===============+===============+====================+
| Bananas       | $1.34         | - built-in wrapper |
|               |               | - bright color     |
+---------------+---------------+--------------------+
| Oranges       | $2.10         | - cures scurvy     |
|               |               | - tasty            |
+---------------+---------------+--------------------+

代码：
```
: Sample grid table.

+---------------+---------------+--------------------+
| Fruit         | Price         | Advantages         |
+===============+===============+====================+
| Bananas       | $1.34         | - built-in wrapper |
|               |               | - bright color     |
+---------------+---------------+--------------------+
| Oranges       | $2.10         | - cures scurvy     |
|               |               | - tasty            |
+---------------+---------------+--------------------+
```

以=串成的一行区分了表头与表格本体，这在没有表头的表格中也是可以省略的。在格框表格中
的资料格可以包含任意的区块元素（复数段落、代码区块、清单等等）。不支援对齐，也不支
援横跨多栏或纵跨多列的资料格。格框表格可以在Emacs table mode下轻松建立。

### 管线表格
#### Extension: pipe_tables,table_captions

管线表格看起来像这样：

| Right | Left | Default | Center |
|------:|:-----|---------|:------:|
|   12  |  12  |    12   |    12  |
|  123  |  123 |   123   |   123  |
|    1  |    1 |     1   |     1  |

  : Demonstration of simple table syntax.
  
代码：
```
| Right | Left | Default | Center |
|------:|:-----|---------|:------:|
|   12  |  12  |    12   |    12  |
|  123  |  123 |   123   |   123  |
|    1  |    1 |     1   |     1  |

  : Demonstration of simple table syntax.
```

这个语法与PHP markdown extra中的表格语法相同。开始与结尾的管线字元是可选的，但各直行间
则必须以管线区隔。上面范例中的冒号表明了对齐方式。表头可以省略，但表头下的水平虚线必须
保留，因为虚线上定义了资料栏的对齐方式。

因为管线界定了各栏之间的边界，表格的原始码并不需要像上面例子中各栏之间保持直行对齐。所
以，底下一样是个完全合法（虽然丑陋）的管线表格：

```
fruit| price
-----|-----:
apple|2.05
pear|1.37
orange|3.09
```
管线表格的资料格不能包含如段落、清单之类的区块元素，也不能包含多行文字。

注意：Pandoc 也可以看得懂以下形式的管线表格，这是由Emacs 的orgtbl-mod 所绘制：
```
| One | Two   |
|-----+-------|
| my  | table |
| is  | nice  |
```

效果：

| One | Two   |
|-----+-------|
| my  | table |
| is  | nice  |

主要的差别在于以+取代了部分的|。其他的orgtbl功能并未支援。如果要指定非预设的直
行对齐形式，你仍然需要在上面的表格中自行加入冒号。

## 文件标题区块

（译注：本节中提到的「标题」均指Title，而非Headers）

#### Extension: pandoc_title_block

如果档案以文件标题（Title）区块开头
```
% title
% author(s) (separated by semicolons)
% date
```
这部份将不会作为一般文字处理，而会以书目资讯的方式解析。（这可用在像是单
一LaTeX 或是HTML 输出文件的书名上。）这个区块仅能包含标题，或是标题与作
者，或是标题、作者与日期。如果你只想包含作者却不想包含标题，或是只有标题
与日期而没有作者，你得利用空白行：
```
%
% Author

% My title
%
% June 15, 2006
```
标题可以包含多行文字，但接续行必须以空白字元开头，像是：

```
% My title
  on multiple lines
```

如果文件有多个作者，作者也可以分列在不同行并以空白字元作开头，或是以分号间隔，或
是两者并行。所以，下列各种写法得到的结果都是相同的：

```
% Author One
  Author Two

% Author One; Author Two

% Author One;
  Author Two
```

日期就只能写在一行之内。

所有这三个metadata 栏位都可以包含标准的行内格式（斜体、连结、脚注等等）。

文件标题区块一定会被分析处理，但只有在`--standaline( -s)`选项被设定时才会影响输出内
容。在输出HTML时，文件标题会出现的地方有两个：一个是在文件的`<head>`区块里---这会
显示在浏览器的视窗标题上---另外一个是文件的`<body>`区块最前面。位于`<head>`里的文件
标题可以选择性地加上前缀文字（透过`--title-prefix`或`-T`选项）。而在`<body>`里的文件标
题会以H1元素呈现，并附带“title”类别(class)，这样就能藉由CSS来隐藏显示或重新定义格
式。如果以-T选项指定了标题前缀文字，却没有设定文件标题区块里的标题，那么前缀文字本
身就会被当作是HTML的文件标题。

而man page的输出器会分析文件标题区块的标题行，以解出标题、man page section number，
以及其他页眉(header)页脚(footer)所需要的资讯。一般会假设标题行的第一个单字为标题，
标题后也许会紧接着一个以括号包住的单一数字，代表section number（标题与括号之间没
有空白）。在此之后的其他文字则为页脚与页眉文字。页脚与页眉文字之间是以单独的一个
管线符号( |)作为区隔。所以，

```
% PANDOC(1)
```
将会产生一份标题为PANDOC且section为1的man page。

```
% PANDOC(1) Pandoc User Manuals
```
产生的man page 会再加上“Pandoc User Manuals” 在页脚处。

```
% PANDOC(1) Pandoc User Manuals | Version 4.0
```
产生的man page 会再加上“Version 4.0” 在页眉处。


## 字符转义

#### Extension: all_symbols_escapable

除了在代码区块或行内代码之外，任何标点符号或空白字元前面只要加上一个
反斜线，都能使其保留字面原义，而不会进行格式的转义解读。因此，举例来
说，下面的写法

```
*\*hello\**
```
输出后会得到

```
<em>*hello*</em>
```
而不是

```
<strong>hello</strong>
```
这条规则比原始的markdown 规则来得好记许多，原始规则中，只有以下字元才支持
反斜线跳脱，不作进一步转义：
```
\`*_{}[]()>#+-.!
```
（然而，如果使用了markdown_strict格式，那么就会采用原始的markdown规则）

一个反斜线之后的空白字元会被解释为不断行的空白(nonbreaking space)。这在TeX的
输出中会显示为`~`，而在HTML与XML则是显示为`\&#160;`或`\&nbsp;`。

一个反斜线之后的换行字元（例如反斜线符号出现在一行的最尾端）则会被解释为强制
换行。这在TeX的输出中会显示为`\\`，而在HTML里则是`<br />`。相对于原始markdown是以
在行尾加上两个空白字元这种「看不见」的方式进行强制换行，反斜线接换行字元会是比较好
的替代方案。

转义字符在代码上下文中不起任何作用。

## 智能标点

如果指定了`--smart`选项，pandoc将会输出正式印刷用的标点符号，像是将`straight quotes`转
换为`curly quotes` [^4]、`---`转为破折号(em-dashes)，`--`转为连接号(en-dashes)，以及将
`...`转为省略号。不断行空格(Nonbreaking spaces)将会插入某些缩写词之后，例如“Mr.”。

注意：如果你的LaTeX template使用了csquotes套件，pandoc会自动侦测并且使用`\enquote{...}`
在引言文字上。

[^4]: 译注：straight quotes指的是左右两侧都长得一样的引号，例如我们直接在键盘上打出来的
单引号或双引号；curly quotes则是左右两侧不同，有从两侧向内包夹视觉效果的引号。


## 行内格式

###强调
要强调某些文字，只要以`*`或`_`符号前后包住即可，像这样：
```
This text is _emphasized with underscores_, and this
is *emphasized with asterisks*.
```
重复两个`*`或`_`符号以产生更强烈的强调：
```
This is **strong emphasis** and __with underscores__.
```
This is **strong emphasis** and __with underscores__.

一个前后以空白字元包住，或是前面加上反斜线的`*`或`_`符号，都不会转换为强调格式：
```
This is * not emphasized *, and \*neither is this\*.
```

#### Extension: intraword_underscores

因为_字元有时会使用在单字或是ID之中，所以pandoc不会把被字母包住的_解读为强调标记。
如果有需要特别强调单字中的一部分，就用*：

```
feas*ible*, not feas*able*.
```

### 删除线
#### Extension: strikeout

要将一段文字加上水平线作为删除效果，将该段文字前后以`~~`包住即可。例如，
```
This ~~is deleted text.~~
```

### 上标与下标
#### Extension: superscript,subscript

要输入上标可以用`^`字元将要上标的文字包起来；要输入下标可以用`~`字元将要下标的
文字包起来。直接看范例，
```
H~2~O is a liquid.  2^10^ is 1024.
```
H~2~O is a liquid.  2^10^ is 1024.

如果要上标或下标的文字中包含了空白，那么这个空白字元之前必须加上反斜线。（这是为
了避免一般使用下的`~`和`^`在非预期的情况下产生出意外的上标或下标。）所以，如果你想要
让字母P后面跟着下标文字'a cat'，那么就要输入`P~a\ cat~`，而不是`P~a cat~`。

### 字面文字
要让一小段文字直接以其字面形式呈现，可以用反引号将其包住：

```
What is the difference between `>>=` and `>>`?
```
如果字面文字中也包含了反引号，那就使用双重反引号包住：

```
Here is a literal backtick `` ` ``.
````

（在起始反引号后的空白以及结束反引号前的空白都会被忽略。）

一般性的规则如下，字面文字区段是以连续的反引号字元作为开始（反引号后的空白字元为可选），
一直到同样数目的反引号字元出现才结束（反引号前的空白字元也为可选）。

要注意的是，转义字符（以及其他markdown 结构）在字面文字的上下文中是没有效果的：
```
This is a backslash followed by an asterisk: `\*`.
```

#### Extension: inline_code_attributes

与围栏代码区块一样，字面文字也可以附加属性：
```
`<$>`{.haskell}
```
