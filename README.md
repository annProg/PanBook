# 盘书 - Pandoc Template
<p align="center">
  <img height="120" src="src/images/logo.png">
</p>

## 简介
此项目基于`Pandoc`和`LaTeX`，提供了一些开箱即用的书籍，论文，幻灯片及简历模板，以及一些`lua filter`扩展。用来更方便的使用`Pandoc`将`Markdown`转换为`PDF`或`epub`格式。

查看电子书效果：

- [ElegantBook模板-pc](https://api.annhe.net/PanBook/PanBook-latex-elegantbook-pc.pdf)
- [ElegantNote模板](https://api.annhe.net/PanBook/PanBook-latex-elegantnote-pc.pdf)
- [Ctex模板-pc](https://api.annhe.net/PanBook/PanBook-latex-ctexbook-pc.pdf)
- [Ctexart模板-pc](https://api.annhe.net/PanBook/PanBook-latex-ctexart-pc.pdf)
- [Ctex模板-mobile](https://api.annhe.net/PanBook/PanBook-latex-ctexbook-mobile.pdf)
- [Epub模板](https://api.annhe.net/PanBook/PanBook.epub)

### 简历/ 幻灯片/ 论文

原本只是想盘书的，后来发现`beamer`，论文，简历都是一样的套路，于是就都盘一盘吧。
- [幻灯片（beamer）](./demo/beamer/)
- [论文（ElegantPaper）](https://api.annhe.net/PanBook/PanBook-latex-elegantpaper-pc.pdf)
- [简历](./demo/cv/)

## 快速开始
以`Windows 10`为例，演示如何使用。

### 安装软件

- 下载[msys2](https://www.msys2.org/) 并安装
- 下载[texlive](http://mirror.ctan.org/systems/texlive/Images/) 2018或以上版本并安装
- 下载[Pandoc](https://pandoc.org/installing.html) 2.7.1或以上版本并安装
- 下载[pandoc-crossref](https://github.com/lierdakil/pandoc-crossref/releases) 对应版本并安装到`path`目录下（建议和`Pandoc`放同一目录，即`/c/Users/myname/AppData/Local/Pandoc`）

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
$ panbook -h
  eBook maker base pandoc

        Usage: panbook <command> [OPTIONS]

  Available module command:
        book        make ebook
        thesis      make thesis
        slide       make slide
        cv          make curriculum vitae
  Available command:
        mod         modules help
        help        print help info
        clean       clean build dir
        saveimg     save image url to local
        eps         convert gif to eps
        ext         extensions help
  Available OPTIONS(you can also use pandoc long option):
        --style     specify a style
        --crs       specify pandoc-crossref settings file(default pandoc-crossref-settings.yaml)
        --src       specify src dir name(default src)
        --imgdir    specify image dir name(default src/images)
        --part      only compile specified markdown file
        --trace     trace mode
        -V key:val  same with pandoc -V option
        -M key:val  same with pandoc -M option
        -G key:val  change panbook global variable
        --key=val   use original pandoc long option like this
        --key       use original pandoc long boolean option like this
        -d --debug  debug mode
        -h --help   function help(if exists)
        -l --list   function list(if exists)
```


之后在`src`目录进行写作, `src/images`目录存放图片

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

![](src/images/qq.png)