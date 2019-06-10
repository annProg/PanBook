---[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]

function Meta(meta)
	k = 'header-includes'
	header = pandoc.RawBlock("latex", "\\usepackage{minted}")

	if meta[k] == nil then
		meta['header-includes'] = pandoc.MetaBlocks({header})
	else
		table.insert(meta['header-includes'], header)
	end
	return meta
end

function CodeBlock(block)
	local id = block.attr.identifier
	local language = block.attr.classes[1]
	local option = {}
	for i=2,#block.attr.classes do
		table.insert(option, block.attr.classes[i])
	end

	local label = ""
	if id ~= nil then
		label = "\\hypertarget{" .. id .. "}{%\n\\label{" .. id .. "}}%\n"
	end
	for k,v in pairs(block.attr.attributes) do
		if k ~= 'caption' then
			table.insert(option, k .. "={" .. v .. "}")
		end
	end

	local optionStr = table.concat(option, ",")
	local minted = "\\begin{minted}[" .. optionStr .. "]{" .. language .. "}\n" .. block.text .. "\n\\end{minted}"
	return pandoc.RawBlock("latex", label .. minted)
end