
## 列表
### 无序列表
无序列表是以项目符号作列举的列表。每条项目都以项目符号 ( *, +或-) 作开头。以下是个简单的例子：

```markdown
* one
* two
* three
```

这会产生一个「紧凑」列表。如果你想要一个「宽松」列表，也就是说以段落格式处理每个项目内的文字内容，那么只要在每个项目间加上空白行即可：

```markdown
* one

* two

* three
```

项目符号不必与左边缘齐平；它们可以缩进一个、两个或三个空格。项目符号后面必须有空格。

列表项目中的接续行，若与该项目的第一行文字对齐（在项目符号之后），看上去会较为美观。

```markdown
* here is my first
  list item.
* and my second.
```

但 markdown 也允许下面「偷懒」的格式：

```markdown
* here is my first
list item.
* and my second.
```

### 区块内容作为列表项
列表项可以包含多个段落和其他区块级内容。但是，后续段落必须在前面加上空行并缩进，以便与列表标记符后面的第一个非空格内容对齐。

```markdown
  * First paragraph.

    Continued.

  * Second paragraph. With a code block, which must be indented
    eight spaces:

        { code }
```

::: {.warn caption="列外情况"}
如果列表标记符后面紧跟着一个缩进的代码块，它必须在列表标记符之后开始 5 个空格，那么后续段落必须在列表标记符的最后一个字符之后开始两列：
:::

```markdown
*     code

  continuation paragraph
```

列表项可以包括其他列表。在这种情况下，前面的空白行是可选的。嵌套列表必须缩进，以便与包含列表项的列表标记符之后的第一个非空格字符对齐：

```markdown
* fruits
  + apples
    - macintosh
    - red delicious
  + pears
  + peaches
* vegetables
  + broccoli
  + chard
```	

上一节提到，Markdown 允许你以「偷懒」的方式书写，项目的接续行可以不和第一行对齐。不过，
如果一个列表项目中包含了多个段落或是其他区块元素，那么每个元素的第一行都必须缩进对齐：

```markdown
+ A lazy, lazy, list
item.

+ Another one; this looks
bad but is legal.

    Second paragraph of second
list item.
```

### 有序列表
有序列表与无序列表相类似，唯一的差别在于列表项目是以列举编号作开头，而不是项目符号。

在原始 markdown 中，列举编号是阿拉伯数字后面接着一个句点与空白。数字本身代表的数值会被忽略，因此 [@lst:orderlist_1]，[@lst:orderlist_2] 两个列表并无差别。

```{#lst:orderlist_1 .markdown caption="有序列表"}
1.  one
2.  two
3.  three
```

```{#lst:orderlist_2 .markdown caption="有序列表数字值会被忽略"}
5.  one
7.  two
1.  three
```

::: {.info caption="Extension: fancy_lists"}
与标准的 Markdown 不同，pandoc 除了阿拉伯数字外，还允许用大写字母、小写字母和罗马数字来标记有序列表项。列表标记可以用圆括号括起来，也可以用单右括号或句号括起来。它们必须与后面的文本至少分隔一个空格，如果列表标记是带句号的大写字母，则至少分隔两个空格。
:::

fancy_lists 扩展还允许用 `#` 代替数字作为有序列表标记：

```markdown
#. one
#. two
```

::: {.info caption="Extension: startnum"}
除了列表标记外，Pandoc 也能判读列表的起始编号，这两项信息都会保留于输出格式中。举例来说，以下代码可以产生一个从编号 9 开始，以单括号为编号标记的列表，底下还跟着一个小写罗马数字的子列表。
:::

```markdown
 9)  Ninth
10)  Tenth
11)  Eleventh
       i. subone
      ii. subtwo
     iii. subthree
```

当遇到不同形式的列表标记时，Pandoc 会重新开始一个新的列表。所以，以下代码会产生三份列表：

```markdown
(2) Two
(5) Three
1.  Four
*   Five
```

如果需要预设的有序列表标记符号，可以使用 `#.`：

```markdown
#.  one
#.  two
#.  three
```

::: {.info caption="Extension: task_lists"}
Pandoc 支持任务列表，使用 GitHub-Flavored Markdown 语法。
:::

```markdown
- [ ] an unchecked task list item
- [x] checked item
```

### 定义列表

定义列表的效果：

Term 1

:   Definition 1

Term 2 with *inline markup*

:   Definition 2

        { some code, part of Definition 2 }

    Third paragraph of definition 2.

