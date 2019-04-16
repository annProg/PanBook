
# 使用说明
本项目定义了一种`Markdown`源码组织规范，提供一个脚本`panbook`及数个`LaTeX`及`epub`模板，用来更方便的使用`Pandoc`将`Markdown`转换为`PDF`及`epub`格式电子书。

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
假设电子书目录为 `/d/dev/mybook`，使用方法见代码\ref{panbookhelp}。

```{#panbookhelp .bash caption="Panbook Help"}
$ cd /d/dev/mybook
$ panbook help
  eBook maker base pandoc

        Usage: panbook <functions> [OPTIONS]

  Available functions:
        init        initialize work environment
        pdf         make pdf ebook
        html        make html ebook
        epub        make epub ebook
        beamer      make beamer
        help        print help info
        saveimg     save image url to local
        eps         convert gif to eps
  Available OPTIONS:
        --tpl       specify template for pandoc
        --class     specify documentclass for latex
        --theme     specify beamer theme
        --css       specify epub css
        --src       specify src dir name(default src)
        --imgdir    specify image dir name(default src/images)
        -V key=val  same with pandoc -V option
        -E key=val  set variable for template or beamer theme
        -d --debug  debug mode
        -h --help   function help(if exists)
```


## 目录规范{#standarddir}

标准目录结构如代码\ref{code:structure}所示。

```{#code:structure .bash caption="目录规范"}
.
├── templates                               # 自定义模板（可选）
├── fonts                                   # 自定义字体（可选）
├── build                                   # 电子书构建目录
├── config                                  # 自定义转换选项（可选）
├── src                                     # Markdown源码目录
│   └── images                              # 源码涉及插图目录
│   └── metadata.yaml                       # 书籍元数据文件（必须）
│   └── frontmatter.md                      # 书籍元数据文件（内容可为空，必须存在）
│   └── backmatter.md                       # 书籍元数据文件（内容可为空，必须存在）
│   └── compatible.conf                     # 兼容性配置文件（可选）
│   └── 1.0-chapter1.md                     # 正文，命名须保证能按正确章节顺序列出
│   └── 1.1-chapter1-section2.md            
│   └── 2.0-chapter2.md                     
```

即有如下规范：

- 书籍源码在`src`目录
- 图片在`src/images`目录
- 前言部分须写在`src/frontmatter.md`中
- 后记部分须写在`src/backmatter.md`中
- 需要使用`src/metadata.yaml`提供书籍元数据

## 兼容性

为了能编译不满足以上规范\ref{standarddir}的源码，提供以下方式。

- 通过环境变量`SRC`自定义书籍源码目录（默认为`src`）
- 通过环境变量`IMGDIR`自定义书籍源码目录（默认为`src/images`）
- 如果源码不满足正确章节顺序列出，或者前言后记不规范，可通过兼容性配置文件（`$SRC/compatible.conf`）配置各源码的用途

### 兼容性配置文件示例

```
# 第一列源码文件名，第二列源码类型，类型包含 frontmatter(前言），backmatter（后记），exclude（排除的文件），
# body（正文）。各类型中要求按正确顺序排列源码文件
preface.md frontmatter
foreword.md frontmatter
appendix.md backmatter
back.md     backmatter
README.md   exclude
introduction.md body
how-to-use.md   body
```

## 注意事项{#title:note}

- Markdown源码文件需要使用UTF-8编码。以Notepad++为例，依次选择**格式，以UTF-8无BOM格式编码**即可正确设置编码。
- Pandoc扩展的Markdown语法要求在标题前留出一个空行，因此按章节拆分的多个Markdown文件，开头需要空一行，否则pandoc不能正确识别标题。

## 书籍元数据
在`src/metadata.yaml`中使用[Yaml语言](http://www.ruanyifeng.com/blog/2016/07/yaml.html) 定义书籍的数据及可用的模板变量，如代码\ref{code:template-var}所示。
```{#code:template-var .yaml caption="书籍元数据"}
---
title: 用Markdown+Pandoc写作
author:          # 作者（数组）
  - An He
date: \today     # 日期
copyright: true  # 是否生成版权页
lof: true        # 是否生成插图列表页
lot: true        # 是否生成表格列表页
homepage: https://github.com/annProg/PanBook
identifier:                      # epub用
  - scheme: DOI
    text: doi:10.234234.234/33
publisher: PanBook       # epub用
rights: © 2017 An He, CC BY-NC   # epub用
cover-image: images/cover.jpg    # epub用
header-includes:
  - \usepackage{cleveref}
  - \usepackage{float}
...
```

查看模板文件，可以获取所有变量（形如`$var$`)。也可以通过修改模板来添加自定义的变量。

## 前言后记
在`frontmatter.md`中添加前言，`backmatter.md`中添加后记。对于`epub`电子书，可以给标题添加`epub type`属性，见代码\ref{code:epub-type-attr}，其中`.unnumbered`属性可以避免前言后记被编号。

```{#code:epub-type-attr .markdown caption="epub标题属性"}
# My chapter {epub:type=prologue .unnumbered}
```

支持如下属性如表\ref{table:epub-type-attr}：

--------------------------------------------------
Attr                                    Type
----------------------------------     -----------
prologue,abstract,acknowledgments      frontmatter	         
copyright-page,dedication,foreword
halftitle,introduction	     
preface,seriespage,titlepage	         

afterword,appendix,colophon	           backmatter
conclusion,epigraph
----------------------------------------------------
: epub:type of first section	epub:type of body\label{table:epub-type-attr}
