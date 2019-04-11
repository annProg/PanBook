# latex模板

默认模板，`pandoc -D latex` 输出。

## 解决beamer报错
% from: https://tex.stackexchange.com/questions/426088/texlive-pretest-2018-beamer-and-subfig-collide
% use `tlmgr update caption` can solve it too.
\makeatletter
\let\@@magyar@captionfix\relax
\makeatother