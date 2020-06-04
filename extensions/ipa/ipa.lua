function Span(el)
	if el.attr.classes[1] == "ipa" then
		if FORMAT == "tex" or FORMAT == "latex" or FORMAT == "pdf" then
			return {
				pandoc.RawInline("latex","\\ipa"),
				el
			}
		end
	end
end