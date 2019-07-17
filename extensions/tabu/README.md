# tabu

由于 longtable 存在 bug，和多个浮动体在同一个页面时，换行错入，部分内容会溢出页面（参见 https://github.com/annProg/PanBook/issues/22）。

此扩展将使用 tabu 替代 longtable，默认使用 `tabu` 环境。用户指定 `{.long}` 时，使用 `longtabu` 环境。

基于 pandoc-crossref，需要在 pandoc-crossref 之后调用：修改 pandoc-crossref 产生的 ID 为 `tbl:label` 的 Div ，将其中 `Table` 用 tabu 重写为 `RawBlock`