
## 表格
有四种表格的形式可以使用。前三种适用于等宽字型的编辑环境，例如 Courier。第四种则
不需要直行的对齐，因此可以在比例字型的环境下使用。

### 简单表格

::: {.info caption="Extension: table_captions"}
4 种表格都支持添加可选的标题。标题是以 `Table:`字符串（或简写为 `:`）开头的段落，可以出现在表格开头或者结尾。
:::

::: {.info caption="Extension: simple_tables"}
简单表格如 [@tbl:simple_table] 所示，源码见 [@lst:simple_table]。
:::

  Right     Left     Center     Default
-------     ------ ----------   -------
     12     12        12            12
    123     123       123          123
      1     1          1             1

Table:  简单表格演示 {#tbl:simple_table}

```{#lst:simple_table .markdown caption="简单表格源码"}
  Right     Left     Center     Default
-------     ------ ----------   -------
     12     12        12            12
    123     123       123          123
      1     1          1             1

Table:  简单表格演示 {#tbl:simple_table}
```

表头和行必须是一行，不能换行。列对齐方式根据表头文字和其底下虚线的相对位置来决定：

- 如果虚线与表头文字的右侧对齐，而左侧比表头文字长，则该列右对齐。
- 如果虚线与表头文字的左侧对齐，而右侧比表头文字长，则该列左对齐。
- 如果虚线的两侧都比表头文字长，则该列居中对齐。
- 如果虚线与表头文字的两侧都对齐，则会套用预设的对齐方式（在大多数情况下，这将会是左对齐）。
- 表格底下必须接着一个空白行，或是一行虚线后再一个空白行。

表头也可以省略，在省略表头的情况下，表格下方必须加上一行虚线以清楚标明表格的范围。例如 [@lst:omitted_header] 显示为：

-------     ------ ----------   -------
     12     12        12             12
    123     123       123           123
      1     1          1              1
-------     ------ ----------   -------

```{#lst:omitted_header .markdown caption="省略表头的表格"}
-------     ------ ----------   -------
     12     12        12             12
    123     123       123           123
      1     1          1              1
-------     ------ ----------   -------
```

当省略表头时，对齐根据表格内容的第一行决定。所以，以上面的表格为例，
各列的对齐依序会是右对齐、左对齐、居中以及右对齐。

### 多行表格

::: {.info caption="Extension: multiline_tables"}
多行表格允许表头与行的文字以多行呈现（但不支持横跨多栏或纵跨多列的
单元格）。范例如 [@tbl:multiline_tables]，源码见 [@lst:multiline_tables]。
:::

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

Table: 这里是标题  
标题也可以是多行 {#tbl:multiline_tables}

```{#lst:multiline_tables .markdown caption="多行表格示例"}
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

Table: 这里是标题  
标题也可以是多行 {#tbl:multiline_tables}
```

看起来很像简单表格，但两者间有以下差别：

- 在表头文字之前，必须以一列虚线作为开头（除非有省略表头）。
- 必须以一列虚线作为表格结尾，之后接一个空白行。
- 行之间以空白行隔开。

::: {.warn caption="多行标题"}
注意，多行标题第一行末尾需用 2 个空格强制换行。
:::

在多行表格中，表格分析器会计算各列的宽度，并在输出时尽可能维持各列在原始文件中的相对比例。因此，要是你觉得某列在输出时不够宽，你可以在 markdown 源码种加宽一点。

和简单表格一样，表头在多行表格中也是可以省略的：

----------- ------- --------------- -------------------------
   First    row                12.0 Example of a row that
                                    spans multiple lines.

  Second    row                 5.0 Here's another one. Note
                                    the blank line between
                                    rows.
----------- ------- --------------- -------------------------

: 无表头的多行表格 {#tbl:multiline_omitted_header}

多行表格可以只包含一行，但该行之后必须接着一个空白行（然后才是表
示表格结尾的一行虚线）。如果没有此空白行，此表格将会被解读成简单表格。

### 格框表格

::: {.info caption="Extension: grid_tables"}
格框表格看起来像 [@tbl:grid_tables]，源码见 [@lst:grid_tables]。
:::

: 格框表格示例 {#tbl:grid_tables}

+---------------+---------------+--------------------+
| Fruit         | Price         | Advantages         |
+===============+===============+====================+
| Bananas       | $1.34         | - built-in wrapper |
|               |               | - bright color     |
+---------------+---------------+--------------------+
| Oranges       | $2.10         | - cures scurvy     |
|               |               | - tasty            |
+---------------+---------------+--------------------+

```{#lst:grid_tables .markdown caption="格框表格示例"}
: 格框表格示例 {#tbl:grid_tables}

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

以 `=` 串成的一行区分了表头与表格本体，这在没有表头的表格中也是可以省略的。在格框表格中
的单元格可以包含任意的区块元素（多个段落、代码块、列表等等）。单元格不支
持横跨多栏或纵跨多列。格框表格可以在 Emacs table mode 下轻松建立。

通过在表头与表格分界行种添加冒号来指定对齐方式（源码 [@lst:grid_tables_align]）：

+---------------+---------------+--------------------+
| Right         | Left          | Centered           |
+==============:+:==============+:==================:+
| Bananas       | $1.34         | built-in wrapper   |
+---------------+---------------+--------------------+

```{#lst:grid_tables_align .markdown caption="格框表格对齐语法"}
+---------------+---------------+--------------------+
| Right         | Left          | Centered           |
+==============:+:==============+:==================:+
| Bananas       | $1.34         | built-in wrapper   |
+---------------+---------------+--------------------+
```

对于没有表头的表格，冒号放在第一行：

```markdown
+--------------:+:--------------+:------------------:+
| Right         | Left          | Centered           |
+---------------+---------------+--------------------+
```

::: {.warn caption="格框表格的局限性"}
Pandoc 不支持合并行或列的表格，必须有相同数量的行和列。例如，Docutils 的 [示例表格](http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#grid-tables) 在 Pandoc 种不会像预期那样渲染。
:::

### 管线表格

::: {.info caption="Extension: pipe_tables"}
管线表格看起来像 [@tbl:pipe_tables]，源码见 [@lst:pipe_tables]。
:::

| Right | Left | Default | Center |
|------:|:-----|---------|:------:|
|   12  |  12  |    12   |    12  |
|  123  |  123 |   123   |   123  |
|    1  |    1 |     1   |     1  |

  : 管线表格示例 {#tbl:pipe_tables}
  

```{#lst:pipe_tables .markdown caption="管线表格示例"}
| Right | Left | Default | Center |
|------:|:-----|---------|:------:|
|   12  |  12  |    12   |    12  |
|  123  |  123 |   123   |   123  |
|    1  |    1 |     1   |     1  |

  : 管线表格示例 {#tbl:pipe_tables}
```

这个语法与 [PHP Markdown Extra tables](https://michelf.ca/projects/php-markdown/extra/#table) 中的表格语法相同。每行开头与结尾的管线字符是可选的，但各列间的管线不可省略。上面范例中的冒号表明了对齐方式。表头可以省略，但表头下的水平虚线必须
保留，因为虚线上定义了列对齐方式。

因为管线界定了各栏之间的边界，表格的原始码并不需要像上面例子中各栏之间保持直行对齐。所
以，以下例子是个完全合法（虽然丑陋）的管线表格：

```markdown
fruit| price
-----|-----:
apple|2.05
pear|1.37
orange|3.09
```

管线表格的单元格不能包含如段落、列表之类的区块元素，也不能包含多行文字。
如果管线表格包含了比 column 定义的宽度（参见 [--columns](https://pandoc.org/MANUAL.html#option--columns)）还要宽的行，表格宽度将会被设置为文本宽度，并且单元格会自动换行，并且各列的相对宽度由表头的连接线数量决定。（比如，`---|-` 将会生成第一列占文本宽度 `3/4`，第二列占文本宽度 `1/4` 的表格） 另一方面，如果没有比列宽更宽的行，那么单元格内容将不会被换行，并且单元格将根据其内容大小进行调整。自动换行效果见 [@tbl:table_wrap]。

fruit| price
-----|-----:
apple apple apple apple apple apple apple apple apple apple apple apple apple apple apple apple apple apple apple |2.05
pear|1.37
orange|3.09

: 自动换行示例 {#tbl:table_wrap}

::: {.info caption="orgtbl-mod"}
Pandoc 也可以看得懂以下形式的管线表格，这是由 Emacs 的 orgtbl-mod 所绘制：

```markdown
| One | Two   |
|-----+-------|
| my  | table |
| is  | nice  |
```

主要的差别在于以 `+` 取代了 `|`。其他的 orgtbl 功能并未支援。如果要指定非预设的列对齐形式，你仍然需要在上面的表格中自行加入冒号。
:::
