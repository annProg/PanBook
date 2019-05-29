
# PanBook手册
`PanBook`是基于`Pandoc`和`LaTeX`开发的一个工具，提供了一些开箱即用的书籍，论文，幻灯片及简历模板，以及一些`lua filter`扩展。用来更方便的使用`Pandoc`将`Markdown`转换为`PDF`或`epub`格式。

## 快速开始

以`Windows 10`为例，演示如何使用。

### 安装软件

- 下载[msys2](https://www.msys2.org/) 并安装
- 下载[texlive](http://mirror.ctan.org/systems/texlive/Images/) 2018或以上版本并安装
- 下载[Pandoc](https://pandoc.org/installing.html) 2.7.1或以上版本并安装
- 下载[pandoc-crossref](https://github.com/lierdakil/pandoc-crossref/releases) 对应版本并安装到`path`目录下（建议和`Pandoc`放同一目录，\
  即`/c/Users/myname/AppData/Local/Pandoc`）

#### 下载PanBook

打开`msys2`，假设工作目录为`/d/dev`，执行[@lst:gitclone]。

```{#lst:gitclone .bash caption="下载PanBook"}
$ cd /d/dev
$ git clone https://github.com/annProg/PanBook
```

#### 设置环境变量
需要将本项目，`texlive`及`Pandoc`加入环境变量，如[@lst:setpath]所示。

```{#lst:setpath .bash caption="设置环境变量"}
$ tail -n 1 ~/.bashrc
export PATH=$PATH:/d/texlive/2018/bin/win32:/d/dev/PanBook:/c/Users/myname/AppData/Local/Pandoc
```


### 开始使用
假设目录为 `/d/dev/mybook`，使用方法见[@lst:panbookhelp]。

```{#lst:panbookhelp .bash caption="Panbook Help"}
$ cd /d/dev/mybook
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
  Available OPTIONS:
        --style     specify a style
        --crs       specify pandoc-crossref settings file(default pandoc-crossref-settings.yaml)
        --src       specify src dir name(default src)
        --imgdir    specify image dir name(default src/images)
        -V key:val  same with pandoc -V option
        -M key:val  same with pandoc -M option
        -G key:val  change panbook global variable
        --key=val   use original pandoc long option like this
        --key       use original pandoc long boolean option like this
        -d --debug  debug mode
        -h --help   function help(if exists)
        -l --list   function list(if exists)
```

以书籍为例，执行 `panbook book`，会自动生成书籍模板，接着编辑`src`目录下的`Markdown`源码即可。

## 目录规范{#sec:standarddir}

标准目录结构如[@lst:structure]所示。

```{#lst:structure .bash caption="目录规范"}
.
├── templates                               # 自定义模板
├── styles                                  # 自定义风格
├── extensions                              # 自定义扩展
├── fonts                                   # 自定义字体
├── build                                   # 电子书构建目录
├── src                                     # Markdown源码目录
│   └── images                              # 源码涉及插图目录
│   └── metadata.yaml                       # 书籍元数据文件
│   └── frontmatter.md                      # 书籍元数据文件
│   └── backmatter.md                       # 书籍元数据文件
│   └── compatible.conf                     # 兼容性配置文件
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

为了能编译不满足[@sec:standarddir]定义规范的源码，提供以下方式。

- 通过参数`--src`自定义书籍源码目录（默认为`src`）
- 通过参数`--imgdir`自定义书籍源码目录（默认为`src/images`）
- 如果源码不满足正确章节顺序列出，或者前言后记不规范，可通过兼容性配置文件（`src/compatible.conf`）配置各源码的用途

兼容性配置文件示例见[@lst:compatible]。

```{#lst:compatible caption="兼容性配置"}
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

## 注意事项{#sec:note}

- Markdown源码文件需要使用UTF-8编码。以Notepad++为例，依次选择**格式，以UTF-8无BOM格式编码**即可正确设置编码。
- Pandoc扩展的Markdown语法要求在标题前留出一个空行，因此按章节拆分的多个Markdown文件，开头需要空一行，否则pandoc不能正确识别标题。
- 请勿将正文文件命名为 `*frontmatter.md`或者`*backmatter.md`，这2个文件有特殊用途。

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

支持如下属性见[@tbl:epub-type-attr]。

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
: epub标题支持的属性 {#tbl:epub-type-attr}

## 写作工具
推荐使用[Visual Studio Code](https://code.visualstudio.com/)。

推荐插件见[@tbl:vscodeplugin]。

--------------------------------------------------------
插件                               功能
--------------------------      ------------------------
Markdown Preview                  Markdown实时预览
LaTeX language support            LaTeX语言高亮
All Autocomplete                  自动补全（支持单词补全)
---------------------------------------------------------
: 推荐插件 {#tbl:vscodeplugin}