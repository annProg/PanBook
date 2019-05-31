--[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]

function Div(el)
	if el.attr.classes[1] == "note" then
		ret = pandoc.Para({})
		table.insert(ret.content, pandoc.RawInline("latex", "\\begin{note}\n"))
		for k,v in pairs(el.content) do
			for i,val in pairs(v.content) do
				table.insert(ret.content, val)
			end
		end
		table.insert(ret.content, pandoc.RawInline("latex", "\n\\end{note}"))
		return ret
	end
end