function Span(el)
	if el.attr.classes[1] == "grade" then
		return pandoc.RawInline("latex", "\\grade" .. el.content[1].text)
	end
end