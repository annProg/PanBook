---[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]

function CodeBlock(block)
	id = block.attr.identifier
	language = block.attr.classes[1]
	option = {}
	for i=2,#block.attr.classes do
		table.insert(option, block.attr.classes[i])
	end

	for k,v in pairs(block.attr.attributes) do
		table.insert(option, k .. "={" .. v .. "}")
	end

	table.insert(option, "label=" .. id)

	optionStr = table.concat(option, ",")
	minted = "\\begin{minted}[" .. optionStr .. "]{" .. language .. "}\n" .. block.text .. "\n\\end{minted}"
	return pandoc.RawBlock("latex", minted)
end