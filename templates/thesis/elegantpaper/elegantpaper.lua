--[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]

function Div(el)
	if el.attr.classes[1] == "abstract" then
		local abstract = pandoc.Div({})
		table.insert(abstract.content, pandoc.RawBlock("latex", "\\begin{abstract}"))
		for k,v in pairs(el.content) do
			table.insert(abstract.content, v)
		end
		table.insert(abstract.content, pandoc.RawBlock("latex", "\\end{abstract}"))
		return abstract
	end
end