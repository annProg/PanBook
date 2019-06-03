
# 书籍

## 前言后记
在`frontmatter.md`中添加前言，`backmatter.md`中添加后记。对于`epub`电子书，可以给标题添加`epub type`属性，见代码\ref{code:epub-type-attr}，其中`.unnumbered`属性可以避免前言后记被编号。

```{#code:epub-type-attr .markdown caption="epub标题属性"}
# My chapter {epub:type=prologue .unnumbered}
```

支持如下属性见[@tbl:epub-type-attr]。

--------------------------------------------------
Attr                                    Type
----------------------------------     -----------
prologue,abstract,acknowledgments      frontmatter	         
copyright-page,dedication,foreword
halftitle,introduction	     
preface,seriespage,titlepage	         

afterword,appendix,colophon	           backmatter
conclusion,epigraph
----------------------------------------------------
: epub标题支持的属性 {#tbl:epub-type-attr}