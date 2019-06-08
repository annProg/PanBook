---[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]

--[[
1. 通过 -M 参数 传递 分隔符，默认使用 %（分隔符左右须有空格）
2. 以 moderncv 语法为蓝本，除标题外都转换为Div
3. 其他模板尽量用 newcommand的形式兼容 moderncv 语法，减少lua代码量
4. 列表cat用中文或者英文冒号为分隔符（分隔符左右无空格）
--]]

function Pandoc(doc)
	table.print(doc)
end