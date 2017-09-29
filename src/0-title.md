---
title: 用Markdown+Pandoc+XeLaTeX写作
author:          # 作者（数组）
  - An He
date: \today     # 日期
copyright: true  # 是否生成版权页
lof: true        # 是否生成插图列表页
lot: true        # 是否生成表格列表页
homepage: https://github.com/annProg/pandoc-template
identifier:                      # epub用
  - scheme: DOI
    text: doi:10.234234.234/33
publisher: pandoc-template       # epub用
rights: © 2017 An He, CC BY-NC   # epub用
header-includes:
  - \usepackage{cleveref}
  - \usepackage{float}
# preface用于生成前言
preface: 'LaTeX可以排版格式精美的书籍，但是学习成本较高，使用不便；
 Markdown是一种简单易学的标记语言。如果能结合两者的优点，使用Markdown
 来写作，然后通过程序转换为latex源码，再编译为PDF，那将是一件美妙的事情。
 幸运的是，已经有工具很好的实现了支持这一功能，那就是Pandoc。

 
 Pandoc是由 John MacFarlane 教授开发的标记语言转换工具，实现了数十种标
 记语言之间的转换。Pandoc还扩展了Markdown语法，比如标题表格等的ID属性，
  脚注等，并且可以直接嵌入LaTeX代码，这样在Markdown中就可以实现输入数学
 公式，交叉引用等功能。Pandoc还支持自定义转换模板，通过命令`pandoc -D 
 latex`可以输出默认的LaTeX模板，以此模板为基础，可以定制自己的模板。

 
 本工具定义了一种Markdown源码组织规范，提供了一个转换脚本，用来更方便的
 使用Pandoc将Markdown转换为PDF。另外还定义了一套LaTeX书籍模板，用来生成
 中文书籍。用户也可以在自己的工作目录修改此模板，并通过修改配置来引用自己
 的模板。'
---