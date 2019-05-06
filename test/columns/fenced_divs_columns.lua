--[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]

function divColumns(el)
	local column = {}
	for k,v in pairs(el) do
		if v.t == "Div" and v.attr.classes[1] == "column" then
			local width = v.attr.attributes.width
			if type(width) == string and string.find(width, "%d+%%$") then
				width = string.gsub(width, "%", "")
				width = width/100
			else
				width = "0.5"
			end
			table.insert(column, pandoc.RawBlock("latex", "\\begin{column}{" .. width .. "\\textwidth}"))
			for c,content in pairs(v.content) do
				table.insert(column, content)
			end
			table.insert(column, pandoc.RawBlock("latex", "\\end{column}"))
		else
			table.insert(column, v)
		end
	end
	
	return column
end

function Pandoc(doc)
	local nblocks = {}
	for i,el in pairs(doc.blocks) do
		if el.t == "Div" and el.attr.classes[1] == "columns" then
			table.insert(nblocks, pandoc.RawBlock("latex", "\\begin{columns}"))
			for k,v in pairs(divColumns(el.content)) do
				table.insert(nblocks, v)
			end
			table.insert(nblocks, pandoc.RawBlock("latex", "\\end{columns}"))
		else
			table.insert(nblocks, el)
		end
	end
	return pandoc.Doc(nblocks, doc.meta)
end