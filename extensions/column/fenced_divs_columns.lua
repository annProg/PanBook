function getWidth(width)
	if width ~= nil then
		width = string.match(width, "(%d+)%%$")
	end
	if width ~= nil then
		-- 考虑到多栏之间需要留间隙，分母取104
		return width/104
	else
		return "0.48"
	end
end

function divColumns(el)
	-- 新建 Div 类型的空table，返回结果可以之间加入blocks列表
	local column = pandoc.Div({})
	for k,v in pairs(el) do
		if v.t == "Div" and v.attr.classes[1] == "column" then
			if k > 1 and el[k-1].t == "Div" and el[k-1].attr.classes[1] == "column" then
				-- do nothing
			else
				table.insert(column.content, pandoc.RawBlock("latex", "\\begin{column}{" .. getWidth(v.attr.attributes.width) .. "\\textwidth}"))
			end
			for c,content in pairs(v.content) do
				table.insert(column.content, content)
			end
			
			if k+1 <= #el and el[k+1].t == "Div" and el[k+1].attr.classes[1] == "column" then
				table.insert(column.content, pandoc.RawBlock("latex", "\\end{column}\n\\begin{column}{" .. getWidth(el[k+1].attr.attributes.width) .. "\\textwidth}"))
			else
				table.insert(column.content, pandoc.RawBlock("latex", "\\end{column}"))
			end
		else
			table.insert(column.content, v)
		end
	end
	
	return column
end

function Pandoc(doc)
	local nblocks = {}
	for i,el in pairs(doc.blocks) do
		if el.t == "Div" and el.attr.classes[1] == "columns" then
			table.insert(nblocks, pandoc.RawBlock("latex", "\\begin{columns}"))
			table.insert(nblocks, divColumns(el.content))
			table.insert(nblocks, pandoc.RawBlock("latex", "\\end{columns}"))
		else
			table.insert(nblocks, el)
		end
	end
	return pandoc.Doc(nblocks, doc.meta)
end