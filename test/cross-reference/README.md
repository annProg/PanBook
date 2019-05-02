---
title: 交叉引用
author: Ann
date: 2019/5/1
header-includes:
  - \usepackage{cleverref}
  - \usepackage{float}
...

# 交叉引用

## 需求

同时支持 LaTeX, Epub, HTML

## 代码

- `\ref`方式： 如代码\ref{lst:test}所示
- `[@id]`语法: 如代码[@lst:test]所示
- `[Prefix @id]`语法: 如[代码 @lst:test]所示

```{#lst:test .bash caption="Test Code Reference"}
#/bin/bash
echo "hello world"
```

## 问题

当命令行中使用了`-H`参数时，`yaml`中的`header-includes`会被覆盖

### LaTeX output and --include-in-header
pandoc-crossref uses metadata variable header-includes to add LaTeX definitions to output. However, Pandoc’s command line option --include-in-header/-H overrides this variable. If you need to use --include-in-header, add pandoc-crossref-specific definitions as well. See LaTeX customization for more information.