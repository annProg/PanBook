
## 图片

在链接语法的前面加上一个!就是图片的语法了。链接文字将会作为图片的替代文字（alt text）：
```markdown
![la lune](Pictures/background.pdf "Voyage to the moon")

![movie reel]

[movie reel]: movie.gif
```

也可以使用LaTeX的`\label`为图片添加label，这样就可以在其他地方引用了，例如：
```markdown
效果如图\ref{fig:markdown}。

![Markdown\label{fig:markdown}](images/markdown.jpg "Markdown")
```
效果如图\ref{fig:markdown}。

![Markdown\label{fig:markdown}](images/markdown.jpg "Markdown")

### 附上说明的图片
#### Extension: implicit_figures

一个图片若自身单独存在一个段落中，那么将会以附上图片说明(caption)的图表(figure)形式呈
现。（在LaTeX中，会使用图表环境；在HTML中，图片会被放在具有figure类别的div元素中，并会附
上一个具有caption类别的p元素。）图片的替代文字同时也会用来作为图片说明。

```markdown
![This is the caption](/url/of/image.png)
```
如果你只是想要个一般的行内图片，那么只要让图片不是段落里唯一的元素即可。一个简单的方法
是在图片后面插入一个不断行空格：
```markdown
![This image won't be a figure](/url/of/image.png)\
```
