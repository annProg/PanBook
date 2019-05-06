# columns

`fenced_divs`的columns语法是在beamer中用的。

latex中需要定义 columns 和 column 环境

## minipage 空行导致columns不生效问题

嵌套 2个minipage之间有空行时，不能正确生成多列

参见：

-  A blank line always introduces a new paragraph.  https://latex.org/forum/viewtopic.php?t=12388

## 解决方案

参见： https://github.com/jgm/pandoc/issues/5485

考虑到作者不愿意在默认模板中定义 column 环境，且现在的 LaTeX writer生成的 column之间有空行，用minipage定义的
columns环境不能正常工作，因此考虑用lua filter实现来支持columns


## Update 
lua filter也会产生空行。咋办