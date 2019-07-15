
## 交叉引用 {#sec:crossref}

### 图片

```
![Caption](file.ext){#fig:label}
```

o label an (implicit) figure, append `{#fig:label}` (with `label` being something unique to reference this figure by) immediately after image definition.

This only works on implicit figures, i.e. an image occurring by itself in a paragraph (which will be rendered as a figure with caption by pandoc)

Image block and label can not be separated by spaces.

#### 子图
结合`fenced_divs`语法，It’s possible to group figures as subfigures. Basic syntax is as follows:

```
<div id="fig:figureRef">
![subfigure 1 caption](image1.png){#fig:figureRefA}

![subfigure 2 caption](image2.png){#fig:figureRefB}

Caption of figure
</div>
```
To sum up, subfigures are made with a div having a figure `id`. Contents of said div consist of several paragraphs. All but last paragraphs contain one subfigure each, with captions, images and (optionally) reference attributes. Last paragraph contains figure caption.

If you put more than one figure in the paragraph, those will still be rendered, but Pandoc will omit subfigure caption in most outputs (but it will work as expected with LaTeX). You can use output-specific hacks to work around that, or use `subfigGrid` (see below).

Output is customizable, with metadata fields. See Customization for more information.

Default settings will produce the following equivalent Markdown from example above:

```
<div id="fig:figureRef" class="subfigures">

![a](image1.png){#fig:figureRefA}

![b](image2.png){#fig:figureRefB}

Figure 1: Caption of figure. a — subfigure 1 caption, b — subfigure 2
caption

</div>
```

References to subfigures will be rendered as figureNumber (subfigureNumber), e.g., in this particular example, `[@fig:figureRefA]` will produce fig. 1 (a).

You can add nocaption class to an image to suppress subfigure caption altogether. Note that it will still be counted.

#### Subfigure grid

If you need to align subfigures in a grid, and using output format styles is not an option, you can use `subfigGrid` option. That will typeset subfigures inside a table.

Rows are formed by different paragraphs, with each image in a separate column.

Column widths will be taken from width attributes of corresponding images, e.g.

```
<div id="fig:coolFig">
![caption a](coolfiga.png){#fig:cfa width=30%}
![caption b](coolfigb.png){#fig:cfb width=60%}
![caption c](coolfigb.png){#fig:cfc width=10%}

![caption d](coolfigd.png){#fig:cfd}
![caption e](coolfige.png){#fig:cfe}
![caption f](coolfigf.png){#fig:cff}

Cool figure!
</div>
```

will produce a table with columns of `30%`, `60%` and `10%` respectively.

Only first row of images is considered for table width computation, other rows are completely ignored.

Anything except images is silently ignored. So any text, spaces, soft line breaks etc will silently disappear from output. That doesn’t apply to caption paragraph, obviously.

All images will have width attribute automatically set to `100%` in order to fill whole column.

Specifying width in anything but `%` will throw an error.

If width for some images in first row is not specified, those will span equally in the remaining space.

If width isn’t specified for any image in first row, those will span equally on `99%` of page width (due to Pandoc otherwise omitting width attribute for table).

This option is ignored with LaTeX output, but paragraph breaks should produce similar effect, so images should be typeset correctly. TL;DR you don’t need subfigGrid enabled for it to work with LaTeX, but you can still enable it.

### 公式

```
$$ math $$ {#eq:label}
```

To label a display equation, append `{#eq:label}` (with label being something unique to reference this equation by) immediately after math block.

Math block and label can be separated by one or more spaces.

You can also number all display equations with `autoEqnLabels` metadata setting (see below). Note, however, that you won’t be able to reference equations without explicit labels.

Equations numbers will be typeset inside math with `\qquad` before them. If you want to use tables instead, use tableEqns option. Depending on output format, tables might work better or worse than `\qquad`.

### 表格

```
a   b   c
--- --- ---
1   2   3
4   5   6

: Caption {#tbl:label}
```

