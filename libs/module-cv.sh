function cvMeta() {
	[ ! -d $WORKDIR ] && mkdir $WORKDIR
	[ ! -d $IMGDIR ] && mkdir $IMGDIR

	cvFile=$WORKDIR/cv.md
	photoFile=$IMGDIR/photo.png
	bibFile=$WORKDIR/bibliography.bib
	[ ! -f $photoFile ] && cp $SCRIPTDIR/medias/photo.png $photoFile
	[ ! -f $cvFile ] && cat > $cvFile <<EOF
---
name: 姓\ 名        # use backslash to escape space
title: \LaTeX 排版工程师
homepage: baidu.com
showdate: true
address: 本星系群银河系太阳系地球 - 中国北京
quote: \LaTeX 写简历漂不漂亮呀
photo: images/photo.png
extrainfo: 不需要的项目删除即可
mobile: 13000001111
github: Github
weibo: Weibo
qq: 123456789
wechat: WeChat
skype: Skype
twitter: Twitter
linkedin: LinkedIn
onlinecv: http://url.online.cv/cv.pdf
nocite: |
  @*
...


# \faGraduationCap 教育经历

### 大学 {date="2019.5 - 2023.5" title="计算机科学与技术" city="北京" score="成绩不好"}

- 一些说明

# \faUsers 工作经验

### 公司 {date="2026.7 - 2027.7" title="软件工程师" city="北京"}

- 一些说明

::: {#refs}
# \faBook 发表作品
:::

# \faList 列表语法
	  
## 普通列表

- 简单列表直接使用Markdown无序列表格式，不支持多级嵌套

## 双栏列表

- [双栏列表]{.double} [第二栏]{.double}

## 带类别列表
- [证书]{.cat}\LaTeX 排版工程师

## 带评论列表

- [英语]{.cat} 不会读不会写 [四级是啥]{.comment}

## 带类别的双栏列表

- [Java,PHP,Lisp]{.double cat="编程"} [Markdown,LaTeX,Pandoc]{.double cat="排版"}
- [MySQL,MongoDB,Redis]{.double cat="数据库"}

# \faColumns 分栏语法

:::: {.cvcolumns}
::: {.cvcolumn cat="数据库"}
- MySQL
- InfluxDB
:::
::: {.cvcolumn cat="编程"}
- Shell
- Haskell
:::
::::


# 韩荆州 {.letter company="大唐帝国" addr="荆州大都督府" city="襄阳"}
## 开元22年 {.letter .date}
## Dear Sir or Madam， {.letter .opening}
## Yours faithfully, {.letter .closing}
## curriculum vit\ae {.letter .enclosure enclosure="附件"}

Cover Letter Here
EOF

	[ ! -f $bibFile ] && cat > $bibFile <<EOF
@cv{latexcv,
	title={LaTeX简历制作},
	author={panbook},
	journal={panbook},
	year={2019}
}	
EOF
	
}

function cv() {
	note "use --cv=<template|R|A> to change cv template. R means radom, A means all"
	getVar CV "moderncv"	
	cvList=(moderncv resume)
	interaction="-interaction=batchmode"
	[ "$TRACE"x == "true"x ] && interaction=""

	cvMeta	
	cd $BUILD
	
	# 支持随机选取theme
	setCV "${cvList[*]}"

	for t in ${SELECTED[@]};do
		# 每个模板都需要重新init，否则HEADERS会重复添加内容
		init nometa
		note "CV Template: $t"
		addOptions="$origAddOptions"
		PANDOCVARS="$ORIGPANDOCVARS"
		# copy cv template
		CVTPLDIR=$SCRIPTDIR/templates/cvtpls/$t
		USERDEFINECV=$cwd/templates/cvtpls/$t
		if [ -d $CVTPLDIR -o -d $USERDEFINECV ];then
			cp -rfu $CVTPLDIR $BUILD 2>/dev/null
			cp -rfu $USERDEFINECV $BUILD 2>/dev/null
			# 需要删除.md文件
			rm -f $t/*.md
			rm -f $t/*.pdf
			cp -rfu $t/* .
		fi

		OUTPUT="$BUILD/$ofile-cv-$t.tex"
		
		# 某些cv需要打补丁. 补丁放在cv文件夹下，命名规则 patch-$cvname.sh
		[ -f patch-$t.sh ] && source patch-$t.sh
		
		info "PANDOCVARS: $PANDOCVARS"
		info "addOptions: $addOptions"
		
		[ "$LSTSET"x != ""x ] && (cat $LSTSET;echo) >> $HEADERS
		# 支持 fenced_divs语法的columns
		[ "$columns"x == "true"x ] && addOptions="$addOptions $COLUMNS_SUPPORT"
		
		trimHeader
		
		CV_REFERENCE_PARAM="-F pandoc-citeproc $BIB_PARAM --csl=$CSL --lua-filter $SCRIPTDIR/filters/add-header.lua --template=$t.tpl"
		[ -f $t.lua ] && CV_REFERENCE_PARAM="$CV_REFERENCE_PARAM --lua-filter $t.lua"
		info "CV_REFERENCE_PARAM: $CV_REFERENCE_PARAM"
		pandoc $CV_REFERENCE_PARAM --listings $BODY -o $OUTPUT --pdf-engine=xelatex $PANDOCVARS $addOptions
		
		# 删除空行，空行会被认为是分段，处理很麻烦。干脆全删掉。一般简历中需要用分段的场景是求职信，
		#转求职信的时候用\par显式分段
		sed -i '/^$/d' $OUTPUT
		
		xelatex $interaction -output-directory=$BUILD $OUTPUT
		compileStatus cv
	done
	
	clean
}
