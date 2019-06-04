
## 引用
Markdown使用email的习惯来建立引用区块（[@lst:quote]）。一个引用区块可以由一或多个段落
或其他的区块元素（如列表或标题）组成，并且其行首均是由一个>符号加上一
个空白作为开头。（>符号不一定要位在该行最左边，但也不能缩进超过三个空白）。

::::: {.columns}
::: {.column}
```{#lst:quote .markdown caption="引用区块"}
> This is a block quote. This
> paragraph has two lines.
>
> 1. This is a list inside a block quote.
> 2. Second item.
```
:::
::: {.column}

[@lst:quote] 预览：

> This is a block quote. This
> paragraph has two lines.
>
> 1. This is a list inside a block quote.
> 2. Second item.
:::
:::::

有一个「偷懒」的形式：你只需要在引用区块的第一行行首输入>即可，后面的
行首可以省略符号（[@lst:quote2]）。

::::: {.columns}
::: {.column}
```{#lst:quote2 .markdown caption="引用区块偷懒形式"}
> This is a block quote. This
paragraph has two lines.

> 1. This is a list inside a block quote.
2. Second item.
```
:::
::: {.column}
[@lst:quote2] 预览

> This is a block quote. This
paragraph has two lines.

> 1. This is a list inside a block quote.
2. Second item.
:::
:::::


由于区块引用可包含其他区块元素，而区块引用本身也是区块元素，所以，引用
是可以嵌套入其他引用的（[@lst:quote_nested）。

::::: {.columns}
::: {.column}
```{#lst:quote_nested .markdown caption="嵌套引用"}
> This is a block quote.
>
>> A block quote within a block quote.
```
:::
::: {.column}
[@lst:quote_nested] 预览

> This is a block quote.
>
>> A block quote within a block quote.
:::
:::::

#### Extension: blank_before_blockquote

原始markdown语法在区块引用之前并不需要预留空白行。Pandoc则需要（除非区
块引用位于文件最开始的地方）。这是因为以>符号开头的情况在一般文字段落中
相当常见（也许由于断行所致），这会导致非预期的格式。因此，除非是指定为
markdown_strict格式，不然以下的语法在pandoc中将不会产生出嵌套区块引用：

::::: {.columns}
::: {.column}
```{#lst:blank_before_blockquote .markdown caption="引用区块预留空行"}
> This is a block quote.
>> Nested.
```
:::
::: {.column}
[@lst:blank_before_blockquote] 预览，可以看到没有生成引用区块。
> This is a block quote.
>> Nested.
:::
:::::