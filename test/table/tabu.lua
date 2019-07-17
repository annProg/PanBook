---[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]

if FORMAT ~= "latex" and FORMAT ~= "tex" and FORMAT ~= "pdf" then
	return {}
end

function Div(el)
	-- pandoc-crossref 使用 id 前缀为 tbl: 的 Div
	if not string.match(el.attr.identifier, '^tbl:.*') then
		return el
	end

	-- 确保为 Table
	if el.content[1].t ~= "Table" then
		return el
	end

	local tbl
	os.exit(1)
	for k,v in pairs(el.caption) do
		if v.t == "Str" and v.text == "{.long}" then
			table.remove(el.caption, k)
			--table.print(el.caption)
		end
	end
	table.print(el)
	return el
end