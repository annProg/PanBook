
## 列表
### 无序列表
无序列表是以项目符号作列举的列表。每条项目都以项目符号 ( *, +或-) 作开头。
下面是个简单的例子：
```markdown
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
```markdown
* one

* two

* three
```
项目符号不能直接从行首最左边处输入，而必须以一至三个空白字元作缩进。项目符号
后必须跟着一个空白字元。

列表项目中的接续行，若与该项目的第一行文字对齐（在项目符号之后），看上去会较
为美观：
```markdown
* here is my first
  list item.
* and my second.
```
但 markdown 也允许以下「偷懒」的格式：
```markdown
* here is my first
list item.
* and my second.
```
#### 四个空白规则
一个列表项目可以包含多个段落以及其他区块等级的内容。然而，后续的段落必须接在空
白行之后，并且以四个空白或一个 tab 作缩进。因此，如果项目里第一个段落与后面段落
对齐的话（也就是项目符号前置入两个空白），看上去会比较整齐美观：
```markdown
  * First paragraph.

    Continued.

  * Second paragraph. With a code block, which must be indented
    eight spaces:

        { code }
```
列表项目也可以包含其他列表。在这情况下前置的空白行是可有可无的。嵌套列表必须以四
个空白或一个 tab 作缩进：
```markdown
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
```markdown
+ A lazy, lazy, list
item.

+ Another one; this looks
bad but is legal.

    Second paragraph of second
list item.
```
**注意：**尽管针对接续段落的「四个空白规则」是出自于官方的 markdown syntax guide，但是作
为对应参考用的 Markdown.pl 实作版本中并未遵循此一规则。所以当输入时若接续段落的缩进少于四
个空白时，pandoc 所输出的结果会与 Markdown.pl 的输出有所出入。

在 markdown syntax guide 中并未明确表示「四个空白规则」是否一体适用于所有位于列表项目里的
区块元素上；规范文件中只提及了段落与代码区块。但文件暗示了此规则适用于所有区块等级的内容
（包含嵌套列表），并且 pandoc 以此方向进行解读与实作。

### 有序列表
有序列表与无序列表相类似，唯一的差别在于列表项目是以列举编号作开头，而不是项目符号。

在原始 markdown 中，列举编号是阿拉伯数字后面接着一个句点与空白。数字本身代表的数值会被忽
略，因此下面两个列表并无差别：

```markdown
1.  one
2.  two
3.  three
```
上下两个列表的输出是相同的。
```markdown
5.  one
7.  two
1.  three
```

#### Extension: fancy_lists

与原始 markdown 不同的是，Pandoc 除了使用阿拉伯数字作为有序列表的编号外，也可以使用大写或
小写的英文字母，以及罗马数字。列表标记可以用括号包住，也可以单独一个右括号，抑或是句号。
如果列表标记是大写字母接着一个句号，句号后请使用至少两个空白字元。

#### Extension: startnum

除了列表标记外，Pandoc 也能判读列表的起始编号，这两项资讯都会保留于输出格式中。举例来说，
下面的输入可以产生一个从编号 9 开始，以单括号为编号标记的列表，底下还跟着一个小写罗马数字
的子列表：
```markdown
 9)  Ninth
10)  Tenth
11)  Eleventh
       i. subone
      ii. subtwo
     iii. subthree
```
当遇到不同形式的列表标记时，Pandoc 会重新开始一个新的列表。所以，以下的输入会产生三份列表：
```markdown
(2) Two
(5) Three
1.  Four
*   Five
```
如果需要预设的有序列表标记符号，可以使用#.：
```markdown
#.  one
#.  two
#.  three
```

### 定义列表
#### Extension: definition_lists

Pandoc 支援定义列表，其语法的灵感来自于 PHP Markdown Extra 以及 reStructuredText：
```markdown
Term 1

:   Definition 1

Term 2 with *inline markup*

:   Definition 2

        { some code, part of Definition 2 }

    Third paragraph of definition 2.
```
每个专有名词 (term) 都必须单独存在于一行，后面可以接着一个空白行，也可以省略，但一定
要接上一或多笔定义内容。一笔定义需由一个冒号或波浪线作开头，可以接上一或两个空白作为
缩进。定义本身的内容主体（包括接在冒号或波浪线后的第一行）应该以四个空白缩进。一个专
有名词可以有多个定义，而每个定义可以包含一或多个区块元素（段落、代码区块、列表等），
每个区块元素都要缩进四个空白或一个 tab。

如果你在定义内容后面留下空白行（如同上面的范例），那么该段定义会被当作段落处理。在某
些输出格式中，这意谓著成对的专有名词与定义内容间会有较大的空白间距。在定义与定义之间，
以及定义与下个专有名词间不要留空白行，即可产生一个比较紧凑的定义列表：
```markdown
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
```markdown
(@)  My first example will be numbered (1).
(@)  My second example will be numbered (2).

Explanation of examples.

(@)  My third example will be numbered (3).
```

编号范例可以加上标签，并且在文件的其他地方作参照：
```markdown
(@good)  This is a good example.

As (@good) illustrates, ...
```
标签可以是由任何英文字母、底线或是连字符号所组成的字串。

### 紧凑与宽松列表
在与列表相关的「边界处理」上，Pandoc 与 Markdown.pl 有着不同的处理结果。考虑如下代码：
```markdown
+   First
+   Second:
    -   Fee
    -   Fie
    -   Foe

+   Third
```
Pandoc 会将以上列表转换为「紧凑列表」（在“First”, “Second”或“Third”之中没有、<p\>标签），
而 markdown 则会在“Second”与“Third” （但不包含“First”）里面置入、<p\>标签，这是因为“Third”
之前的空白行而造成的结果。Pandoc 依循着一个简单规则：如果文字后面跟着空白行，那么就会被
视为段落。既然“Second”后面是跟着一个列表，而非空白行，那么就不会被视为段落了。至于子列
表的后面是不是跟着空白行，那就无关紧要了。（注意：即使是设定为 markdown_strict 格式，
Pandoc 仍是依以上方式处理列表项目是否为段落的判定。这个处理方式与 markdown 官方语法规范里
的描述一致，然而却与 Markdown.pl 的处理不同。）

### 结束一个列表
如果你在列表之后放入一个缩排的代码区块，会有什么结果？
```markdown
-   item one
-   item two

    { my code block }
```	
问题大了！这边 pandoc（其他的 markdown 实作也是如此）会将{ my code block }视为 item two 这个
列表项目的第二个段落来处理，而不会将其视为一个代码区块。

要在 item two 之后「切断」列表，你可以插入一些没有缩排、输出时也不可见的内容，例如 HTML 的
注解：
```markdown
-   item one
-   item two

<!-- end of list -->

    { my code block }
```	
当你想要两个各自独立的列表，而非一个大且连续的列表时，也可以运用同样的技巧：
```markdown
1.  one
2.  two
3.  three

<!-- -->

1.  uno
2.  dos
3.  tres
```