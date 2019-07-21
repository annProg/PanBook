
## zh_en

::: {.info caption="扩展信息"}
使用场景
  ~ 主要用于中英文翻译，可选择隐藏中文或英文，或对照显示。

启用状态
  ~ 默认在所有模块中启用

格式支持  
  ~ \LaTeX 

语法系列
  ~ fenced_divs 参见 [@sec:fenced_divs]  
:::

#### 示例

```markdown
::: {.zh}
有几回，邻舍孩子听得笑声，也赶热闹，围住了孔乙己。他便给他们茴香豆吃，一人一颗。孩子吃完豆，仍然不散，眼睛都望着碟子。孔乙己着了慌，伸开五指将碟子罩住，弯腰下去说道，“不多了，我已经不多了。”直起身又看一看豆，自己摇头说，“不多不多！多乎哉？不多也。”于是这一群孩子都在笑声里走散了。
:::

::: {.en}
A few times, the children in the neighbourhood heard laughter and also rushed around, and surrounded Kong Yiji. He gave them fennel beans, one for each. The child finished the beans, still not scattered, eyes are looking at the dishes. Kong Yi himself panicked, stretched out the five fingers to cover the plate, and bent down and said, "Not much, I am not much." Straight up and look at the beans, shaking his head and saying, "Not much! 哉 哉？Not much." So this group of children are gone in laughter.
:::
```

默认只显示中文，以上代码显示效果如下：

::: {.zh}
有几回，邻舍孩子听得笑声，也赶热闹，围住了孔乙己。他便给他们茴香豆吃，一人一颗。孩子吃完豆，仍然不散，眼睛都望着碟子。孔乙己着了慌，伸开五指将碟子罩住，弯腰下去说道，“不多了，我已经不多了。”直起身又看一看豆，自己摇头说，“不多不多！多乎哉？不多也。”于是这一群孩子都在笑声里走散了。
:::

::: {.en}
A few times, the children in the neighbourhood heard laughter and also rushed around, and surrounded Kong Yiji. He gave them fennel beans, one for each. The child finished the beans, still not scattered, eyes are looking at the dishes. Kong Yi himself panicked, stretched out the five fingers to cover the plate, and bent down and said, "Not much, I am not much." Straight up and look at the beans, shaking his head and saying, "Not much! 哉 哉？Not much." So this group of children are gone in laughter.
:::

通过命令行改变显示语言：

```bash
$ panbook ext -h zh_en
        -G ext-zh_en:<true|false>                        enable zh_en(default true)
        -G ext-zh_en-tex:<custom zh_en set file>         change zh_en set file
        -G ext-zh_en-texlang:<custom language file>      change language file
        -G ext-zh_en-lang:<zh|en|both>                   select language(default zh)
```