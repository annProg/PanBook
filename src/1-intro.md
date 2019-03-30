
# 使用说明

## 安装步骤
首先克隆代码库
```
git clone https://github.com/annProg/pandoc-template
```
然后将pandoc-template目录加入环境变量

建立工作目录
```
mkdir workdir
cd workdir
panbook init # 初始化工作环境
```

目录结构说明
```
.
├── book                                    # 书籍模板，暂未用到
│   ├── book-template.latex
│   └── pm-template.latex
├── panbook                                 # 转换脚本
├── build                                   # 电子书构建目录
├── config.default                          # pandoc默认转换配置
├── html5                                   # html5电子书模板
├── README.md
├── resume                                  # 简历模板
├── src                                     # Markdown源码目录
│   └── images                              # 源码涉及插图目录
│   └── metadata.yaml                       # 书籍元数据文件
└── zh-ctex                                 # ctexbook模板目录
    ├── Pictures                            # 模板引用的图片资源
```

## 使用规范
### 源码命名规范
脚本中使用`ls src/*.md`列出所有的Markdown源码，要保证顺序正确，才能生成正确的LaTeX源码。
因此，要求Markdown源码文件命名能够被ls以正确的顺序列出。其中, `frontmatter.md`和`backmatter.md`用于
前言和后记，文件名固定不可更改。例如，有少于十个的Markdown文件，可以像下面这样组织源码：
```
$ tree src/
src/
├── 0-title.md
├── 1-intro.md
├── 2-pandoc-markdown.md
├── 3-template.md
├── frontmatter.md
├── backmatter.md
├── metadata.yaml
└── images
```

如果Markdown文件数多于10个，则需要在前缀为个位数的前面补0，与最大前缀数字位数保持一致，例如
最后一个Markdown文件为`99-markdown.md`，那么个位数应形如 `01-first.md`。

### 编码规范
Markdown源码文件需要使用UTF-8编码。以Notepad++为例，依次选择**格式，以UTF-8无BOM格式编码**
即可正确设置编码。

### 注意事项{#title:note}
Pandoc扩展的Markdown语法要求在标题前留出一个空行，因此按章节拆分的多个Markdown文件，开头需要
空一行，否则pandoc不能正确识别标题。

## 模板变量说明
可以使用[Yaml语言](http://www.ruanyifeng.com/blog/2016/07/yaml.html) 定义模板中的变量，建议第一个
Markdown文件专门用来定义变量，如代码\ref{code:template-var}所示。
```{#code:template-var}
---
title: 用Markdown+Pandoc+XeLaTeX写作
author:          # 作者（数组）
  - An He
date: \today     # 日期
copyright: true  # 是否生成版权页
lof: true        # 是否生成插图列表页
lot: true        # 是否生成表格列表页
graphics: true   # 是否使用graphicx
homepage: https://github.com/annProg/pandoc-template
header-includes:
  - \usepackage{cleveref}
...
```

其中title，author，date 变量也可以通过以下形式来定义：
```
% title
% author(s) (separated by semicolons)
% date
```

查看模板文件，可以获取所有变量（形如`$var$`)。也可以通过修改模板来添加自定义的变量。

## 前言后记
在`frontmatter.md`中添加前言，`backmatter.md`中添加后记。对于`epub`电子书，可以给标题添加`epub type`属性，见代码\ref{code:epub-type-attr}。

```{#code:epub-type-attr}
# My chapter {epub:type=prologue}
```

支持如下属性如表\ref{table:epub-type-attr}：

Attr        Type
-----       ---------
prologue	frontmatter
abstract	frontmatter
acknowledgments	frontmatter
copyright-page	frontmatter
dedication	frontmatter
foreword	frontmatter
halftitle,	frontmatter
introduction	frontmatter
preface	frontmatter
seriespage	frontmatter
titlepage	frontmatter
afterword	backmatter
appendix	backmatter
colophon	backmatter
conclusion	backmatter
epigraph	backmatter

Table: epub:type of first section	epub:type of body \label{table:epub-type-attr}

# 
## 转换命令
pandoc-template目录加入环境变量后可以直接调用`panbook`：
```
panbook init  # 初始化工作环境
panbook pdf   # 生成pdf电子书
panbook html  # 生成html电子书
panbook pdf d # 调试模式，只使用一个代码高亮风格， html电子书也支持调试模式
```

