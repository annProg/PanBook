
# PanBook 扩展
PanBook 扩展主要基于 pandoc 的 [lua filter](https://pandoc.org/lua-filters.html) 功能定制了一些功能或修改了 pandoc 默认行为。本章将依次介绍每个扩展的用途和用法。

::: {.help caption="扩展通用的命令"}
- 查看扩展列表 panbook ext -l
- 查看扩展帮助 panbook ext -h
- 查看指定扩展的帮助 panbook ext -h abstract
:::

大部分扩展支持用户开启或关闭，但是一般不建议这样做，除非你知道为何要那么做并且知道如何处理编译冲突问题。