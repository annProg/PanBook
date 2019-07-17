---[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]

function Table(el)
	for k,v in pairs(el.caption) do
		if v.t == "Str" and v.text == "{.long}" then
			table.remove(el.caption, k)
			--table.print(el.caption)
		end
	end
	table.print(el)
	return el
end