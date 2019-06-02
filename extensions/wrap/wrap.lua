--[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]
local wrapClass = {'info', 'tip', 'warn', 'alert', 'help'}

function inTable(t, val)
	for _, v in pairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

function Div(el)
	if inTable(wrapClass, el.attr.classes[1]) then
		e = el.attr.classes[1]
		ret = pandoc.Para({})
		table.insert(ret.content, pandoc.RawInline("latex", "\\begin{" .. e .. "}\n"))
		for k,v in pairs(el.content) do
			for i,val in pairs(v.content) do
				table.insert(ret.content, val)
			end
		end
		table.insert(ret.content, pandoc.RawInline("latex", "\n\\end{" .. e .. "}"))
		return ret
	end
end