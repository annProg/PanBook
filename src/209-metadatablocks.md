
## 文件标题区块

（译注：本节中提到的「标题」均指 Title，而非 Headers）

#### Extension: pandoc_title_block

如果档案以文件标题（Title）区块开头
```
% title
% author(s) (separated by semicolons)
% date
```
这部份将不会作为一般文字处理，而会以书目资讯的方式解析。（这可用在像是单
一 LaTeX 或是 HTML 输出文件的书名上。）这个区块仅能包含标题，或是标题与作
者，或是标题、作者与日期。如果你只想包含作者却不想包含标题，或是只有标题
与日期而没有作者，你得利用空白行：
```
%
% Author

% My title
%
% June 15, 2006
```
标题可以包含多行文字，但接续行必须以空白字元开头，像是：

```
% My title
  on multiple lines
```

如果文件有多个作者，作者也可以分列在不同行并以空白字元作开头，或是以分号间隔，或
是两者并行。所以，下列各种写法得到的结果都是相同的：

```
% Author One
  Author Two

% Author One; Author Two

% Author One;
  Author Two
```

日期就只能写在一行之内。

所有这三个 metadata 栏位都可以包含标准的行内格式（斜体、连结、脚注等等）。

文件标题区块一定会被分析处理，但只有在`--standaline( -s)`选项被设定时才会影响输出内
容。在输出 HTML 时，文件标题会出现的地方有两个：一个是在文件的`<head>`区块里---这会
显示在浏览器的视窗标题上---另外一个是文件的`<body>`区块最前面。位于`<head>`里的文件
标题可以选择性地加上前缀文字（透过`--title-prefix`或`-T`选项）。而在`<body>`里的文件标
题会以 H1 元素呈现，并附带“title”类别 (class)，这样就能藉由 CSS 来隐藏显示或重新定义格
式。如果以-T 选项指定了标题前缀文字，却没有设定文件标题区块里的标题，那么前缀文字本
身就会被当作是 HTML 的文件标题。

而 man page 的输出器会分析文件标题区块的标题行，以解出标题、man page section number，
以及其他页眉 (header) 页脚 (footer) 所需要的资讯。一般会假设标题行的第一个单字为标题，
标题后也许会紧接着一个以括号包住的单一数字，代表 section number（标题与括号之间没
有空白）。在此之后的其他文字则为页脚与页眉文字。页脚与页眉文字之间是以单独的一个
管线符号 ( |) 作为区隔。所以，

```
% PANDOC(1)
```
将会产生一份标题为 PANDOC 且 section 为 1 的 man page。

```
% PANDOC(1) Pandoc User Manuals
```
产生的 man page 会再加上“Pandoc User Manuals” 在页脚处。

```
% PANDOC(1) Pandoc User Manuals | Version 4.0
```
产生的 man page 会再加上“Version 4.0” 在页眉处。