
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

可以使用 [Zotero 样式库](https://www.zotero.org/styles) 中列出的 [引文样式语言](http://citationstyles.org/) 支持的任何样式对引用和引用进行格式化。这些文件是使用 `--csl` 选项或 `csl` 元数据字段指定的。默认情况下，pandoc-citeproc 将使用样式为 author-date 格式的 [Chicago Manual of Style](http://chicagomanualofstyle.org/)。CSL 项目提供了关于 [查找和编辑样式](https://citationstyles.org/authors/) 的进一步信息。

要使引用超链接到相应的参考文献条目，请在 YAML 元数据区块中设置 `link-citations: true`。

引用资讯放在方括号中，以分号区隔。每一条引用都会有个 key，由@加上资料库中的引用 ID 组成，并
且可以选择性地包含前缀、定位以及后缀。以下是一些范例：

```markdown
Blah blah [see @doe99, pp. 33-35; also @smith04, ch. 1].

Blah blah [@doe99, pp. 33-35, 38-39 and *passim*].

Blah blah [@smith04; @doe99].
```

在@前面的减号 ( -) 将会避免作者名字在引用中出现。这可以用在已经提及作者的文章场合中：
```markdown
Smith says blah [-@smith04].
```
你也可以在文字中直接插入引用资讯，方式如下：
```markdown
@smith04 says blah.

@smith04 [p. 33] says blah.
```
如果引用格式档需要产生一份引用作品的清单，这份清单会被放在文件的最后面。一般而言，
你需要以一个适当的标题结束你的文件：
```markdown
last paragraph...

# References
```
如此一来参考书目就会被放在这个标题后面了。

另一种方式，可以使用`fenced_divs`语法，参考文献将显示在带 `{#refs}` 属性的`div`中第一个大标题下：

```
::: {#refs}
# 我的参考文献 {.unnumbered}
:::
```
注意这种语法需要指定标题的 `{.unnumbered}`属性，避免参考文献被当成章节编号。

### 列出为引用的参考文献

有时正文中没有引用也需要在参考文献列表显示，可以通过`meta yaml`定义`nocite`：

```yaml
nocite: |
  @item1,@item2
```

如果要全部列出，可以使用通配符 `@*`，这种情况在简历制作时会遇到。
