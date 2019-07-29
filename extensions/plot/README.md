# Plot

用于画图

## 安装
需要安装 librsvg 用于 SVG 转 PDF。msys2 上使用 `pacman -S mingw64/mingw-w64-x86_64-librsvg` 安装。

目前支持以下画图引擎，如需使用，请安装对应软件并加入 PATH 环境变量

- dot,neato,fdp,sfdp,twopi,circo (from graphviz)
- ditaa （建议使用 go 语言版本 https://github.com/akavel/ditaa/release）
- gnuplot

## 用法

使用代码块语法

- 为正常使用交叉引用，id 格式须符合 `fig:<label>`
- 样式格式须为 `plot:<plot engine>`，比如 `plot:dot`

```{#fig:<label> .plot:<engine> caption="<caption>"}
digraph G {
	Markdown -> LaTeX;
}
```

### 字体设置

可以通过 metadata.yml 设置字体

- gnuplotFont 默认 思源宋体