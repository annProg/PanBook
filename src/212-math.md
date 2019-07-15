
## 数学公式

::: {.info caption="Extension: tex_math_dollars"}
所有介于两个 `$` 字符之间的内容将会被视为 \TeX 数学公式处理。开头的 `$` 右侧必须立刻接上任意文字，而结尾`$`的左侧同样也必须紧挨着文字。这样一来，`$20,000  and  $30,000` 就不会被当作数学公式处理了。如果基于某些原因，有必须使用 `$` 符号将其他文字括住的需求时，那么可以在 `$` 前使用反斜线转义字符，这样 `$` 就不会被当作数学公式的分隔符。
:::

\TeX 数学公式会在所有输出格式中打印。至于如何渲染则取决于输出的格式：

- \LaTeX：转换为 `\(..\)`（行内公式）或者 `\[...\]`（跨行公式）
- Docx：公式会以 OMML 数学标记的方式渲染。
- HTML 和 EPUB：公式会依照命令行 [选项](https://pandoc.org/MANUAL.html#math-rendering-in-html) 的设置，以不同的方法演算编排为 HTML 代码。

以下是一个例子，显示效果见 [@eq:math_demo]：

```latex
$$\begin{cases}
a_1x+b_1y+c_1z=d_1\\
a_2x+b_2y+c_2z=d_2\\
a_3x+b_3y+c_3z=d_3\\
\end{cases}$$ {#eq:math_demo}
```

$$\begin{cases}
a_1x+b_1y+c_1z=d_1\\
a_2x+b_2y+c_2z=d_2\\
a_3x+b_3y+c_3z=d_3\\
\end{cases}$$ {#eq:math_demo}