
## Raw HTML {#sec:raw_html}

::: {.info caption="Extension: raw_html"}
Markdown 允许你在文件中的任何地方插入原始 HTML（或 DocBook）指令（除了在代码块中，此时的 `<`, `>` 和 `&` 都会按其字面意义显示）。（技术上而言这不算扩充功能，因为原始 Markdown 本身就有提供此功能，但做成扩充形式便可以在有特殊需要的时候关闭此功能。）
:::

输出 HTML, S5, Slidy, Slideous, DZSlides, EPUB, Markdown, CommonMark, Emacs Org mode 以及 Textile 等格式时，原始 HTML 代码会不作修改地保留至输出档案中；而其他格式的输出内容则会将原始 HTML 代码去除掉。

::: {.info caption="Extension: markdown_in_html_blocks"}
原始 Markdown 允许你插入 HTML「区块」：所谓的 HTML 区块是指，上下各由一个空白行所隔开，开始与结尾均由所在行最左侧开始的一连串对称均衡的 HTML 标签。在这个区块中，任何内容都会当作是 HTML 来分析，而不再视为 Markdown；所以（举例来说），`*` 符号就不再代表强调。

当指定格式为 `markdown_strict` 时，Pandoc 会以上述方式处理；但预设情况下，Pandoc 能够以 Markdown 语法解读 HTML 区块标签中的内容。举例说明，Pandoc 能够将 [@lst:markdown_in_html_blocks] 转换为 [@lst:markdown_in_html_blocks2]。
:::

```{#lst:markdown_in_html_blocks .html caption="markdown_in_html_blocks 示例"}
<table>
    <tr>
        <td>*one*</td>
        <td>[a link](http://google.com)</td>
    </tr>
</table>
```

```{#lst:markdown_in_html_blocks2 .html caption="markdown_in_html_blocks 转换示例"}
<table>
    <tr>
        <td><em>one</em></td>
        <td><a href="http://google.com">a link</a></td>
    </tr>
</table>
```

而 `Markdown.pl` 则是保留该段原样。

这个规则只有一个例外：那就是介于 `<script>` 与 `<style>` 之间的文字都不会被拿来当作 Markdown 解读。

这里与原始 Markdown 的分歧，主要是为了让 Markdown 能够更便利地混入 HTML 区块元素。比方说，一段 Markdown 文字可以用 `<div>` 标签将其前后包住来进行样式指定，而不用担心里面的 Markdown 不会被解释到。

::: {.info caption="Extension: native_divs"}
直接使用 HTML 的 `<div>` 标签，大部分情况下将产生和 `markdown_in_html_blocks` 相同的输出。使用 `native_divs` 的好处是让 `pandoc filter` 更容易的处理。
:::

::: {.info caption="Extension: native_spans"}
直接使用 HTML 的 `<span>` 标签，输出和 `raw_html` 一样。使用 `native_spans` 的好处也是让 `pandoc filter` 更容易的处理。
:::

::: {.info caption="Extension: raw_tex"}
除了原始 HTML 之外，Pandoc 还允许在文档中包含原始 \LaTeX、\TeX 和 ConText。行内 \TeX 命令将被保留，并不加更改地传递给 \LaTeX 和 ConTeXt。例如，你可以使用 \LaTeX 来引用 BibTeX：

```latex
This result was proved in \cite{jones.1967}.
```
:::

注意，在 \LaTeX 环境中，比如：

```latex
\begin{tabular}{|l|l|}\hline
Age & Frequency \\ \hline
18--25  & 15 \\
26--35  & 33 \\
36--45  & 22 \\ \hline
\end{tabular}
```

`begin` 和 `end` 之间的内容会被解释成原始的 \LaTeX，而不是 Markdown。

有关在标记文档中包含原始 \TeX 的更显式和更灵活的方法，请参见 `raw_attribute` 扩展 [@sec:raw_attribute]。

除了 Markdown、LaTeX、Emacs Org mode 和 ConTeXt 之外，行内 LaTeX 在输出格式中被忽略。

### 通用 raw attribute {#sec:raw_attribute}

::: {.info caption="Extension: raw_attribute"}
此扩展和本项目关系不大，请阅读 [原始文档](https://pandoc.org/MANUAL.html#extension-raw_attribute) 了解更多内容。
:::