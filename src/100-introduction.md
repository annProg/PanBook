
# PanBook 手册

 PanBook 基于 Pandoc 的 lua filter 功能，适配各种书籍，论文，幻灯片及简历的 LaTeX 或 EPUB 模板。
目标是使用 Pandoc's Markdown 作为写作语言，实现**一次编写，多次生成**。

## 快速开始

以 Windows 10 为例，演示如何使用。首先需要安装依赖软件。

- 安装 [msys2](https://www.msys2.org/) （ Linux 及 OS X 请忽略此步骤）
- 安装 [texlive](http://mirror.ctan.org/systems/texlive/Images/) 2018 或以上版本
- 安装 [Pandoc](https://pandoc.org/installing.html) 2.7.3 或以上版本
- 下载 [pandoc-crossref](https://github.com/lierdakil/pandoc-crossref/releases) 对应版本安装到 path 目录下（建议和 Pandoc 放同一目录）

然后下载 PanBook。打开终端（ msys2 ），假设工作目录为 /d/dev ，执行：

```bash
$ cd /d/dev
$ git clone https://github.com/annProg/PanBook
```

完成软件安装之后，需要设置环境变量，将 PanBook，TeXLive 及 Pandoc 加入环境变量：

```bash
$ tail -n 1 ~/.bashrc
export PATH=$PATH:/d/texlive/2018/bin/win32:/d/dev/PanBook:/c/Users/myname/AppData/Local/Pandoc
```

完成环境变量设置之后，在任意空目录下执行 panbook `<command>`，会自动初始化写作环境，生成示例源码。然后在 src 目录下开始写作。`<command>`可以是 book ， thesis ， slide ， cv 。详细帮助信息执行 panbook -h 查看。目录规范见 [@lst:panbookdirs]。

```{#lst:panbookdirs .bash caption="目录规范"}
.
├── templates                               # 自定义模板
├── styles                                  # 自定义风格
├── extensions                              # 自定义扩展
├── fonts                                   # 自定义字体
├── build                                   # 电子书构建目录
├── src                                     # Markdown 源码目录
│   └── images                              # 源码涉及插图目录
│   └── metadata.yaml                       # 书籍元数据文件
│   └── frontmatter.md                      # 前言文件
│   └── backmatter.md                       # 后记文件
│   └── 100-chapter1.md                     # 正文，命名须保证能按正确章节顺序列出
│   └── 200-chapter2.md            
```

#### 注意事项 {#sec:note}

- Markdown 源码文件需要使用 UTF-8 编码
- Pandoc 扩展的 Markdown 语法要求在标题前留出一个空行，因此按章节拆分的多个 Markdown 文件，开头需要空一行，否则 pandoc 不能正确识别标题
- 请勿将正文文件命名为 *frontmatter.md 或者 *backmatter.md ，这 2 个文件有特殊用途

## 书籍元数据
在 src/metadata.yaml 中使用 [Yaml 语言](http://www.ruanyifeng.com/blog/2016/07/yaml.html) 定义书籍的数据及可用的模板变量，示例见 [@lst:metayaml]。
```{#lst:metayaml .yaml caption="Metadata"}
---
title: PanBook 使用手册
subtitle: 用 Pandoc 和 Markdown 写作
author:          # 作者（数组）
  - An He
homepage: https://github.com/annProg/PanBook
header-includes:
  - \usepackage{cleveref}
  - \usepackage{float}
...
```

::: {.help caption="模板变量"}
查看模板文件，可以获取模板支持的所有变量（形如`$var$`)。也可以通过修改模板来添加自定义的变量。
:::

更多信息请参考 [@sec:yaml_metadata_block]。

## 写作工具
推荐使用 [Visual Studio Code](https://code.visualstudio.com/)。一些有用的插件见 [@tbl:vscodeplugin]。

插件                            功能
--------------------------      ------------------------
Markdown Preview                Markdown 实时预览
\LaTeX\ language support        \LaTeX 语言高亮
All Autocomplete                自动补全（支持单词补全）
Pangu-Markdown                  中英文自动加空格

: 推荐插件 {#tbl:vscodeplugin}

使用 [@lst:vscodeMsys] 配置将终端改为 msys2 的 bash 。

```{#lst:vscodeMsys .json caption="VS Code 使用 msys2"}
{
    "terminal.integrated.shell.windows": "D:\\msys64\\usr\\bin\\bash.exe",
    "terminal.integrated.shellArgs.windows": ["-l"],
    "terminal.integrated.env.windows": {
        "CHERE_INVOKING": "1",
        "MSYSTEM": "MINGW64",
	},
	"git.postCommitCommand": "push",
    "git.path": "D:\\msys64\\git-vscode.bat",
    "editor.insertSpaces": false,
	"editor.detectIndentation": false,
}  
```

::: {.help caption="使用部分编译调试代码"}
通过配置 VS Code Tasks，使用 PanBook 部分编译参数 `--part` ，实现快捷键（ ctrl + shift + b ）编译当前 Markdown 源文件。
:::

使用用户代码片段，可以定义一些快捷输入，例如以下代码定义了快速输入 columns 环境，代码块以及 Div 环境。`$`符号表示需要用户输入的内容，可使用 TAB 键跳转：

```.json
	"Columns": {
		"prefix": "col",
		"body": [
			"::::: {.columns}",
			"::: {.column}",
			"$1",
			":::",
			"::: {.column}",
			"$2",
			":::",
			":::::"
		],
		"description": "Columns"
	},
	"Code": {
		"prefix": "cod",
		"body": [
			"```{#lst:$1 .$2 caption=\"$3\"}",
			"$4",
			"```"
		],
		"description": "Code"
	},
	"Environment": {
		"prefix": "env",
		"body": [
			"::: {.$1}",
			"$2",
			":::"
		],
		"description": "fenced Div environment"
	}
```

::: {.help caption="VS Code 使用技巧"}
- 通过 文件 -> 首选项 -> 用户代码片段，选择 Markdown ，然后编辑 markdown.json 来定义代码片段
- snippetSuggestions 设置为 top，可以优先显示代码片段
- tabCompletion 设置为 on 使用 TAB 自动补全
- pangu.auto_format_on_save 设置为 on 在保存时自动给中英文加空格
:::