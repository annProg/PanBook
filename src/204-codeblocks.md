
## 代码
### 缩进式代码块
由四个空格或一个tab缩进的文本取做代码块，区块中的特殊字符、空格和换行都会
被保留，而缩进的空格和tab会在输出中移除，但在代码块中的空行不必缩进。

    #!/bin/bash

    echo "Hello Markdown"
	echo "Hello LaTeX"
### 围栏式代码块
#### Extension: fenced_code_blocks

除了标准的缩进式代码块之外，Pandoc还支持围栏式代码块， 代码块以三个或三个以
上的\~符号行开始，以等于或多于开始行\~个数符号行结束， 若是代码块中含有\~，只需
使开始行和结束行中的\~符号个数多于代码块中的即可

```
~~~~~
~~~~
code here
~~~~
~~~~~~
```

#### Extension: backtick_code_blocks

与`fenced_code_blocks`相同，只不过使用反引号 \` 替换波浪线 \~ 而已


#### Extension: fenced_code_attributes

```{#code:fencedcode .numberLines startFrom="100" caption="围栏式代码块"}
~~~~ {#code:mycode .haskell .numberLines startFrom="100" caption="围栏式代码块"}
qsort []     = []
qsort (x:xs) = qsort (filter (< x) xs) ++ [x] ++
               qsort (filter (>= x) xs)
~~~~~~
```
这里的mycode为ID，haskell与numberLines是类别，而startsFrom则是值为
100的属性。numberLines和startFrom配合使用可以显示代码行号，如果没有
指定startFrom，则默认从1开始。caption指定代码块标题，如果没有设置
caption，则默认使用ID作为caption。有些输出格式可以利用这些信息来作语法
高亮。目前使用到这些信息的输出格式仅有HTML与LaTeX。如果指定的输出格
式及语言类别有语法高亮支持，那么上面那段代码区块将会以高亮并带有行号
的方式呈现。

仅指定高亮语言时，可以简写为以下形式：

```markdown
~~~haskell
qsort [] = []
~~~
```