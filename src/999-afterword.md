
# 后记 {epub:type=afterword .unnumbered}

排版的未来是什么？是网页技术[@weborlatex]，还是\LaTeX ？\LaTeX 输出的文档确实精致好看，但是难学，编译也耗时。如果用CSS也能实现非常好的效果，那还有必要用\LaTeX 吗? 我现在很困惑。

# 附录1 兼容性设置 {-}
为了能编译不满足[@lst:panbookdirs]定义规范的源码，提供以下方式。

- 通过参数`--src`自定义书籍源码目录（默认为`src`）
- 通过参数`--imgdir`自定义书籍源码目录（默认为`src/images`）
- 如果源码不满足正确章节顺序列出，或者前言后记不规范，可通过兼容性配置文件（`src/compatible.conf`）配置各源码的用途

兼容性配置文件示例见[@lst:compatible]。

```{#lst:compatible caption="兼容性配置"}
# 第一列源码文件名，第二列源码类型，类型包含 frontmatter(前言），backmatter（后记），exclude（排除的文件），
# body（正文）。各类型中要求按正确顺序排列源码文件
preface.md frontmatter
foreword.md frontmatter
appendix.md backmatter
back.md     backmatter
README.md   exclude
introduction.md body
how-to-use.md   body
```

::: {#refs}
# 参考文献 {-}
:::