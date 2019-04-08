# Notepad++

推荐使用`Notepad++`作为`Markdown`编辑器。

## Markdown语法高亮

使用 https://github.com/Edditoria/markdown-plus-plus 项目，下载对应`xml`文件，然后在`Notepad++`中依次点击`语言`->`自定义语言`，在弹出框中点击导入，选择下载的`xml`文件即可。然后将语言改为`Markdown`。

## Markdown实时预览
打开`插件`，`Plugin Admin`，搜索`MarkdownViewer++`，安装即可。

### MarkdownViewer++自定义CSS

```css
h1, 
h2, 
h3, 
h4, 
h5, 
h6 {
    margin:20px 0;
    font-weight: bold;
}
h1 {
    color: #000000;
    font-size: 28px;
}
h2 {
    border-bottom: 2px solid #CCCCCC;
    color: #000000;
    font-size: 24px;
}
h3 {
    border-bottom: 2px solid #CCCCCC;
    font-size: 18px;
}
h4 {
    font-size: 16px;
}
h5 {
    font-size: 14px;
}
h6 {
    color: #777777;
    background-color: inherit;
    font-size: 14px;
}
em {
    font-style: italic;
}
hr {
    height: 0.2em;
    border: 0;
    color: #CCCCCC;
    background-color: #CCCCCC;
}
p,
blockquote, 
table, 
ol, 
ul,
dl, 
pre {
    margin: 15px 0;
}

li {
	margin-left: 2px;
}
ul > li{
    list-style-type: disc;
}
ol > li{
    list-style-type: decimal;
}
pre { 
    background-color: #F8F8F8;    
    border: 1px solid #CCCCCC;
    border-radius: 3px;
    overflow: auto;
    padding: 2px;
}
p > code, li > code {
    font-family: Consolas, Monaco, Andale Mono, monospace; 
    background-color:#F8F8F8;
    border: 1px solid #CCCCCC;
    border-radius: 3px;
}
pre > code {
    font-family: Consolas, Monaco, Andale Mono, monospace; 
    border: 0;
    /*margin: 2px 5px;  
    padding: 1px;*/
}
  /*  background-color:#F8F8F8;
    border: 1px solid #CCCCCC;
    border-radius: 3px;
    padding: 0 0.2em;
  /*  line-height: 1;
}*/

a{ color: #0645ad; text-decoration:none;}
a:visited{ color: #0b0080; }
a:hover{ color: #06e; }
a:active{ color:#faa700; }
a:focus{ outline: thin dotted; }
a:hover, a:active{ outline: 0; }
::-moz-selection{background:rgba(255,255,0,0.3);color:#000}
::selection{background:rgba(255,255,0,0.3);color:#000}
a::-moz-selection{background:rgba(255,255,0,0.3);color:#0645ad}
a::selection{background:rgba(255,255,0,0.3);color:#0645ad}
blockquote{
    color:#666666;
    background-color: #F8F8F8;    
    margin:0;
    padding-left: 3em;
    border-left: 0.5em #EEE solid;
}
ul, 
ol { margin: 1em 0; padding: 0 0 0 2em; }
li p:last-child { margin:0 }
dd { margin: 0 0 0 2em; }
img { border: 0; -ms-interpolation-mode: bicubic; vertical-align: middle; max-width:100%;}
table {
    margin: 1em auto;
    border-collapse: collapse; 
    border-spacing: 0; 
    border: 1px solid #aaa; 
    background-color: #f9f9f9;
    width: 95%;
}
table thead {background-color: #D9E2DF;}
table tr,
table td,
table th {
    margin: 0.3em;
    padding: 0.3em;
    border: 1px solid #aaa;
}
td { vertical-align: top; }
```
