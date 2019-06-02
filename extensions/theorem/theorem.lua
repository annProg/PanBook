---[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]
local theoremClass = {'definition', 'theorem', 'lemma', 'corollary', 'proposition'}
local theoremPrefix = {def='definition', thm='theorem', lem='lemma', cor='corollary', pro='proposition'}
local mathClass = {'example', 'exercise', 'problem', 'proof', 'note', 'conclusion', 'assumption', 'property', 'remark', 'solution'}

function inTable(t, val)
	for _, v in pairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

function table.keys( t )
    local keys = {}
    for k, _ in pairs( t ) do
        keys[#keys + 1] = k
    end
    return keys
end

function Theorem(el, option)
	e = el.attr.classes[1]
	ret = pandoc.Para({})
	table.insert(ret.content, pandoc.RawInline("latex", "\\begin{" .. e .. "}" .. option .. "\n"))
	for k,v in pairs(el.content) do
		for i,val in pairs(v.content) do
			table.insert(ret.content, val)
		end
	end
	table.insert(ret.content, pandoc.RawInline("latex", "\n\\end{" .. e .. "}"))
	return ret
end

function Div(el)
	if inTable(mathClass, el.attr.classes[1]) then
		return Theorem(el, "")
	end

	if inTable(theoremClass, el.attr.classes[1]) then
		if el.attr.identifier ~= "" then
			label = string.gsub(el.attr.identifier, '%a+:', '')
		else
			label = "random" .. math.random(10000,99999)
		end
		if el.attr.attributes['caption'] ~= nil then
			caption = el.attr.attributes['caption']
		else
			caption = el.attr.classes[1]
		end
		option = "{" .. caption .. "}{" .. label .. "}"
		return Theorem(el,option)
	end
end

function Cite(el)
	prefixs = table.keys(theoremPrefix)
	citeId = el.citations[1]['id']
	citePrefix = string.gsub(citeId, ":%a+", "")
	if inTable(prefixs, citePrefix) then
		return pandoc.RawInline("latex", "\\" .. theoremPrefix[citePrefix] .. "Title~\\ref{" .. citeId .. "}")
	end
end