::: {.info caption="Extension: definition_lists"}
Pandoc 支持定义列表，使用带扩展的 PHP Markdown Extra 语法。
:::

```markdown
Term 1

:   Definition 1

Term 2 with *inline markup*

:   Definition 2

        { some code, part of Definition 2 }

    Third paragraph of definition 2.
```

每个术语必须单独在一行中，这一行后面可以有选择地后跟空白行，并且必须后跟一个或多个定义。定义以冒号或波浪号开头，可以缩进一个或两个空格。

一个术语可以有多个定义，每个定义可以由一个或多个块元素（段落、代码块、列表等）组成，每个定义缩进四个空格或一个制表符。定义的主体（包括除冒号或波浪号外的第一行）应该缩进四个空格。但是，与其他标记列表一样，您可以“惰性地”省略缩进，除非在段落或其他块元素的开头。

```markdown
Term 1

:   Definition
with lazy continuation.

    Second paragraph of the definition.
```

如果在定义前留出空格（如以上示例所示），定义的文本将被视为段落。在某些输出格式中，这意味着术语/定义对之间的间距更大。若要获得更紧凑的定义列表，请省略定义前的空格：

```markdown
Term 1
  ~ Definition 1

Term 2
  ~ Definition 2a
  ~ Definition 2b
```

注意，定义列表中的项之间需要空格。（可以使用 compact_definition_lists 激活一个变体，它放宽了这一要求，但不允许“惰性”硬包装）。

### 编号范例列表

编号范例列表效果如下：

(@)  My first example will be numbered (1).
(@)  My second example will be numbered (2).

Explanation of examples.

(@)  My third example will be numbered (3).

::: {.info caption="Extension: example_lists"}
这个特别的列表标记 `@` 可以用来产生连续编号的范例列表。列表中第一个以 `@` 标记的项目会被编号为 '1'，接着编号为 '2'，依此类推，直到文件结束。范例项目的编号不会局限于单一列表中，而是文件中所有以@为标记的项目均会次序递增其编号，直到最后一个。
:::

```markdown
(@)  My first example will be numbered (1).
(@)  My second example will be numbered (2).

Explanation of examples.

(@)  My third example will be numbered (3).
```

编号范例可以加上标签，并且在文件的其他地方引用：

```markdown
(@good)  This is a good example.

As (@good) illustrates, ...
```

标签可以是由任何英文字母、底线或是连字符号所组成的字串。

::: {.tip}
无论列表标记的长度如何，范例列表中的延续段落都必须缩进 4 个空格。也就是说，范例列表的行为总是像设置了 four_space_rule 扩展一样。这是因为示例标签往往很长，将内容缩进到标签之后的第一个非空格字符会很麻烦
:::

### 紧凑与宽松列表
在与列表相关的「边界处理」上，Pandoc 与 Markdown.pl 有着不同的处理结果。以下代码：

```markdown
+   First
+   Second:
    -   Fee
    -   Fie
    -   Foe

+   Third
```

Pandoc 会将以上列表转换为「紧凑列表」（在“First”, “Second”或“Third”之中没有、`<p>` 标签），而 markdown 则会在“Second”与“Third” （但不包含“First”）里面置入、`<p>` 标签，这是因为“Third”之前的空白行而造成的结果。Pandoc 依循着一个简单规则：如果文字后面跟着空白行，那么就会被视为段落。既然“Second”后面是跟着一个列表，而非空白行，那么就不会被视为段落了。至于子列表的后面是不是跟着空白行，那就无关紧要了。

::: {.tip}
即使是设定为 markdown_strict 格式，Pandoc 仍是依以上方式处理列表项目是否为段落的判定。这个处理方式与 markdown 官方语法规范里的描述一致，然而却与 Markdown.pl 的处理不同。
:::

### 结束一个列表
如果你在列表之后放入一个缩排的代码区块，会有什么结果？

```markdown
-   item one
-   item two

    { my code block }
```	

问题大了！这种情况 Pandoc（其他的 Markdown 实现也是如此）会将 `{ my code block }` 视为 item two 这个列表项目的第二个段落来处理，而不会将其视为一个代码区块。

要在 item two 之后「切断」列表，你可以插入一些没有缩排、输出时也不可见的内容，例如 HTML 的注释格式：

```markdown
-   item one
-   item two

<!-- end of list -->

    { my code block }
```	

当你想要两个各自独立的列表，而非一个大且连续的列表时，也可以运用同样的技巧。