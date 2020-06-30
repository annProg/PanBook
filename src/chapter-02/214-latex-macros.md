## \LaTeX 宏指令

::: {.info caption="Extension: latex_macros"}
当输出格式不是 \LaTeX 时，Pandoc 会分析 \LaTeX 的 `\newcommand` 和 `\renewcommand` 定义，并套用其产生的巨集到所有 \LaTeX 数学公式中。所以，举例来说，下列指令对于所有的输出格式均有作用，而非仅仅作用于 \LaTeX 格式：
:::

```latex
\newcommand{\tuple}[1]{\langle #1 \rangle}

$\tuple{a, b, c}$
```

在 \LaTeX 的输出中，`\newcommand` 定义会单纯不作修改地保留至输出结果。