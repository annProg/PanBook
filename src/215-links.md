
## 链接

Markdown 接受以下数种指定链接的方式。

### 自动链接
如果你用角括号将一段URL 或是email 位址包起来，它会自动转换成链接：

<http://google.com>

<sam@green.eggs.ham>

### 行内链接
一个行内链接包含了位在方括号中的链接文字，以及方括号后以圆括号包起来的URL。（你可以选
择性地在URL 后面加入链接标题，标题文字要放在引号之中。）
```markdown
This is an [inline link](/url), and here's [one with
a title](http://fsf.org "click here for a good time!").
```

This is an [inline link](/url), and here's [one with
a title](http://fsf.org "click here for a good time!").

方括号与圆括号之间不能有空白。链接文字可以包含格式（例如强调），但链接标题则否。

### 参考链接
一个明确的参考链接包含两个部分，链接本身以及链接定义，其中链接定义可以放在文件的任何地
方（不论是放在链接所在处之前或之后）。

链接本身是由两组方括号所组成，第一组方括号中为链接文字，第二组为链接标签。（在两个方括号
间可以有空白。）链接定义则是以方括号框住的链接标签作开头，后面跟着一个冒号一个空白，再接
着一个URL，最后可以选择性地（在一个空白之后）加入由引号或是圆括号包住的链接标题。

以下是一些范例：
```markdown
[my label 1]: /foo/bar.html  "My title, optional"
[my label 2]: /foo
[my label 3]: http://fsf.org (The free software foundation)
[my label 4]: /bar#special  'A title in single quotes'
```
链接的URL 也可以选择性地以角括号包住：
```markdown
[my label 5]: <http://foo.bar.baz>
```
链接标题可以放在第二行，效果见[my label 3]：
```markdown
[my label 3]: http://fsf.org
  "The free software foundation"
```

[my label 3]: http://fsf.org
  "The free software foundation"

需注意链接标签并不区分大小写。所以下面的例子会建立合法的链接：
```markdown
Here is [my link][FOO]

[Foo]: /bar/baz
```
在一个隐性参考链接中，第二组方括号的内容是空的，甚至可以完全地略去：
```markdown
See [my website][], or [my website].

[my website]: http://foo.bar.baz
```
注意：在Markdown.pl以及大多数其他markdown实作中，参考链接的定义不能存在于嵌套结构中，例
如清单项目或是区块引言。Pandoc lifts this arbitrary seeming restriction。所以虽然下面的
语法在几乎所有其他实作中都是错误的，但在pandoc中可以正确处理：

```markdown
> My block [quote].
>
> [quote]: /foo
```

### 内部链接
要链接到同一份文件的其他章节，可使用自动产生的ID（参见HTML, LaTeX与ConTeXt的标题识别符一
节后半）。
```markdown
See the [Introduction](#introduction).
```
或是
```markdown
See the [Introduction].

[Introduction]: #introduction
```
内部链接目前支援的格式有HTML（包括HTML slide shows 与EPUB）、LaTeX 以及ConTeXt。