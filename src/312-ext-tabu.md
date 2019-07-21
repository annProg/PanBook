
## tabu

::: {.info caption="扩展信息"}
使用场景
  ~ 由于 longtable 有难以修复的 [bug](https://github.com/annProg/PanBook/issues/22)，使用 tabu 替代 longtable

启用状态
  ~ 默认在所有模块中启用

格式支持  
  ~ \LaTeX 

语法系列
  ~ 自定义
:::

#### 示例

默认使用 `tabu`，除非以下两种情况。

表格标题开头使用 `{.longtable} ` 表示使用 pandoc 原生表格处理方式：
```markdown
a | b
--|--
c | d

: {.longtable} Use pandoc longtable
```

表格标题开头使用 `{.longtabu} ` 表示使用 longtabu 处理换页表格：

```markdown
a | b
--|--
c | d

: {.longtabu} Use longtabu
```
