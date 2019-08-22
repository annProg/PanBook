
## wrap

::: {.info caption="扩展信息"}
使用场景
  ~ 提供文本框环境

启用状态
  ~ 默认在 book, art，thesis, cv 中启用

格式支持  
  ~ \LaTeX 

语法系列
  ~ fenced_divs 参见 [@sec:fenced_divs]  
:::

#### 示例

```markdown
::: {.help}
Help
:::

::: {.info caption="自定义标题"}
Info
:::

::: {.warn}
Warn
:::

::: {.alert}
Alert
:::

::: {.tip}
Tip
:::

introduction（章节内容提要） 和 problemset（习题） 环境必须使用列表

::: {.introduction}
- Introduction
:::

::: {.problemset}
- Problemset
:::

::: {.solu}
解题环境，默认整体缩进 2em，可通过 caption 自定义缩进
:::
```

效果：

::: {.help}
Help
:::

::: {.info caption="自定义标题"}
Info
:::

::: {.warn}
Warn
:::

::: {.alert}
Alert
:::

::: {.tip}
Tip
:::

introduction（章节内容提要） 和 problemset（习题） 环境必须使用列表

::: {.introduction}
- Introduction
:::

::: {.problemset}
- Problemset
:::

::: {.solu}
解题环境，默认整体缩进 2em，可通过 caption 自定义缩进
:::

::: {.info caption="更改 Wrap 风格"}
可以通过命令行参数指定 Wrap 风格（`-G ext-wrap-style:<bclogo|tcolorbox>`），默认为 tcolorbox。也可以通过 `-G ext-wrap-tex:<custom wrap set file>` 自定义风格
:::