To label a table, append `{#tbl:label}` at the end of `table` caption (with label being something unique to reference this table by). Caption and label must be separated by at least one space.

### 标题

You can also reference sections of any level. Section labels use native pandoc syntax, but must start with “sec:”, e.g.

```
Section {#sec:section}
```

### 代码块

There are a couple options to add code block labels. Those work only if code block id starts with lst:, e.g. `{#lst:label}`

#### caption attribute
caption attribute will be treated as code block caption. If code block has both id and caption attributes, it will be treated as numbered code block.

~~~
```{#lst:code .haskell caption="Listing caption"}
main :: IO ()
main = putStrLn "Hello World!"
```
~~~

### 引用

```
[@fig:label1;@fig:label2;...] or [@eq:label1;@eq:label2;...] or [@tbl:label1;@tbl:label2;...] or @fig:label or @eq:label or @tbl:label
```

Reference syntax heavily relies on citation syntax. Basic reference is created by writing @, then basically desired label with prefix. It is also possible to reference a group of objects, by putting them into brackets with ; as separator. Similar objects will be grouped in order of them appearing in citation brackets, and sequential reference numbers will be shortened, e.g. 1,2,3 will be shortened to 1-3.

You can capitalize first reference character to get capitalized prefix, e.g. `[@Fig:label1]` will produce Fig. ... by default. Capitalized prefixes are derived automatically by capitalizing first letter of every word in non-capitalized prefix, unless overridden with metadata settings. See Customization for more information.

#### Linking references
To make references into hyperlinks to referenced element, enable `linkReferences` metadata option. This has no effect on LaTeX output, since in this case, hyperlinking references is handled with `hyperref` LaTeX package.

#### Custom prefix per-reference
It’s possible to provide your own prefix per-reference, f.ex. `[Prefix @reference]` will replace default prefix (`fig./sec./`etc) with prefix verbatim, e.g. `[Prefix @fig:1]` will be rendered as Prefix 1 instead of fig. 1.

In citation group, citations with the same prefix will be grouped. So, for example `[A @fig:1; A @fig:2; B @fig:3]` will turn into A 1, 2, B 3. It can be used to an advantage, although it’s a bit more cumbersome than it should be, e.g. `[Appendices @sec:A1; Appendices @sec:A2; Appendices @sec:A3]` will turn into Appendices `@A1-@A3` (with @A1 and `@A3` being relevant section numbers). Note that non-contiguous sequences of identical prefixes will not be grouped.

**Not supported with cleveref LaTeX output.**

#### Prefix suppression
Prepending - before @, like so `[-@citation]`, will suppress default prefix, e.g. `[-@fig:1]`will produce just 1 (or whatever number it happens to be) without fig. prefix.

In citation group, citations with and without prefixes will be in different groups. So `[-@fig:1; @fig:2; -@fig:3]` will be rendered as 1, fig. 2, 3, so be careful with this feature. Again, non-contiguous sequences are not grouped together.

#### Lists
It’s possible to use raw latex commands `\listoffigures`, `\listoftables` and `\listoflistings`, which will produce ordered list of figure/table/listings titles, in order of appearance in document.

`\listoflistings` depends on other options, and is defined in preamble, so it will work reliably only with standalone/pdf output.

NOTE: With Pandoc 2.0.6 and up, you’ll have to explicitly separate these commands if they are close together, at least when targeting something besides LaTeX. So this will not work:

```
\listoffigures

\listoftables

\listoflistings
```

but this will:
```
\listoffigures
[]: hack to split raw blocks
\listoftables
[]: hack to split raw blocks
\listoflistings
```

### 自定义交叉引用配置

使用选项 `--crs`指定自定义的交叉引用配置，默认为`crs/zh-CN.yaml`。配置方法请参考`pandoc-crossref`文档：https://lierdakil.github.io/pandoc-crossref