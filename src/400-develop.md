
# 开发
PanBook 基于 Pandoc，首先要了解 Pandoc 的使用方法。PanBook 主体使用 Shell 脚本开发，Pandoc Lua filter 使用 Lua 开发，定制 style 需要了解 \LaTeX 或者 CSS。[@tbl:panbookdir_specs] 给出了名词定义。

名词 | 目录 | 功能
:--|:--|:------
module | modules/ | 模块，book,cv,slide,thesis 都是模块
style | styles/ | 风格，--style 参数指定，可以定制某一种文档类或者文档格式（比如 Epub）
extension | extensions/ | 扩展，使用 lua filter 或者基于 header-includes 提供某些可被复用的扩展功能
template | templates/ | Pandoc 模板，基于格式的模板，对应 Pandoc 的 --template 参数

: PanBook 名词定义 {#tbl:panbookdir_specs}

Panbook 的基本思路是，定义一些全局数组变量存储 Pandoc 参数信息，允许模块，风格和扩展根据输出目标情况及用户提供的参数修改这些变量，最终拼接成 Pandoc 参数，执行 Pandoc 转换。开发工作也主要是做风格和扩展，去适配不同的文档类。全局变量定义见 [@lst:panbook_global_vars]。

```{#lst:panbook_global_vars .bash caption="Panbook 全局变量"}
declare -A _G         # panbook 全局选项
declare -A _P         # pandoc 选项
declare -A _V         # pandoc var (-V)
declare -A _M         # pandoc meta (-M)
declare -A _F         # lua filter (--lua-filter)
```

## 模块

## 风格

## 扩展

## Pandoc 模板