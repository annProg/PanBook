
## 代码
### 缩进式代码块
由四个空格或一个 tab 缩进的文本取做代码块，区块中的特殊字符、空格和换行都会
被保留，而缩进的空格和 tab 会在输出中移除，但在代码块中的空行不必缩进。

    #!/bin/bash

    echo "Hello Markdown"
	echo "Hello LaTeX"

::: {.note}
Extension fenced_code_blocks：除了标准的缩进式代码块之外，Pandoc 还支持围栏式代码块， 代码块以三个或三个以
上的 `~` 符号行开始，以等于或多于开始行 `~` 个数符号行结束， 若是代码块中含有 `~`，只需
使开始行和结束行中的 `~` 符号个数多于代码块中的即可，见 [@lst:fenced_code_blocks]。
:::

```{#lst:fenced_code_blocks .markdown caption="围栏式代码块"}
~~~~~
~~~~
code here
~~~~
~~~~~~
```
预览：

~~~~~
~~~~
code here
~~~~
~~~~~~

::: {.note}
Extension backtick_code_blocks：与 fenced_code_blocks 相同，只不过使用反引号 \` 替换波浪线 `~` 而已
:::

::: {.note}
Extension fenced_code_attributes：可用 [@lst:code_attribute] 为围栏式代码块添加属性。
:::

```{#lst:code_attribute .markdown caption="代码块属性"}
~~~~ {#code:mycode .haskell .numberLines startFrom="100" caption="围栏式代码块"}
qsort []     = []
qsort (x:xs) = qsort (filter (< x) xs) ++ [x] ++
               qsort (filter (>= x) xs)
~~~~~~
```

[@lst:code_attribute] 中 lst:mycode 为 ID，haskell 与 numberLines 是类别，而 startsFrom 则是值为
100 的属性。numberLines 和 startFrom 配合使用可以显示代码行号，如果没有
指定 startFrom，则默认从 1 开始。caption 指定代码块标题，如果没有设置
caption，则默认使用 ID 作为 caption。有些输出格式可以利用这些信息来作语法
高亮。目前使用到这些信息的输出格式仅有 HTML 与 LaTeX。如果指定的输出格
式及语言类别有语法高亮支持，那么上面那段代码区块将会以高亮并带有行号
的方式呈现。

仅指定高亮语言时，可以简写为 [@lst:code_short] 形式。

```{#lst:code_short .markdown caption="代码块简写形式"}
~~~haskell
qsort [] = []
~~~
```

预览

~~~haskell
qsort [] = []
~~~
