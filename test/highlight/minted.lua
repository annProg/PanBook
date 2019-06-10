---[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]

function Meta(meta)
	header = pandoc.MetaBlocks({})
	table.insert(header, pandoc.RawBlock("latex", "\\usepackage{minted}"))
	meta['header-includes'] = header
	return meta
end

function CodeBlock(block)
	id = block.attr.identifier
	language = block.attr.classes[1]
	option = {}
	for i=2,#block.attr.classes do
		table.insert(option, block.attr.classes[i])
	end

	for k,v in pairs(block.attr.attributes) do
		if k ~= 'caption' then
			table.insert(option, k .. "={" .. v .. "}")
		end
	end

	table.insert(option, "label=" .. id)

	optionStr = table.concat(option, ",")
	minted = "\\begin{minted}[" .. optionStr .. "]{" .. language .. "}\n" .. block.text .. "\n\\end{minted}"
	return pandoc.RawBlock("latex", minted)
end