
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
bookgen.sh init # 初始化工作环境
```

目录结构说明
```
.
├── book                                    # 书籍模板，暂未用到
│   ├── book-template.latex
│   └── pm-template.latex
├── bookgen.sh                              # 转换脚本
├── build                                   # 电子书构建目录
├── config.default                          # pandoc默认转换配置
├── html5                                   # html5电子书模板
├── README.md
├── resume                                  # 简历模板
├── src                                     # Markdown源码目录
│   └── images                              # 源码涉及插图目录
└── zh-ctex                                 # ctexbook模板目录
    ├── Pictures                            # 模板引用的图片资源
```

## 使用规范
### 源码命名规范
脚本中使用`ls src/*.md`列出所有的Markdown源码，要保证顺序正确，才能生成正确的LaTeX源码。
因此，要求Markdown源码文件命名能够被ls以正确的顺序列出。例如，有少于十个的Markdown文件，
可以使用0~9为前缀：
```
$ tree src/
src/
├── 0-title.md
├── 1-intro.md
├── 2-pandoc-markdown.md
├── 3-template.md
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
homepage: https://github.com/annProg/pandoc-template
header-includes:
  - \usepackage{cleveref}
# preface用于生成前言
preface: '\LaTeX\ 可以排版格式精美的书籍，但是学习成本较高，使用不便；
 换行请在开头留出一个空格'
---
```

其中title，author，date 变量也可以通过以下形式来定义：
```
% title
% author(s) (separated by semicolons)
% date
```

查看模板文件，可以获取所有变量（形如`$var$`)。也可以通过修改模板来添加自定义的变量。

## 转换命令
pandoc-template目录加入环境变量后可以直接调用`bookgen.sh`：
```
bookgen.sh init  # 初始化工作环境
bookgen.sh pdf   # 生成pdf电子书
bookgen.sh html  # 生成html电子书
bookgen.sh pdf d # 调试模式，只使用一个代码高亮风格， html电子书也支持调试模式
```

