
## 图片

在链接语法的前面加上一个！就是图片的语法了。链接文字将会作为图片的替代文字（`alt text`）：
```markdown
![la lune](Pictures/background.pdf "Voyage to the moon")

![movie reel]

[movie reel]: movie.gif
```

::: {.info caption="Extension: implicit_figures"}
一个图片若自身单独存在一个段落中，那么将会以附上图片说明（caption） 的图表（figure）形式呈现。（在 LaTeX 中，会使用图表环境；在 HTML 中，图片会被放在具有 figure 类别的 div 元素中，并会附上一个具有 caption 类别的 p 元素。）图片的 `alt` 文字同时也会用来作为图片说明。

```markdown
![This is the caption](/url/of/image.png)
```
:::

如何呈现取决于输出格式。一些输出格式（例如 RTF) 还不支持插图标题。在这些格式中，您只会在一个段落中单独获得一个没有标题的图片。

如果您只是想要一个常规的行内图像，请确保它不是该段中的唯一内容。一种方法是在图像后面插入一个不间断的空格：

```markdown
![This image won't be a figure](/url/of/image.png)\
```

注意，在 reveal.js 幻灯片显示中，一个段落中的图像本身具有 `stretch` 样式时将填充屏幕，而标题和图标记将被忽略。

::: {.info caption="Extension: link_attributes"}
链接和图像可以设置属性，如 [@lst:link_attributes]。
:::

```{#lst:link_attributes .markdown caption="图片属性设置"}
An inline ![image](foo.jpg){#id .class width=30 height=20px}
and a reference ![image][ref] with attributes.

[ref]: foo.jpg "optional title" {#id .class key=val key2="val 2"}
```

（当只使用 `#id` 和 `.class` 时，此语法与 [PHP Markdown Extra](https://michelf.ca/projects/php-markdown/extra/) 兼容。）

对于 HTML 和 EPUB，除了 `width` 和 `height`（但包括 `srcset` 和 `sizes`）以外的所有属性都按原样传递。其他编写器忽略输出格式不支持的属性。

对图像的宽度和高度属性进行了特殊处理。如果不使用单位，则假定单位为像素。但是，可以使用以下任何单位标识符：px、cm、mm、in、inch 和 `%`。数字和单位之间不能有空格。例如：

```markdown
![](file.jpg){ width=50% }
```

- 尺寸转换为英寸，以便以基于页面的格式（如 \LaTeX) 输出。尺寸被转换为像素，以便以类似 HTML 的格式输出。使用 `--dpi` 选项指定每英寸的像素数。默认值是 `96dpi`。
- `%` 单位通常是基于一些可用空间的相对值。例如，上面的例子将呈现给以下内容。
  - HTML: `<img href="file.jpg" style="width: 50%;" />`
  - \LaTeX: `\includegraphics[width=0.5\textwidth,height=\textheight]{file.jpg}` （如果使用自定义模板，则需要像默认模板中那样设置 `graphicx`。)
- 当没有指定宽度或高度属性时，应变的方法是查看图像分辨率和嵌入到图像文件中的 dpi 元数据。  

::: {.info caption="图片交叉引用"}
使用 pandoc-crossref 处理图片交叉引用，请参考 [@sec:crossref]。
:::