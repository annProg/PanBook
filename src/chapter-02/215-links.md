
## 链接

Markdown 支持以下数种指定链接的方式。

### 自动链接
如果你用角括号将一段 URL 或是 email 位址包起来，它会自动转换成链接：

```markdown
<http://google.com>
<sam@green.eggs.ham>
```

### 行内链接
一个行内链接包含了位在方括号中的链接文字，以及方括号后以圆括号包起来的 URL。（你可以选择性地在 URL 后面加入链接标题，标题文字要放在引号之中。）
```markdown
This is an [inline link](/url), and here's [one with
a title](http://fsf.org "click here for a good time!").
```

方括号与圆括号之间不能有空白。链接文字可以包含格式（例如强调），但链接标题不可以。

行内链接中的电子邮件地址不会自动检测到，因此它们必须以 mailto 开头：

```markdown
[Write me!](mailto:sam@green.eggs.ham)
```

### 参考链接
一个明确的参考链接包含两个部分，链接本身以及链接定义，其中链接定义可以放在文件的任何地方（不论是放在链接所在处之前或之后）。

链接本身是由两组方括号所组成，第一组方括号中为链接文字，第二组为链接标签。（在两个方括号间不能有空格。）链接定义则是以方括号框住的链接标签作开头，后面跟着一个冒号一个空白，再接着一个 URL，最后可以选择性地（在一个空白之后）加入由引号或是圆括号包住的链接标题。链接标签不能被解析为 `citation`（假设启用了 `citations` 扩展，参见 [@sec:citations]）: `citation` 的优先级高于链接标签。

以下是一些范例：
```markdown
[my label 1]: /foo/bar.html  "My title, optional"
[my label 2]: /foo
[my label 3]: http://fsf.org (The free software foundation)
[my label 4]: /bar#special  'A title in single quotes'
```
链接的 URL 也可以选择性地以角括号包住：
```markdown
[my label 5]: <http://foo.bar.baz>
```
链接标题可以放在第二行，效果见 [my label 3]：
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
在一个隐性参考链接中，第二组方括号的内容是空的：
```markdown
See [my website][].

[my website]: http://foo.bar.baz
```
注意：在 Markdown.pl 以及大多数其他 Markdown 实现中，参考链接的定义不能存在于嵌套结构中，例如清单项目或是引用区块。Pandoc 解除了这个看似武断的限制。所以虽然下面的语法在几乎所有其他实现中都是错误的，但在 Pandoc 中可以正确处理：

```markdown
> My block [quote].
>
> [quote]: /foo
```

::: {.info caption="Extension: shortcut_reference_links"}
在 `shortcut_reference_links` 中，第二对括号可完全省略：

```markdown
See [my website].

[my website]: http://foo.bar.baz
```
:::
### 内部链接
要链接到同一份文件的其他章节，可使用自动产生的 ID（参见 [@sec:heading]）。

```markdown
See the [Introduction](#introduction).
```
或是
```markdown
See the [Introduction].

[Introduction]: #introduction
```

内部链接目前支持的格式有 HTML（包括 HTML slide shows 与 EPUB）、\LaTeX 以及 ConTeXt。

::: {.info caption="pandoc-crossref"}
也可以使用 pandoc-crossref 的方式来处理内部链接，参见 [@sec:crossref]。
:::