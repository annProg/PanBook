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

function Pandoc(doc)
	local nblocks = {}
	for k,el in pairs(doc.blocks) do
		if el.t == "Div" and inTable(zh_enClass, el.attr.classes[1]) then
			table.insert(nblocks, pandoc.RawBlock("latex", "\\begin{" .. el.attr.classes[1] .. "}"))
			table.insert(nblocks, el)
			table.insert(nblocks, pandoc.RawBlock("latex", "\\end{" .. el.attr.classes[1] .. "}"))
		elseif el.t == "Header" and inTable(zh_enClass, el.attr.classes[1]) then
			local c = el.attr.classes[1]
			-- both时使用中文标题
			if doc.meta['ext-zh-en'] == 'both' and c == 'zh' then
				table.insert(nblocks, el)
			elseif c  == doc.meta['ext-zh-en'] then
				table.insert(nblocks, el)
			else
			end
		else
			table.insert(nblocks, el)
		end
	end
	return pandoc.Pandoc(nblocks, doc.meta)
end