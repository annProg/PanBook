
## 表格
有四种表格的形式可以使用。前三种适用于等宽字型的编辑环境，例如Courier。第四种则
不需要直行的对齐，因此可以在比例字型的环境下使用。

### 简单表格
#### Extension: simple_tables,table_captions

简单表格看起来如表\ref{table:simpletable}所示：

  Right     Left     Center     Default
-------     ------ ----------   -------
     12     12        12            12
    123     123       123          123
      1     1          1             1

Table:  Demonstration of simple table syntax.\label{table:simpletable}

代码为：
```markdown
简单表格看起来如表\ref{table:simpletable}所示：

  Right     Left     Center     Default
-------     ------ ----------   -------
     12     12        12            12
    123     123       123          123
      1     1          1             1

Table:  Demonstration of simple table syntax.\label{table:simpletable}
```

可以用`\label`为表格添加label，然后在其他地方用`\ref`引用。

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
```markdown
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
```markdown
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
```markdown
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
```markdown
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
```markdown
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

```markdown
fruit| price
-----|-----:
apple|2.05
pear|1.37
orange|3.09
```
管线表格的资料格不能包含如段落、清单之类的区块元素，也不能包含多行文字。

注意：Pandoc 也可以看得懂以下形式的管线表格，这是由Emacs 的orgtbl-mod 所绘制：
```markdown
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