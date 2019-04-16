# 盘书 - Pandoc Template
<p align="center">
  <img height="120" src="medias/panbook.png">
</p>

## 简介
此项目定义了一种`Markdown`源码组织规范，提供一个脚本`panbook`及数个`LaTeX`及`epub`模板，用来更方便的使用`Pandoc`将`Markdown`转换为`PDF`及`epub`格式电子书。

查看电子书效果：

- [ElegantBook模板-pc](https://api.annhe.net/PanBook/PanBook-latex-elegantbook-pc.pdf)
- [Ctex模板-pc](https://api.annhe.net/PanBook/PanBook-latex-ctexbook-pc.pdf)
- [Ctexart模板-pc](https://api.annhe.net/PanBook/PanBook-latex-ctexart-pc.pdf)
- [Ctex模板-mobile](https://api.annhe.net/PanBook/PanBook-latex-ctexbook-mobile.pdf)
- [Epub模板](https://api.annhe.net/PanBook/PanBook.epub)

## 快速开始
以`Windows 10`为例，演示如何使用。

### 安装软件

- 下载[msys2](https://www.msys2.org/) 并安装
- 下载[texlive](http://mirror.ctan.org/systems/texlive/Images/) 2018或以上版本并安装
- 下载[Pandoc](https://pandoc.org/installing.html) 2.7.1或以上版本并安装

### 下载本项目

打开`msys2`，假设工作目录为`/d/dev`

```
$ cd /d/dev
$ git clone https://github.com/annProg/PanBook
```

### 设置环境变量
需要将本项目，`texlive`及`Pandoc`加入环境变量，编辑`~/.bashrc`，加入以下内容

```
$ tail -n 1 ~/.bashrc
export PATH=$PATH:/d/texlive/2018/bin/win32:/d/dev/PanBook:/c/Users/myname/AppData/Local/Pandoc
```

### 开始使用
假设电子书目录为 `/d/dev/mybook`

```
$ cd /d/dev/mybook
$ panbook init                  # 初始化工作环境
$ panbook epub                  # 生成epub电子书
$ panbook pdf                   # 生成pdf电子书
$ panbook beamer                # 生成beamer幻灯片
$ panbook html                  # 生成html电子书
$ panbook epub d                # 加d选项意为debug模式，仅生成一种代码高亮样式(epub和html格式有效)
$ panbook eps                   # 将IMGDIR中的png或gif图片转为eps供latex使用
$ SRC=markdown panbook epub     # 使用环境变量
```

之后在`src`目录进行写作, `src/images`目录存放图片

### 可用环境变量

| 环境变量 | 用途 |
| ------ | ---- |
|TPL     |    指定模板           elegantbook\|ctex\|epub\|html5 |
DEVICE   |   指定设备类型       mobile\|kindle\|pc  需要模板支持|
ELEGANT  |   elegantbook专用设置elegantbook选项，可设置语言模板(cn\|en)，颜色主题(green\|blue\|cyan\|plain)，章标题显示风格(hang\|display)，比如  ELEGANT=cn,blue  即使用中文，蓝色主题编译|
CSS      |    指定epub自定义样式文件名，css应放置在对应模板目录下的css文件夹下|
SRC      |   默认SRC目录名为 src ，可以通过此环境变量更改|
IMGDIR   |   指定图片文件夹路径|
COVER    | 为`ctex`模板指定封面背景图片编号（`1-60`或者用`r`表示随机）|
CJK      | beamer模板可用，指定CJK字体 |
DOCUMENT | latex模板可用，指定文档类 |

## 注意事项
- 在Windows上使用`Pandoc`需要`Markdown`文件保存为`UTF-8`格式
- 按章节拆分的多个`Markdown`文件，开头需要空一行，否则`Pandoc`可能不能正确识别标题

## 模板说明
本项目使用了一些开源模板，列表如下

- [ElegantBook](https://github.com/ElegantLaTeX/ElegantBook)

## 演示

使用本项目编译的书籍

- [自学是门手艺 李笑来](https://github.com/pandoc-ebook/the-craft-of-selfteaching)
- [人人都能用英语 李笑来](https://github.com/pandoc-ebook/everyone-can-use-english)
- [把时间当作朋友 李笑来](https://github.com/pandoc-ebook/time-as-a-friend/releases)
- [TOEFL iBT高分作文 李笑来](https://github.com/pandoc-ebook/twe185/releases)
- [翻译漫谈 余晟](https://github.com/pandoc-ebook/chitchat-on-translation/releases)

## QQ群
欢迎加入QQ群交流

![](medias/qq.png)