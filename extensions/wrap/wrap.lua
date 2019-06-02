--[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]
local wrapClass = {'info', 'tip', 'warn', 'alert', 'help'}
local wrapOptClass = {'introduction', 'problemset'}

function inTable(t, val)
	for _, v in pairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

function wrap(el, option)
	e = el.attr.classes[1]
	ret = pandoc.Div({})
	table.insert(ret.content, pandoc.RawBlock("latex", "\\begin{" .. e .. "}" .. option))
	for k,v in pairs(el.content) do
		table.insert(ret.content, v)
	end
	table.insert(ret.content, pandoc.RawBlock("latex", "\\end{" .. e .. "}"))
	return ret
end

function Div(el)
	if inTable(wrapClass, el.attr.classes[1]) then
		return wrap(el, "")
	end

	if inTable(wrapOptClass, el.attr.classes[1]) then
		if el.attr.attributes['caption'] ~= nil then
			option = "[" .. el.attr.attributes['caption'] .. "]"
		else
			option = ""
		end
		return wrap(el, option)
	end
end