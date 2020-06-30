
## coverletter

::: {.info caption="扩展信息"}
使用场景
  ~ 提供求职信功能

启用状态
  ~ 默认在 cv 中启用

格式支持  
  ~ \LaTeX 

语法系列
  ~ fenced_divs 参见 [@sec:fenced_divs]  
:::

#### 示例

```markdown
# 韩荆州 {.letter company="公司" addr="地址" city="城市"}    // 接收方，全部必须
## 开元 22 年 {.letter .date}                               // 日期， 可选
## Dear Sir or Madam， {.letter .opening}                   // 称呼， 必须
## Yours faithfully, {.letter .closing}                     // 祝颂语，必须
## curriculum vit\ae {.letter .enclosure enclosure="附件"}  // 附件， 可选

正文
```