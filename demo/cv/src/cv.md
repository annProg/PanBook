---
author: 盘\ 书        # 空格可用反斜杠转义
title: \LaTeX 排版工程师
homepage: baidu.com
showdate: true
address: 本星系群银河系本星际云太阳系地球 - 中国北京
quote: \LaTeX 写简历漂不漂亮呀
photo: images/photo.png
extrainfo: 个人信息不需要的项目删除即可
mobile: 13000001111
github: annProg
onlinecv: http://github.com/annProg/PanBook/tree/master/demo/cv
nocite: |
  @*
...


# 教育经历

### XX大学 {date="2019.5 - 2023.5" title="计算机科学与技术" city="北京" score="成绩不好"}

- 在简历开头用`yaml`格式设置`metadata`变量，不需要的变量不设置即可
- 如果需要插入`bibtex`，请在`metadata`中设置 `nocite`变量为 `nocite: |\n  @*`（请把`\n`改成换行）
  - 使用`fenced_div`语法引用`bibtex`，例如`::: {#refs}\n# 大标题\n:::`（请把`\n`改成换行）

### YY大学 {date="2023.5 - 2026.5" title="计算机应用技术 工学硕士" city="北京" score="是个学渣"}

- 标题可用 1 - 3 级，1级表示大类别，2级好像没啥用，3级一般用来表示一段经历并支持设置属性
  - `date` 表示这段经历的时间段
  - `title` 表示职位 或者 专业 或者 学位等
  - `city` 表示城市
  - `score` 表示成绩
  - 不需要的属性不设置即可

# 工作经验

### ZZ公司 {date="2026.7 - 2027.7" title="软件工程师" city="北京"}

- 描述经历可用Markdown列表语法
  - 列表可以多级
- 列表中支持Markdown加粗和行内代码语法（一级二级标题下的列表不支持高亮）  

::: {#refs}
# 发表作品
:::

# 列表

- 简单列表直接使用Markdown无序列表格式
- 使用`bracketed_spans`语法生成不同形式列表
- `[这里显示一列]{.double}` 双列列表[这里显示一列]{.double}
- `[类别]{.cat}`生成带类别的列表[类别]{.cat}
- `[评论]{.comment}[类别]{.cat}` 同时带类别和评论[类别]{.cat}[评论]{.comment}
- `[Java]{.double cat="编程"} [LaTeX]{.double cat="排版"}`[双栏带类别]{.cat}
- [Java,PHP]{.double cat="编程"} [Markdown,LaTeX]{.double cat="排版"}

# 分栏

:::: {.cvcolumns}
::: {.cvcolumn cat="Test"}
- fenced_divs语法变体
- 带 .cvcolumns样式
:::
::: {.cvcolumn cat="测试"}
- 每一列使用 .cvcolumn样式
- cat 属性设置类别标题
:::
::::