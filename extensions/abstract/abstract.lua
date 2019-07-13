function Div(el)
	if el.attr.classes[1] == "abstract" then
		local ret = pandoc.Div({})
		local abstract = "\\begin{abstract}"
		if el.attr.classes[2] == "e" then
			abstract = abstract .. "{e}"
		else
			abstract = abstract .. "{c}"
		end

		if el.attr.attributes["keywords"] ~= nil then
			abstract = abstract .. "{" .. el.attr.attributes["keywords"] .. "}"
		end
		table.insert(ret.content, pandoc.RawBlock("latex", abstract))
		table.insert(ret.content, el)
		table.insert(ret.content, pandoc.RawBlock("latex", "\\end{abstract}"))
		return ret
	end
end