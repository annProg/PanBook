

## 脚注

#### Extension: footnotes

Pandoc's markdown 支援脚注功能，使用如代码\ref{code:footnote}所示的语法：
```{#code:footnote .markdown caption="脚注语法"}
Here is a footnote reference,[^1] and another.[^longnote]

[^1]: Here is the footnote.

[^longnote]: Here's one with multiple blocks.

    Subsequent paragraphs are indented to show that they
belong to the previous footnote.

        { some.code }

    The whole paragraph can be indented, or just the first
    line.  In this way, multi-paragraph footnotes work like
    multi-paragraph list items.

This paragraph won't be part of the note, because it
isn't indented.
```


Here is a footnote reference,[^1] and another.[^longnote]

[^1]: Here is the footnote.

[^longnote]: Here's one with multiple blocks.

    Subsequent paragraphs are indented to show that they
belong to the previous footnote.

      { some.code }

    The whole paragraph can be indented, or just the first
    line.  In this way, multi-paragraph footnotes work like
    multi-paragraph list items.

This paragraph won't be part of the note, because it
isn't indented.


脚注参考用的ID 不得包含空白、tabs 或换行字元。这些ID 只会用来建立脚注位置与脚注文字的
对应关连；在输出时，脚注将会依序递增编号。

脚注本身不需要放在文件的最后面。它们可以放在文件里的任何地方，但不能被放入区块元素（清
单、区块引言、表格等）之中。

#### Extension: inline_notes

Pandoc 也支援了行内脚注（尽管，与一般脚注不同，行内脚注不能包含多个段落）。其语法如下：

```markdown
Here is an inline note.^[Inlines notes are easier to write, since
you don't have to pick an identifier and move down to type the
note.]
```

Here is an inline note.^[Inlines notes are easier to write, since
you don't have to pick an identifier and move down to type the
note.]

行内与一般脚注可以自由交错使用。