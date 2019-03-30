# pandoc模板

默认参数基于`pandoc 2.7.1`版本

## ctex书籍模板
```
git clone https://github.com/annProg/pandoc-template
将pandoc-template加入环境变量
```

建立工作目录
```
mkdir workdir
cd workdir
panbook init
panbook epub # 生成epub电子书
panbook pdf # 生成pdf电子书
panbook html # 生成html电子书
panbook pdf d # 生成pdf电子书(debug模式，仅生成一种样式)
```

之后在`src`目录进行写作, `src/images`目录存放图片

### 注意以下几点
- 在Windows上使用pandoc需要将markdown文件保存为UTF-8格式
- 按章节拆分的多个markdown文件，开头需要空一行，否则pandoc可能不能正确识别标题

## html5模板

## slides模板

## 默认选项说明

### --number-sections   
Number section headings in LaTeX, ConTeXt, HTML, or EPUB output. By default, sections are not numbered. Sections with class unnumbered will never be numbered, even if --number-sections is specified.
