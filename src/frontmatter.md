# 前言 {epub:type=preface .unnumbered}

\LaTeX 可以用来排版格式精美的书籍，论文，幻灯片以及简历，但是学习成本较高，使用不便；Markdown是一种简单易学的标记语言。如果能结合两者的优点，使用Markdown来写作，然后通过程序转换为\LaTeX 源码或直接输出为PDF，那将是一件美妙的事情。幸运的是，已经有工具很好的实现了支持这一功能，那就是Pandoc。

[Pandoc](https://pandoc.org)是由 John MacFarlane 教授开发的文档转换工具，实现了数十种文档格式之间的转换。Pandoc还扩展了Markdown语法，比如标题表格等的ID属性，脚注，交叉引用，DIV语法等，并且可以直接嵌入\LaTeX 代码，这样在Markdown中就可以实现输入数学公式。Pandoc还支持自定义模板和`lua`脚本修改转换结果，有很好的自由度和扩展能力。

PanBook要做的事情，就是利用自定义模板来提供一些开箱即用的书籍，论文，幻灯片及简历模板，并开发`lua filter`来实现一些诸如多列显示，定理环境，文本转图片等扩展功能。希望能够更方便的利用`Markdown`和`Pandoc`来写作。