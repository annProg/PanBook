function Div(el)
	if el.attr.classes[1] == "abstract" then
		ret = pandoc.Div({})
		table.insert(ret.content, pandoc.RawBlock("latex", "\\begin{abstract}"))
		table.insert(ret.content, el)

		if el.attr.attributes["keywords"] ~= nil then
			table.insert(ret.content, pandoc.RawBlock("latex", "\\keywords{" .. el.attr.attributes["keywords"] .. "}"))
		end
		table.insert(ret.content, pandoc.RawBlock("latex", "\\end{abstract}"))
		return ret
	end
end