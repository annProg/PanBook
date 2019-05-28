
## Raw TeX

#### Extension: raw_tex

除了HTML 之外，pandoc 也接受文件中嵌入原始LaTeX, TeX 以及ConTeXt 代码。行内TeX 指令会被保留
并不作修改地输出至LaTeX 与ConTeXt 格式中。所以，举例来说，你可以使用LaTeX 来导入BibTeX 的引
用文献：
```
This result was proved in \cite{jones.1967}.
```
请注意在LaTeX 环境下时，像是底下
```tex
\begin{tabular}{|l|l|}\hline
Age & Frequency \\ \hline
18--25  & 15 \\
26--35  & 33 \\
36--45  & 22 \\ \hline
\end{tabular}
```
位在begin与end标签之间的内容，都会被当作是原始LaTeX资料解读，而不会视为markdown。

行内LaTeX 在输出至Markdown, LaTeX 及ConTeXt 之外的格式时会被忽略掉。

## LaTeX 巨集

#### Extension: latex_macros

当输出格式不是LaTeX时，pandoc会分析LaTeX的`\newcommand`和`\renewcommand`定义，并套用
其产生的巨集到所有LaTeX数学公式中。所以，举例来说，下列指令对于所有的输出格式均有作
用，而非仅仅作用于LaTeX格式：
```tex
\newcommand{\tuple}[1]{\langle #1 \rangle}

$\tuple{a, b, c}$
```
在LaTeX的输出中，`\newcommand`定义会单纯不作修改地保留至输出结果。