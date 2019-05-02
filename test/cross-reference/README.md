% 交叉引用
% Ann
% 2019/5/1

# 交叉引用

## 需求

同时支持 LaTeX, Epub, HTML

## 代码

- `\ref`方式： 如代码\ref{lst:test}所示
- `[@id]`语法: 如代码[@lst:test]所示
- `[Prefix @id]`语法: 如[代码 @lst:test]所示

```{#lst:test .bash caption="Test Code Reference"}
#/bin/bash
echo "hello world"
```
