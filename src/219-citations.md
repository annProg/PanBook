
## 参考文献 {#sec:citations}
参考文献请勿放在`backmatter.md`中，应作为正文处理。

#### Extension: citations

Pandoc 能够以数种形式自动产生引用与参考书目（使用 Andrea Rossato 的 hs-citeproc）。为了使用这
项功能，你需要一个下列其中一种格式的参考书目资料库，如表、ref{table:citations}所示：

| Format | File extension |
| -----:|------:|
|MODS	|.mods|
|BibLaTeX|	.bib|
|BibTeX	|.bibtex|
|RIS	|.ris|
|EndNote|	.enl|
|EndNote XML|	.xml|
|ISI	|.wos|
|MEDLINE|	.medline|
|Copac	|.copac|
|JSON citeproc	|.json|

Table: \label{table:citations}Pandoc 支持的引用形式

需注意的是副档名。bib 一般而言同时适用于 BibTeX 与 BibLaTeX 的档案，不过你可以使用。bibtex 来强制
指定 BibTeX。

你需要使用命令列选项`--bibliography`来指定参考书目档案（如果有多个书目档就得反覆指定）。

预设情况下，pandoc 会在引用文献与参考书目中使用芝加哥「作者－日期」格式。要使用其他的格式，
你需要用`--csl`选项来指定一个 CSL 1.0 格式的档案。关于建立与修改 CSL 格式的入门可以
在 http://citationstyles.org/downloads/primer.html 这边找到。
https://github.com/citation-style-language/styles 是 CSL 格式的档案库。
也可以在 http://zotero.org/styles 以简单的方式浏览。

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
