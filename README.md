# pandoc模板

## 快速开始
以`Windows 10`为例，演示如何使用。

### 安装软件

- 下载[msys2](https://www.msys2.org/) 并安装
- 下载[texlive](http://mirror.ctan.org/systems/texlive/Images/) 2018或以上版本并安装
- 下载[pandoc](https://pandoc.org/installing.html) 2.7.1或以上版本并安装

### 下载本项目

打开`msys2`，假设工作目录为`/d/dev`

```
$ cd /d/dev
$ git clone https://github.com/annProg/pandoc-template
```

### 设置环境变量
需要将本项目，`texlive`及`pandoc`加入环境变量，编辑`~/.bashrc`，加入以下内容

```
$ tail -n 1 ~/.bashrc
export PATH=$PATH:/d/texlive/2018/bin/win32:/d/dev/pandoc-template:/c/Users/myname/AppData/Local/Pandoc
```

### 开始使用
假设电子书目录为 `/d/dev/mybook`

```
$ cd /d/dev/mybook
$ panbook init                  # 初始化工作环境
$ panbook epub                  # 生成epub电子书
$ panbook pdf                   # 生成pdf电子书
$ panbook html                  # 生成html电子书
$ panbook epub d                # 加d选项意为debug模式，仅生成一种代码高亮样式(epub和html格式有效)
```

之后在`src`目录进行写作, `src/images`目录存放图片

### 可用环境变量

```
TPL         指定模板           elegantbook|ctex|epub|html5
DEVICE      指定设备类型       mobile|kindle|pc  需要模板支持
ELEGANT     elegantbook专用设置elegantbook选项，可设置语言模板(cn|en)，颜色主题(green|blue|cyan|plain)，章标题显示风格(hang|display)，比如  ELEGANT=cn,blue  即使用中文，蓝色主题编译
CSS          指定epub自定义样式文件名，css应放置在对应模板目录下的css文件夹下
```

## 注意事项
- 在Windows上使用pandoc需要将markdown文件保存为UTF-8格式
- 按章节拆分的多个markdown文件，开头需要空一行，否则pandoc可能不能正确识别标题

## 模板说明
本项目使用了一些开源模板，列表如下

- [ElegantBook](https://github.com/ElegantLaTeX/ElegantBook)

## 演示

使用本项目编译的书籍

- [人人都能用英语 李笑来](https://github.com/annProg/everyone-can-use-english)
- [把时间当作朋友 李笑来](https://github.com/annProg/time-as-a-friend/releases)
- [TOEFL iBT高分作文 李笑来](https://github.com/annProg/twe185/releases)
- [翻译漫谈 余晟](https://github.com/annProg/chitchat-on-translation/releases)