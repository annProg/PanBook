
# 使用方法
本章简要介绍 panbook^[https://github.com/annProg/PanBook] 的安装，基本使用方法及 Pandoc's Markdown 语法。建议读者阅读 PanBook 使用手册^[https://panbook.annhe.net/pub/PanBook-book-ctexbook-pc.pdf] [@panbook] 获取更详细的内容。

## 快速入门
以 Windows 10 为例，演示如何使用。首先需要安装依赖软件。

- 安装 [msys2](https://www.msys2.org/) （ Linux 及 OS X 请忽略此步骤）
- 安装 [texlive](http://mirror.ctan.org/systems/texlive/Images/) 2018 或以上版本
- 安装 [Pandoc](https://pandoc.org/installing.html) 2.7.3 或以上版本
- 下载 [pandoc-crossref](https://github.com/lierdakil/pandoc-crossref/releases) 对应版本安装到 path 目录下（建议和 Pandoc 放同一目录）

然后下载 PanBook。打开终端（ msys2 ），假设工作目录为 /d/dev ，克隆代码并设置环境变量：

```bash
$ cd /d/dev
$ git clone https://github.com/annProg/PanBook
# 将 PanBook，TeXLive 及 Pandoc 加入环境变量
$ tail -n 1 ~/.bashrc
export PATH=$PATH:/d/texlive/2018/bin/win32:/d/dev/PanBook:/c/Users/myname/AppData/Local/Pandoc
```

完成环境变量设置之后，在任意空目录下执行 `panbook thesis`，会自动初始化写作环境，生成示例源码。然后在 src 目录下开始写作。目录规范见 [@lst:panbookdirs]。

```{#lst:panbookdirs .bash caption="PanBook 目录规范"}
.
|-- extensions              # 自定义扩展
|-- fonts                   # 自定义字体
|-- src                     # Markdown 源码目录
|   |-- images              # 插图目录
|   |-- metadata.yaml       # 书籍元数据文件
|   |-- frontmatter.md      # 前言文件
|   |-- backmatter.md       # 后记文件
|   |-- 100-chapter1.md     # 正文，命名须保证能按正确章节顺序列出
|   `-- 200-chapter2.md
|-- styles                   # 自定义风格
|-- templates                # 自定义模板 
`-- build                    # 电子书构建目录
```

## 指定风格（style）
风格（style），也可以理解为模板（为了和 pandoc 模板区分），是预定义的文档样式。通过 `--style` 参数指定，缺省时，会使用默认风格 (thesis)，通过命令 `panbook thesis -l` 查看模块支持的风格列表：

```bash
$ panbook thesis -l
thesis
```

支持和计划支持的学校论文模板如 [@tbl:thesis_styles] 所示。

学校 | style 名称 |状态
:---|:--|:-----
demo|thesis|完成
湖南大学|hnu| WIP
清华大学|thu| WIP
上海交通大学|sjtu| WIP
南京大学|nju| WIP
山东大学|sdu| WIP
中国科学院大学|ucas|WIP
电子科技大学|uestc| WIP
北京航空航天大学|buaa| WIP

: 支持的论文模板 {#tbl:thesis_styles}

## 调试模式
加 `-d` 选项，会输出详细的 `latexmk` 编译过程，加 `--trace` 选项，可以输出更多的调试信息。

## 注意事项 {#sec:note}

- Markdown 源码文件需要使用 UTF-8 编码
- Pandoc 扩展的 Markdown 语法要求在标题前留出一个空行，因此按章节拆分的多个 Markdown 文件，开头需要空一行，否则 pandoc 不能正确识别标题
- 请勿将正文文件命名为 *frontmatter.md 或者 *backmatter.md ，这 2 个文件有特殊用途

## 论文元数据
在 src/metadata.yaml 中使用 Yaml 语言^[http://www.ruanyifeng.com/blog/2016/07/yaml.html] 定义书籍的数据及可用的模板变量，示例见 [@lst:metayaml]。
```{#lst:metayaml .yaml caption="Metadata"}
---
title: 基于 Markdown 的论文写作方法
etitle: A Thesis Writing Method Based On Markdown
author:          # 作者（数组）
  - 作者
xuehao: 201907131122
college: 计算机学院
supervisor: \LaTeX  教授
date: \today     # 日期
lof: false        # 是否生成插图列表页
lot: false        # 是否生成表格列表页
# 不引用，但是显示在参考文献列表里。通配符 @* 表示全部在列表里显示
nocite: |
  @pandocManual
...
```

查看模板文件，可以获取模板支持的所有变量（形如`$var$`)。也可以通过修改模板来添加自定义的变量。