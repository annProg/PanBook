
## 行内格式

###强调
要强调某些文字，只要以 `*` 或 `_` 符号前后包住即可，像这样：

```markdown
This text is _emphasized with underscores_, and this
is *emphasized with asterisks*.
```

重复两个 `*` 或 `_` 符号以产生更**强烈**的 __强调__：

```markdown
This is **strong emphasis** and __with underscores__.
```

一个前后以空格包住，或是前面加上反斜线的 `*` 或 `_` 符号，都不会转换为强调格式：

```markdown
This is * not emphasized *, and \*neither is this\*.
```

::: {.info caption="Extension: intraword_underscores"}
因为 `_` 字元有时会使用在单词或是 ID 之中，所以 Pandoc 不会把被字母包住的 `_` 解读为强调标记。如果有需要特别强调单词中的一部分，需要用 `*`：

```markdown
feas*ible*, not feas*able*.
```
:::

### 删除线

::: {.info caption="Extension: strikeout"}
要将一段文字加上水平线作为删除效果，将该段文字前后以 `~~` 包住即可。
:::

```markdown
This ~~is deleted text.~~
```

### 上标与下标

::: {.info caption="Extension: superscript,subscript"}
要输入上标可以用 `^` 字符将要上标的文字包起来；要输入下标可以用 `~` 字符将要下标的文字包起来。比如 2^10^ 是 1024，源码为：

```markdown
H~2~O is a liquid.  2^10^ is 1024.
```
:::

如果要上标或下标的文字中包含了空格，那么这个空格之前必须加上反斜线。（这是为了避免一般使用下的 `~` 和 `^` 在非预期的情况下产生出意外的上标或下标。）所以，如果你想要让字母 P 后面跟着下标文字'a cat'，那么就要输入`P~a\ cat~`，而不是`P~a cat~`。

### 字面文字
要让一小段文字直接以其字面形式呈现，可以用反引号将其包住：

```markdown
What is the difference between `>>=` and `>>`?
```

如果字面文字中也包含了反引号，那就使用双重反引号包住：

```markdown
Here is a literal backtick `` ` ``.
````

（在起始反引号后的空格以及结束反引号前的空格都会被忽略。）

一般性的规则如下，字面文字区段是以连续的反引号字元作为开始（反引号后的空格为可选），一直到同样数目的反引号字元出现才结束（反引号前的空格也为可选）。

要注意的是，转义字符（以及其他 Markdown 结构）在字面文字的上下文中是没有效果的：

```markdown
This is a backslash followed by an asterisk: `\*`.
```

::: {.info caption="Extension: inline_code_attributes"}
与围栏代码区块一样，字面文字也可以附加属性：

```markdown
`<$>`{.haskell}
```
:::

### 小型大写字母

小型大写字母使用 [@sec:bracketed_spans] 语法，指定 `.smallcaps` 样式：

```markdown
[Small caps]{.smallcaps}
```

或者，不用 `bracketed_spans` 扩展，直接写 HTML：

```html
<span class="smallcaps">Small caps</span>
```

为了兼容其他 Markdown 风格，也支持 CSS：

```html
<span style="font-variant:small-caps;">Small caps</span>
```

此功能在所有支持 小型大写字母 的输出格式中都有效。