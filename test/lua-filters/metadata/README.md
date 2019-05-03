# Merge metadata from file
This filter causes metadata defined in an external file (metadata-file.yaml) to be used as default values in a document’s metadata:

## ??

https://github.com/annProg/PanBook/issues/8

???? pandoc-crossref ??????,??pandoc-crossref?? metadata ?? header-includes,pandoc?????-H/--include-in-header????metadata???

- https://groups.google.com/d/msg/pandoc-discuss/N6WhlmSPXbY/X595i29QAgAJ
- https://lierdakil.github.io/pandoc-crossref/#latex-output-and---include-in-header

???? `-H`??,??`lua-filter`???`tex`????`header-includes`??

## ??

- ????`tex`??(?????????,???????)
- ??????????`meta yaml`??
- `table.insert`?????`header-includes`??`header-includes`

```lua
local headers,err = io.open('headers.tex', 'rb')

if err ~= nil then
	return 
end

local header = headers:read("*a")
headers:close()

-- ?header??meta yaml??
header = '---\nheader-includes:\n  - |\n    ' .. string.gsub(header, '\n', '\n    ') .. '\n...'
custom_header = pandoc.read(header, "markdown").meta

return {
	{
		Meta = function(meta)
			for k, v in pairs(custom_header) do
				if meta[k] == nil then
					meta[k] = v
				else
					table.insert(meta[k], v[1][1])
				end
			end
			return meta
		end,
	}
}
```