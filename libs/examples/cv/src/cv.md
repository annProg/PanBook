---
name: 姓\ 名        # use backslash to escape space
title: \LaTeX 排版工程师
homepage: baidu.com
showdate: true
address: 本星系群银河系太阳系地球 - 中国北京
quote: \LaTeX 写简历漂不漂亮呀
photo: images/photo.png
extrainfo: 不需要的项目删除即可
mobile: 13000001111
email: email@qq.com
github: Github
weibo: Weibo
qq: 123456789
wechat: WeChat
skype: Skype
twitter: Twitter
linkedin: LinkedIn
onlinecv: http://url.online.cv/cv.pdf
nocite: |
  @*
...


# \faGraduationCap 教育经历

### 大学 {date="2019.5 - 2023.5" title="计算机科学与技术" city="北京" score="成绩不好"}

- 一些说明

# \faUsers 工作经验

### 公司 {date="2026.7 - 2027.7" title="软件工程师" city="北京"}

- 一些说明

::: {#refs}
# \faBook 发表作品
:::

# \faList 列表语法
	  
## 普通列表

- 简单列表直接使用Markdown无序列表格式，不支持多级嵌套

## 双栏列表

- [双栏列表]{.double} [第二栏]{.double}

## 带类别列表
- [证书]{.cat}\LaTeX 排版工程师

## 带评论列表

- [英语]{.cat} 不会读不会写 [四级是啥]{.comment}

## 带类别的双栏列表

- [Java,PHP,Lisp]{.double cat="编程"} [Markdown,LaTeX,Pandoc]{.double cat="排版"}
- [MySQL,MongoDB,Redis]{.double cat="数据库"}

# \faColumns 分栏语法

:::: {.cvcolumns}
::: {.cvcolumn cat="数据库"}
- MySQL
- InfluxDB
:::
::: {.cvcolumn cat="编程"}
- Shell
- Haskell
:::
::::


# 韩荆州 {.letter company="大唐帝国" addr="荆州大都督府" city="襄阳"}
## 开元22年 {.letter .date}
## Dear Sir or Madam， {.letter .opening}
## Yours faithfully, {.letter .closing}
## curriculum vit\ae {.letter .enclosure enclosure="附件"}

Cover Letter Here