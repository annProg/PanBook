# pandoc模板

## ctex书籍模板
```
git clone https://github.com/annProg/pandoc-template
将pandoc-template加入环境变量
```

建立工作目录
```
mkdir workdir
cd workdir
bookgen.sh init
```

之后在`src`目录进行写作, `src/images`目录存放图片

### 注意以下几点
- 在Windows上使用pandoc需要将markdown文件保存为UTF-8格式
- 按章节拆分的多个markdown文件，开头需要空一行，否则pandoc可能不能正确识别标题

## html5模板

## slides模板
