
## 引用

> This is a block quote. This
> paragraph has two lines.
>
> 1. This is a list inside a block quote.
> 2. Second item.

Markdown 使用 email 的习惯来建立引用区块。一个引用区块可以由一或多个段落或其他的区块元素（如列表或标题）组成，并且其行首均是由一个>符号加上一
个空白作为开头。（>符号不一定要位在该行最左边，但也不能缩进超过三个空白）。

```markdown
> This is a block quote. This
> paragraph has two lines.
>
> 1. This is a list inside a block quote.
> 2. Second item.
```

有一个「偷懒」的形式：你只需要在引用区块的第一行行首输入>即可，后面的
行首可以省略符号。

```markdown
> This is a block quote. This
paragraph has two lines.

> 1. This is a list inside a block quote.
2. Second item.
```

由于区块引用可包含其他区块元素，而区块引用本身也是区块元素，所以，引用
是可以嵌套入其他引用的。

```markdown
> This is a block quote.
>
>> A block quote within a block quote.
```

::: {.note}
Extension blank_before_blockquote：原始 markdown 语法在区块引用之前并不需要预留空白行。Pandoc 则需要（除非区块引用位于文件最开始的地方）。这是因为以`>`符号开头的情况在一般文字段落中相当常见（也许由于断行所致），这会导致非预期的格式。因此，除非是指定为 markdown_strict 格式，否则需要预留空白。
:::