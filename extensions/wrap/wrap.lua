--[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]
local wrapClass = {'info', 'tip', 'warn', 'alert', 'help', 'introduction', 'problemset', 'solu'}

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
	-- introduction 和 problemset中 需要以\item开头，因此需要将 BulletList 转换为rawtex
	if e == 'introduction' or e == 'problemset' then
		for k,v in pairs(el.content) do
			if v.t == 'BulletList' then
				for i,j in pairs(v.content) do
					for l,m in pairs(j) do
						if l == 1 then
							table.insert(ret.content, pandoc.RawBlock("latex", "\\item "))
						end
						table.insert(ret.content, m)
					end
				end
			else
				table.insert(ret.content, v)
			end
		end
	else
		for k,v in pairs(el.content) do
			table.insert(ret.content, v)
		end
	end
	table.insert(ret.content, pandoc.RawBlock("latex", "\\end{" .. e .. "}"))
	return ret
end

function Div(el)
	if inTable(wrapClass, el.attr.classes[1]) then
		if el.attr.attributes['caption'] ~= nil then
			option = "[" .. el.attr.attributes['caption'] .. "]"
		else
			option = ""
		end

		-- 特殊符号转义
		option = string.gsub(option, "_", "\\_{}")
		return wrap(el, option)
	end
end