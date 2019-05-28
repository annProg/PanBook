## 行内格式

###强调
要强调某些文字，只要以`*`或`_`符号前后包住即可，像这样：
```markdown
This text is _emphasized with underscores_, and this
is *emphasized with asterisks*.
```
重复两个`*`或`_`符号以产生更强烈的强调：
```markdown
This is **strong emphasis** and __with underscores__.
```
This is **strong emphasis** and __with underscores__.

一个前后以空白字元包住，或是前面加上反斜线的`*`或`_`符号，都不会转换为强调格式：
```markdown
This is * not emphasized *, and \*neither is this\*.
```

#### Extension: intraword_underscores

因为_字元有时会使用在单字或是ID之中，所以pandoc不会把被字母包住的_解读为强调标记。
如果有需要特别强调单字中的一部分，就用*：

```markdown
feas*ible*, not feas*able*.
```

### 删除线
#### Extension: strikeout

要将一段文字加上水平线作为删除效果，将该段文字前后以`~~`包住即可。例如，
```markdown
This ~~is deleted text.~~
```

### 上标与下标
#### Extension: superscript,subscript

要输入上标可以用`^`字元将要上标的文字包起来；要输入下标可以用`~`字元将要下标的
文字包起来。直接看范例，
```markdown
H~2~O is a liquid.  2^10^ is 1024.
```
H~2~O is a liquid.  2^10^ is 1024.

如果要上标或下标的文字中包含了空白，那么这个空白字元之前必须加上反斜线。（这是为
了避免一般使用下的`~`和`^`在非预期的情况下产生出意外的上标或下标。）所以，如果你想要
让字母P后面跟着下标文字'a cat'，那么就要输入`P~a\ cat~`，而不是`P~a cat~`。

### 字面文字
要让一小段文字直接以其字面形式呈现，可以用反引号将其包住：

```markdown
What is the difference between `>>=` and `>>`?
```
如果字面文字中也包含了反引号，那就使用双重反引号包住：

```markdown
Here is a literal backtick `` ` ``.
````

（在起始反引号后的空白以及结束反引号前的空白都会被忽略。）

一般性的规则如下，字面文字区段是以连续的反引号字元作为开始（反引号后的空白字元为可选），
一直到同样数目的反引号字元出现才结束（反引号前的空白字元也为可选）。

要注意的是，转义字符（以及其他markdown 结构）在字面文字的上下文中是没有效果的：
```markdown
This is a backslash followed by an asterisk: `\*`.
```

#### Extension: inline_code_attributes

与围栏代码区块一样，字面文字也可以附加属性：
```markdown
`<$>`{.haskell}
```
