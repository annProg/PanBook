
## Raw HTML

#### Extension: raw_html

Markdown允许你在文件中的任何地方插入原始HTML（或DocBook）指令（除了在字面文字上下文处，
此时的`<`, `>`和&都会按其字面意义显示）。（技术上而言这不算扩充功能，因为原始markdown本身就
有提供此功能，但做成扩充形式便可以在有特殊需要的时候关闭此功能。）

输出HTML, S5, Slidy, Slideous, DZSlides, EPUB, Markdown 以及Textile 等格式时，原始HTML 代
码会不作修改地保留至输出档案中；而其他格式的输出内容则会将原始HTML 代码去除掉。

#### Extension: markdown_in_html_blocks

原始markdown允许你插入HTML「区块」：所谓的HTML区块是指，上下各由一个空白行所隔开，开始与结尾
均由所在行最左侧开始的一连串对称均衡的HTML标签。在这个区块中，任何内容都会当作是HTML来分析，
而不再视为markdown；所以（举例来说），*符号就不再代表强调。

当指定格式为markdown_strict时，Pandoc会以上述方式处理；但预设情况下，Pandoc能够以markdown语法
解读HTML区块标签中的内容。举例说明，Pandoc能够将底下这段
```html
<table>
    <tr>
        <td>*one*</td>
        <td>[a link](http://google.com)</td>
    </tr>
</table>
```
转换为
```html
<table>
    <tr>
        <td><em>one</em></td>
        <td><a href="http://google.com">a link</a></td>
    </tr>
</table>
```
而Markdown.pl则是保留该段原样。

这个规则只有一个例外：那就是介于`<script>`与`<style>`之间的文字都不会被拿来当作markdown解读。

这边与原始markdown的分歧，主要是为了让markdown能够更便利地混入HTML区块元素。比方说，一段
markdown文字可以用`<div>`标签将其前后包住来进行样式指定，而不用担心里面的markdown不会被解
译到。