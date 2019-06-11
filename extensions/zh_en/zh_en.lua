--[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]
local zh_enClass = {'zh', 'en'}

function inTable(t, val)
	for _, v in pairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

function Div(el)
	if inTable(zh_enClass, el.attr.classes[1]) then
		return {
			pandoc.RawBlock("latex", "\\begin{" .. el.attr.classes[1] .. "}"),
			el,
			pandoc.RawBlock("latex", "\\end{" .. el.attr.classes[1] .. "}")
		}
	end
end