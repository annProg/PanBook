---
name: 盘\ 书        # 空格可用反斜杠转义
title: \LaTeX 排版工程师
homepage: me.homepage
showdate: true
address: 本星系群银河系本星际云太阳系地球 - 中国北京
quote: \LaTeX 写简历漂不漂亮呀
photo: images/photo.png
extrainfo: 个人信息不需要的项目删除即可
email: me@email.me
mobile: 13000001111
github: annProg
weibo: Weibo
qq: 123456789
wechat: WeChat
skype: Skype
twitter: Twitter
linkedin: LinkedIn
onlinecv: http://github.com/annProg/PanBook/tree/master/demo/cv
nocite: |
  @*
...


# \faUser~ 个人信息

- 简历开头用`yaml`格式设置个人信息数据，不需要的变量不设置即可

# \faDatabase~  标题

### 一级和二级标题 [2019.7 - 2019.8]{.date} [支持`fontawesome`]{.desc}

- 大类别用`Markdown`一级标题语法，可在开头直接使用`fontawesome`图表，如`# \faUser 个人信息`
- 带有`{.side}`属性的大标题表示显示在边栏（需模板支持）
- `Markdown`二级标题用来表示小类别


### 简历条目 [2019.8 - 2019.9]{.date} [`Markdown`三级标题]{.title} [`bracketed_spans`]{.tag}

- 简历条目用`Markdown`三级标题表示，使用`bracketed_spans`语法添加条目属性
  - `[content]{.date}` 表示这段经历的时间段
  - `[content]{.title}` 表示职位 或者 专业 或者 学位等
  - `[content]{.tag}` 表示标签（比如 城市，或项目用到的技术等）
  - `[content]{.desc}` 简短的描述
  - 未使用`bracketed_spans`语法的部分做为条目标题，不需要的样式不设置即可
- 简历条目之后可以用列表描述此条目,支持多级，支持`Markdown`加粗和行内代码
  

::: {#refs}
# \faBook~ 发表作品
:::

# \faBook~ 出版物  

```yaml
# 请在`metadata`中设置 `nocite`变量为 
nocite: |
  @*`
# 使用`fenced_div`语法引用`bibtex`
::: {#refs}
# 已发表作品
:::
# 在 src/bibliography.bib 文件里填写出版物
```

# \faList~ 列表语法
	  
- [简单列表]{.cat} 简单列表直接使用Markdown无序列表格式，不支持多级嵌套
- [复杂列表]{.cat} 使用`bracketed_spans`语法生成复杂列表
- [双栏列表]{.cat} `[第一栏]{.double} [第二栏]{.double}`
- [双栏带类别]{.cat} `[编程]{.cat}[Java]{.double} [排版]{.cat}[LaTeX]{.double}`
- [带评论列表]{.cat} `[类别]{.cat}描述[评论]{.comment}`

## 双栏列表

- [第一栏]{.double} [第二栏]{.double}

## 带类别列表

- [语法]{.cat}`[类别]{.cat}`生成带类别的列表

## 带评论列表

- [英语]{.cat} 不会读不会写 [四级是啥]{.comment}

## 带类别的双栏列表

- [编程]{.cat}[Java,PHP,Lisp,Haskell,Golang,C++]{.double} [排版]{.cat}[Markdown,LaTeX,Pandoc,PanBook]{.double}
- [数据库]{.cat}[MySQL,MongoDB,Redis,InfluxDB]{.double}

# \faColumns~ 分栏语法

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

# \faEnvelope~ 求职信

```
# 韩荆州 {.letter company="公司" addr="地址" city="城市"}  // 接收方，全部必须
## 开元22年 {.letter .date}                                // 日期， 可选
## Dear Sir or Madam， {.letter .opening}                  // 称呼， 必须
## Yours faithfully, {.letter .closing}                    // 祝颂语，必须
## curriculum vit\ae {.letter .enclosure enclosure="附件"} // 附件， 可选

正文
```

# \faStarHalfO~ 技能打分

- [语法]{.cat} `\grade1` ~ `\grade5` （1-5分）
- [排版]{.cat} \LaTeX,Markdown         [\grade4]{.comment}
- [已知问题]{.cat}`moderncv`双栏列表使用此功能会报错，请使用`fenced_divs`分栏语法代替

# 韩荆州 {.letter company="大唐帝国" addr="荆州大都督府" city="襄阳"}
## 开元22年 {.letter .date}
## Dear Sir or Madam， {.letter .opening}
## Yours faithfully, {.letter .closing}
## curriculum vit\ae {.letter .enclosure enclosure="附件"}


白闻天下谈士相聚而言曰：“生不用封万户侯，但愿一识韩荆州。”何令人之景慕，一至于此耶！岂不以有周公之风，躬吐握之事，使海内豪俊，奔走而归之，一登龙门，则声价十倍！所以龙蟠凤逸之士，皆欲收名定价于君侯。愿君侯不以富贵而骄之、寒贱而忽之，则三千之中有毛遂，使白得颖脱而出，即其人焉。
白，陇西布衣，流落楚、汉。十五好剑术，遍干诸侯。三十成文章，历抵卿相。虽长不满七尺，而心雄万夫。皆王公大人许与气义。此畴曩心迹，安敢不尽于君侯哉！


君侯制作侔神明，德行动天地，笔参造化，学究天人。幸愿开张心颜，不以长揖见拒。必若接之以高宴，纵之以清谈，请日试万言，倚马可待。今天下以君侯为文章之司命，人物之权衡，一经品题，便作佳士。而君侯何惜阶前盈尺之地，不使白扬眉吐气，激昂青云耶？


昔王子师为豫州，未下车，即辟荀慈明，既下车，又辟孔文举；山涛作冀州，甄拔三十余人，或为侍中、尚书，先代所美。而君侯亦荐一严协律，入为秘书郎，中间崔宗之、房习祖、黎昕、许莹之徒，或以才名见知，或以清白见赏。白每观其衔恩抚躬，忠义奋发，以此感激，知君侯推赤心于诸贤腹中，所以不归他人，而愿委身国士。傥急难有用，敢效微躯。


且人非尧舜，谁能尽善？白谟猷筹画，安能自矜？至于制作，积成卷轴，则欲尘秽视听。恐雕虫小技，不合大人。若赐观刍荛，请给纸墨，兼之书人，然后退扫闲轩，缮写呈上。庶青萍、结绿，长价于薛、卞之门。幸惟下流，大开奖饰，惟君侯图之。