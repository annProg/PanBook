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
weibo: Weibo
qq: 123456789
wechat: panbook
skype: skype
twitter: twitter
linkedin: linkedin
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

- 标题可用 1 - 3 级，1级表示大类别，2级表示小类别，3级一般用来表示一段经历并支持设置属性
  - `date` 表示这段经历的时间段
  - `title` 表示职位 或者 专业 或者 学位等
  - `city` 表示城市
  - `score` 表示成绩
  - 不需要的属性不设置即可

# 工作经验

### ZZ公司 {date="2026.7 - 2027.7" title="软件工程师" city="北京"}

- 描述经历可用Markdown列表语法
  - 列表可以多级
- 列表中支持Markdown加粗和行内代码语法

::: {#refs}
# 发表作品
:::

# 列表语法
	  
## 普通列表

- 简单列表直接使用Markdown无序列表格式，不支持多级嵌套
- 使用`bracketed_spans`语法生成复杂列表
- 双栏列表语法：`[双栏列表]{.double} [第二栏]{.double}`
- 双栏带类别语法：`[编程]{.cat}[Java]{.double} [排版]{.cat}[LaTeX]{.double}`
- 有点郁闷，好像还不如原生的`\cvitem`命令简单
- [一]{.double} [二]{.double} [三]{.double}
- [cat1]{.cat}[一]{.double} [cat2]{.cat}[二]{.double} [cat3]{.cat}[三]{.double}

## 双栏列表

- [双栏列表]{.double} [第二栏]{.double}
- [仅一列的双栏样式]{.double}

## 带类别列表
- `[类别]{.cat}`生成带类别的列表[语法]{.cat}

## 带评论列表

- `[类别]{.cat}描述[评论]{.comment}` [类别]{.cat}同时带类别和评论[评论]{.comment}
- [英语]{.cat} 不会读不会写 [四级是啥]{.comment}

## 带类别的双栏列表

- [编程]{.cat}[Java,PHP,Lisp,Haskell,Golang,C++]{.double} [排版]{.cat}[Markdown,LaTeX,Pandoc,PanBook]{.double}
- [数据库]{.cat}[MySQL,MongoDB,Redis,InfluxDB]{.double}

# 分栏语法

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

# 求职信语法

- 使用一级标题和二级标题定义求职信基础信息，第一个样式必须为`.letter`
- 一级标题用于定义接收方（必选），必选属性 `company="公司"`，`addr="地址"`，`city="城市"`
- 二级标题通过第二个样式定义不同的功能
- [日期]{.cat}  `.date`，可选
- [称呼]{.cat} `.opening` ，必选
- [祝颂语]{.cat} `.closing` ，必选
- [附件]{.cat} `.enclosure` ，可选
- 二级标题样式为附件时，可用`enclosure`属性定义显示名称
- 举例：`## 我的简历 {.letter .enclosure enclosure="附件"}`
- 接下来开始写正文


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