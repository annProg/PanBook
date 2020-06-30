
## 参考文献 {#sec:citations}

::: {.warn}
参考文献请作为正文处理，勿放在 `backmatter.md` 中，因为 `backmatter.md` 是单独编译成 \LaTeX 的，pandoc-citeproc 不能读取到正文中的引用。
:::

::: {.info caption="Extension: citations"}
使用外部 `filter`（pandoc-citeproc），Pandoc 可以自动生成多种风格的引用和文献目录。基本用法是

```bash
$ pandoc --filter pandoc-citeproc myinput.txt
```
:::

为了使用这个功能，您需要通过 YAML 元数据区块中的 bibliography 字段或 `--bibliography` 命令行参数指定参考文献文件。如果希望使用多个参考文献文件，可以在 YAML 元数据区块中设置多个 `bibliography` 字段，或者多次设置 `--bibliography` 参数。参考文献可采用 [@tbl:citation_format] 中任何一种格式。

Format | File extension
:-----|:------
BibLaTeX	| .bib
BibTeX	  | .bibtex
Copac	    | .copac
CSL JSON	| .json
CSL YAML	| .yaml
EndNote	  | .enl
EndNote XML	| .xml
ISI	      | .wos
MEDLINE	  | .medline
MODS	    | .mods
RIS	      | .ris

