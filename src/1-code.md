---
header-includes:
  - \usepackage{cleveref}
include-before:
  - \begin{frontmatter}这里是前言\end{frontmatter}
---


# 代码块
pandoc扩展的Markdown语法可以为代码块添加ID属性及语言类型属性，形如`{#id .language}`，其中ID属性可以用来做交叉引用，使用`\ref{id}`在正文中引用代码块。例如代码块\ref{code:demo}。

```{#code:demo .bash}
~~~{#code:demo .bash}
#!/bin/bash
echo "Hello LaTeX"
echo "Hello Pandoc"
echo "Hello Markdown"
~~~~
```