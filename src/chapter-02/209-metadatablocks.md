
## 元数据区块

### Pandoc 标题区块
（译注：本节中提到的「标题」均指 Title，而非 Headers）

::: {.info caption="Extension: pandoc_title_block"}
标题区块源码见 [@lst:pandoc_title_block]。
:::

```{#lst:pandoc_title_block .markdown caption="文件标题区块"}
% title
% author(s) (separated by semicolons)
% date
```

如果一个文件以文件标题（Title）区块开头，这部份将不会作为一般文字处理，而会以书目信息的方式解析。（这可用在像是单
一 LaTeX 或是 HTML 输出文件的书名上。）这个区块仅能包含标题，或是标题与作
者，或是标题、作者与日期。如果你只想包含作者却不想包含标题，或是只有标题
与日期而没有作者，你需要利用空白行：

```markdown
%
% Author

% My title
%
% June 15, 2006
```

标题可以包含多行文字，但接续行必须以空白字元开头，例如：

```markdown
% My title
  on multiple lines
```

如果文件有多个作者，作者也可以分列在不同行并以空白字元作开头，或是以分号间隔，或
是两者并行。所以，下列各种写法得到的结果都是相同的：

```markdown
% Author One
  Author Two

% Author One; Author Two

% Author One;
  Author Two
```

日期就只能写在一行之内。

所有这三个 Metadata 字段都可以包含标准的行内格式（斜体、链接、脚注等等）。

### 元数据区块 {#sec:yaml_metadata_block}
文件标题区块功能有限，实际使用中建议用 YAML 元数据区块 方式。

::: {.info caption="Extension: yaml_metadata_block"}
YAML 元数据区块 是一个有效的 YAML 对象，开头和结尾使用包含 3 个连字符（`---`）的单独一行来界定（结尾也可以使用 3 个点 `...`）。YAML 元数据区块 可以出现的文档的任何地方，但是如果不在文档开头，它的前面必须空一行。YAML 元数据区块 也可以单独写到一个文件里，使用 `--metadata-file` 参数传递给 Pandoc。（本项目除了 简历 功能，都使用了独立的 `metadata file`，路径为 `src/metadata.yaml`）
:::

元数据将从 YAML 对象的字段中提取，并添加到任何现有的文档元数据中。元数据可以包含列表和对象（任意嵌套），但是所有字符串标量都将被解释为 Markdown。名称以下划线结尾的字段将被 Pandoc 忽略。（它们可能被外部程序处理。）字段名不能包含能被解释为 YAML 数字或布尔值的字符串（比如，`yes`, `True`, and `15` 不能作为字段名）。

一个文档可以包含多个元数据块。元数据字段的取值将通过 `left-biased union` 确定：如果两个元数据块试图设置相同的字段，则第一个元数据块的值会生效。

注意，元数据区块必须遵循 YAML 转义规则。因此，如果一个值包含冒号，它必须被引号包裹。可以使用管道字符 (|) 开始一个缩进的块，该块将按字面解释，不需要转义。当字段包含空行或块级格式化时，需要使用这种方式：

```yaml
---
title:  'This is the title: it contains a colon'
author:
- Author One
- Author Two
keywords: [nothing, nothingness]
abstract: |
  This is the abstract.

  It consists of two paragraphs.
...
```

模板变量将从元数据中自动设置。例如，在编写 HTML 时，变量 abstract 将被设置为与 abstract 字段中的 Markdown 等价的 HTML:

```html
<p>This is the abstract.</p>
<p>It consists of two paragraphs.</p>
```

变量可以包含任意的 YAML 结构，但是模板必须匹配这个结构。默认模板中的 author 变量需要一个简单的列表或字符串，但是可以更改为支持更复杂的结构。例如，如果给定一个从属关系，下面的组合将向作者添加一个从属关系：

```yaml
---
title: The document title
author:
- name: Author One
  affiliation: University of Somewhere
- name: Author Two
  affiliation: University of Nowhere
...
```

要使用上面例子中的 author 字段，您需要一个自定义模板：

```html
$for(author)$
$if(author.name)$
$author.name$$if(author.affiliation)$ ($author.affiliation$)$endif$
$else$
$author$
$endif$
$endfor$
```

要包含在文档 header 部分中的原始内容可以使用 `header-include` 指定；但是，使用 `raw_attribute` [扩展](https://pandoc.org/MANUAL.html#extension-raw_attribute) 将该内容标记为特定输出格式的原始代码非常重要，否则它将被解释为 Markdown。例如：

~~~yaml
header-includes:
- |
  ```{=latex}
  \let\oldsection\section
  \renewcommand{\section}[1]{\clearpage\oldsection{#1}}
  ```
~~~