Table: Pandoc 支持的引用形式 {#tbl:citation_format}

需注意 `.bib` 扩展名同时适用于 BibTeX 与 BibLaTeX，使用`.bibtex` 来强制指定 BibTeX。

注意，`pandoc-citeproc --bib2json` 和 `pandoc-citeproc --bib2yaml` 可以从任何受支持的格式生成 `.json` 和 `.yaml` 文件。

::: {.info caption="标记方式说明"}
在 BibTeX 和 BibLaTeX 数据库中，pandoc-citeproc 解析 \LaTeX 标记的子集；在 CSL YAML 数据库中，pandoc 解析 Markdown; 在 CSL JSON 数据库中，解析类似 HTML 的标记：

```html
<i>...</i>
italics
<b>...</b>
bold
<span style="font-variant:small-caps;">...</span> or <sc>...</sc>
small capitals
<sub>...</sub>
subscript
<sup>...</sup>
superscript
<span class="nocase">...</span>
prevent a phrase from being capitalized as title case
```

pandoc-citeproc 的 `-j` 和 `-y` 选项尽可能相互转换 CSL JSON 和 CSL YAML 格式。
:::

作为使用 `--bibliography` 或 YAML 元数据中 `bibliography` 字段指定参考文献文件的替代方法，您可以将引文数据直接包含在文档的 YAML 元数据的 `references` 字段中。字段应该包含一个 YAML 编码的引用数组，例如：

```yaml
---
references:
- type: article-journal
  id: WatsonCrick1953
  author:
  - family: Watson
    given: J. D.
  - family: Crick
    given: F. H. C.
  issued:
    date-parts:
    - - 1953
      - 4
      - 25
  title: 'Molecular structure of nucleic acids: a structure for deoxyribose
    nucleic acid'
  title-short: Molecular structure of nucleic acids
  container-title: Nature
  volume: 171
  issue: 4356
  page: 737-738
  DOI: 10.1038/171737a0
  URL: http://www.nature.com/nature/journal/v171/n4356/abs/171737a0.html
  language: en-GB
...
```

（`pandoc-citeproc --bib2yaml` 可以从支持的格式之一的参考文献文件中生成 `references` 字段格式。）

可以使用 [Zotero 样式库](https://www.zotero.org/styles) 中列出的 [引文样式语言](http://citationstyles.org/) 支持的任何样式对引文和引用进行格式化。这些文件是使用 `--csl` 选项或 `csl` 元数据字段指定的。默认情况下，pandoc-citeproc 将使用样式为 author-date 格式的 [Chicago Manual of Style](http://chicagomanualofstyle.org/)。CSL 项目提供了关于 [查找和编辑样式](https://citationstyles.org/authors/) 的进一步信息。

要使引用超链接到相应的参考文献条目，请在 YAML 元数据区块中设置 `link-citations: true`。

文献引用放在方括号中，以分号隔开。每一条引用都需要有一个 key，由 `@` 加上文献目录数据库中的文献 ID 组成，并且可以选择性地包含前缀、定位以及后缀。引用键必须以字母、数字或 `_` 开头，并且可以包含字母数字、`_` 和内部标点符号（`:.#$%&-+?<>~/`）。以下是一些范例：

```markdown
Blah blah [see @doe99, pp. 33-35; also @smith04, ch. 1].

Blah blah [@doe99, pp. 33-35, 38-39 and *passim*].

Blah blah [@smith04; @doe99].
```

pandoc-citeproc 检测 [CSL 语言环境文件](https://github.com/citation-style-language/locales) 中的定位项。缩写形式和非缩写形式都可以。在 `en-US` 语言环境中，定位器术语可以用单数或复数形式编写，比如 `book, bk./bks.; chapter, chap./chaps.; column, col./cols.; figure, fig./figs.; folio, fol./fols.; number, no./nos.; line, l./ll.; note, n./nn.; opus, op./opp.; page, p./pp.; paragraph, para./paras.; part, pt./pts.; section, sec./secs.; sub verbo, s.v./s.vv.; verse, v./vv.; volume, vol./vols.; ¶/¶¶; §/§§.` 如果没有使用定位器术语，则默认为 `page`。

pandoc-citeproc 将使用启发式来区分定位符和后缀。在复杂的情况下，定位器可以用大括号括起来（需要 pandoc-citeproc 0.15 或更高版本）:

```markdown
[@smith{ii, A, D-Z}, with a suffix]
[@smith, {pp. iv, vi-xi, (xv)-(xvii)} with suffix here]
```

在 `@` 前面的减号（`-`）将会避免作者名字在引用中出现。这可以用在已经提及作者的文章场合中：

```markdown
Smith says blah [-@smith04].
```

你也可以在文字中直接插入文献引用，方式如下：

```markdown
@smith04 says blah.

@smith04 [p. 33] says blah.
```

如果样式需要引用的文献列表，文献列表将被放置在一个带有 ID 为 `refs` 的 div 中，如果存在此 div：

```markdown
::: {#refs}
:::
```

否则，文献列表将被放置在文档结尾。可以通过在 YAML 元数据中设置 `suppress-bibliography: true` 来抑制文献列表的生成。

如果你希望文献列表有一个标题，你可以在元数据中设置 `reference-section-title`，或者在文档的末尾加上：

```markdown
last paragraph...

# References
```

另一种方式，可以使用`fenced_divs`语法，参考文献将显示在带 `{#refs}` 属性的`div`中第一个大标题下：

```markdown
::: {#refs}
# 我的参考文献
:::
```

文献列表将插入本标题之后。注意，`.unnumbered` 样式将被添加到这个标题中，这样该部分就不会被编号。

有时正文中没有引用也需要在参考文献列表显示，可以通过 YAML 元数据区块定义`nocite`：

```yaml
nocite: |
  @item1,@item2
```

通过使用通配符，可以创建包含所有引用的文献列表，无论它们是否出现在文档中（这种情况在简历制作时会遇到）：

```yaml
---
nocite: |
  @*
...
```

对于 LaTeX 输出，还可以使用 natbib 或 biblatex 来呈现参考书目。要做到这一点，请按照上面所述指定书目文件，并将 `--natbib` 或 `--biblatex` 参数添加到 pandoc 调用中。记住，书目文件必须是各自的格式（BibTeX 或 BibLaTeX）。

更多信息请参考 [pandoc-citeproc man page](https://github.com/jgm/pandoc-citeproc/blob/master/man/pandoc-citeproc.1.md).