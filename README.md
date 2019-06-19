<p align="center">
  <img height="220" src="src/images/logo.png">
</p>

[![Build Status](https://ci.annhe.net/api/badges/annProg/PanBook/status.svg)](https://ci.annhe.net/annProg/PanBook)

## 简介
`PanBook`基于`Pandoc`的`lua filter`功能，适配各种书籍，论文，幻灯片及简历的`LaTeX`或`EPUB`模板。
目标是使用`Pandoc's Markdown`作为写作语言，实现**一次编写 多次生成**。

预览

| Book | Thesis | Slide | CV |
| --- | --- | --- | --- |
|[ElegantBook](https://api.annhe.net/PanBook/PanBook-book-elegantbook-pc.pdf) || [metropolis](https://api.annhe.net/PanBook/beamer-beamer-metropolis.pdf) |[moderncv-classic](https://api.annhe.net/PanBook/cv-cv-moderncv-classic-blue.pdf)|
|| |[solarized](https://api.annhe.net/PanBook/beamer-beamer-solarized.pdf)|[resume](https://api.annhe.net/PanBook/cv-cv-resume.pdf)|
|[CTeXBook](https://api.annhe.net/PanBook/PanBook-book-ctexbook-pc.pdf) | | [material](https://api.annhe.net/PanBook/beamer-beamer-material.pdf)| [TMR](https://api.annhe.net/PanBook/cv-cv-tmr.pdf)|
|[CTeXBook-mobile](https://api.annhe.net/PanBook/PanBook-book-ctexbook-mobile.pdf)| | [Execushares](https://api.annhe.net/PanBook/beamer-beamer-Execushares.pdf)|[moderncv-fancy](https://api.annhe.net/PanBook/cv-cv-moderncv-fancy-blue.pdf) |
|[Epub](https://api.annhe.net/PanBook/PanBook.epub)  | |[more](https://github.com/annProg/PanBook/tree/master/demo/beamer) |[more](https://github.com/annProg/PanBook/tree/master/demo/cv) |

## 快速开始
以`Windows 10`为例，演示如何使用。首先安装以下依赖软件

- [msys2](https://www.msys2.org/)
- [texlive](http://mirror.ctan.org/systems/texlive/Images/) 2018 或以上版本
- [Pandoc](https://pandoc.org/installing.html) 2.7.1 或以上版本
- [pandoc-crossref](https://github.com/lierdakil/pandoc-crossref/releases) 对应版本并安装到`path`目录下（建议和`Pandoc`放同一目录，即`/c/Users/yourname/AppData/Local/Pandoc`）

然后下载本项目，打开`msys2`，假设工作目录为`/d/dev`

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

```bash
# 新建项目目录
$ mkdir /d/dev/mybook
$ cd /d/dev/mybook
# 生成示例 book 文档，编译结果在 build 目录
$ panbook book
# 查看帮助
$ panbook -h
```
然后编写 `src` 目录下的 `Markdown` 源文件。图片放在 `src/images` 下。

## 贡献指南
欢迎提交`Issue`和`Pull Request`。`extensions`, `styles`开发流程请参考 [PanBook 手册](https://api.annhe.net/PanBook/PanBook-book-elegantbook-pc.pdf) 第七章。

## 演示

使用本项目编译的书籍（欢迎加入此列表）

- [PanBook 手册](https://api.annhe.net/PanBook/PanBook-book-elegantbook-pc.pdf)
- [自学是门手艺 李笑来](https://github.com/pandoc-ebook/the-craft-of-selfteaching)
- [TOEFL iBT 高分作文 李笑来](https://github.com/pandoc-ebook/twe185/releases)

## 致谢
`PanBook`适配了一些开源`LaTeX`模板，列表如下：

| Book | Thesis | Slide | CV |
| -- | --- | --- | --- |
| [ElegantBook](https://github.com/ElegantLaTeX/ElegantBook) | | | [moderncv](https://github.com/xdanaux/moderncv) |
| | |[more](https://github.com/annProg/PanBook/tree/master/styles/slide) | [resume](https://github.com/billryan/resume) |
| | | | [tmr](https://github.com/TheMartianLife/TheMartianResume) |

## QQ 群
欢迎加入 QQ 群交流

![](src/images/qq.png)

test