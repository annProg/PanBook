---[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]

function Meta(meta)
	k = 'header-includes'
	header = pandoc.RawBlock("latex", "\\usepackage{minted}")

	if meta[k] == nil then
		meta[k] = pandoc.MetaBlocks({header})
	else
		-- MetaBlock和MetaList处理方式不同
		t = meta[k].tag
		if t == "MetaList" then
			meta[k][#meta[k]+1] = pandoc.MetaBlocks({header})
		else
			table.insert(meta[k], header)
		end
	end
	return meta
end

function CodeBlock(block)
	local id = block.attr.identifier
	local language = block.attr.classes[1]
	local option = {}
	for i=2,#block.attr.classes do
		if block.attr.classes[i] == 'numberLines' then
			table.insert(option, "linenos")
		else
			table.insert(option, block.attr.classes[i])
		end
	end

	local label = ""
	if id ~= nil then
		label = "\\hypertarget{" .. id .. "}{%\n\\label{" .. id .. "}}%\n"
	end
	for k,v in pairs(block.attr.attributes) do
		if k == 'startFrom' then
			table.insert(option, "firstnumber=" .. v)
		elseif k ~= 'caption' then
			table.insert(option, k .. "={" .. v .. "}")
		else
		end
	end

	local optionStr = table.concat(option, ",")
	local minted = "\\begin{minted}[" .. optionStr .. "]{" .. language .. "}\n" .. block.text .. "\n\\end{minted}"
	return pandoc.RawBlock("latex", label .. minted)
end