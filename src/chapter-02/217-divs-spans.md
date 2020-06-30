
## Divs 和 Spans 语法 {#sec:fenced_divs}
使用 native_divs 和 native_span 扩展（见 [@sec:raw_html]），HTML 语法可以作为 Markdown 的一部分，在 pandoc AST 中创建本地 Div 和 Span 元素（与原始 HTML 相反）。不过，还有更好的语法。

::: {.info caption="Extension: fenced_divs"}
为原生 Div 块提供了特殊的围栏式语法。Div 以一个包含至少三个连续冒号和一些属性的围栏开始。属性后面可以选择跟随另一串连续冒号。属性语法与围栏式代码块完全相同（参见 [Extension: fenced_code_attributes](https://pandoc.org/MANUAL.html#extension-fenced_code_attributes)）。与围栏式代码块一样，可以使用大括号中的属性，也可以使用单个无括号单词（无括号单词将被视为样式名）。Div 以另一个包含至少三个连续冒号组成的字符串的行结束。围栏式 Div 应该用空行与前面和后面的区块分隔。
:::

示例：

```markdown
::::: {#special .sidebar}
Here is a paragraph.

And another.
:::::
```

围栏式 Div 支持嵌套。开头围栏很容易区分因为它们带有属性：

```markdown
::: Warning ::::::
This is a warning.

::: Danger
This is a warning within a warning.
:::
::::::::::::::::::
```

没有属性的栏总是围栏结尾。与围栏式代码块不同，围栏结尾中的冒号数不必与围栏开头中的冒号数匹配。然而，使用不同长度的栅栏来区分嵌套 div 和它们的父 div 可能有助于提高视觉清晰度。

::: {.info caption="Extension: bracketed_spans"}
用括号括起来的行内序列，语法和链接开头一样，如果紧接其后的是属性，则将被视为带有属性的 `Span`：

```markdown
[This is *some text*]{.class key="val"}
```
:::
