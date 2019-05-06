local addHeader = [[
---
header-includes:
  - |
    \usepackage{keyval}
    \newlength\Colsep
    \setlength\Colsep{10pt}
    \newenvironment{columns}[1][]
    	{\vspace{.5cm}
    	 \noindent\begin{minipage}{\textwidth}}
    	{\end{minipage}\vspace{.5cm}}
    \newenvironment{column}[1]
    	{\begin{minipage}[t]{#1}}
    	{\end{minipage}}
...
]]

function getMeta(meta) 
	local custom_header = pandoc.read(addHeader, "markdown").meta
	for k, v in pairs(custom_header) do
		if meta[k] == nil then
			meta[k] = v
		else
			-- MetaBlock和MetaList处理方式不同
			t = meta[k].tag
			if t == "MetaList" then
				for i=1, #v do
					meta[k][#meta[k]+1] = v[i]
				end
			else
				table.insert(meta[k], v[1][1])
			end
		end
	end
	return meta
end

function getWidth(width)
	width = string.match(width, "(%d+)%%$")
	if width ~= nil then
		return width/100
	else
		return "0.5"
	end
end

function divColumns(el)
	local column = {}
	for k,v in pairs(el) do
		if v.t == "Div" and v.attr.classes[1] == "column" then
			if k > 1 and el[k-1].t == "Div" and el[k-1].attr.classes[1] == "column" then
				-- do nothing
			else
				table.insert(column, pandoc.RawBlock("latex", "\\begin{column}{" .. getWidth(v.attr.attributes.width) .. "\\textwidth}"))
			end
			for c,content in pairs(v.content) do
				table.insert(column, content)
			end
			
			if k+1 <= #el and el[k+1].t == "Div" and el[k+1].attr.classes[1] == "column" then
				table.insert(column, pandoc.RawBlock("latex", "\\end{column}\n\\begin{column}{" .. getWidth(el[k+1].attr.attributes.width) .. "\\textwidth}"))
			else
				table.insert(column, pandoc.RawBlock("latex", "\\end{column}"))
			end
		else
			table.insert(column, v)
		end
	end
	
	return column
end

function Pandoc(doc)
	local nblocks = {}
	for i,el in pairs(doc.blocks) do
		if el.t == "Div" and el.attr.classes[1] == "columns" then
			table.insert(nblocks, pandoc.RawBlock("latex", "\\begin{columns}"))
			for k,v in pairs(divColumns(el.content)) do
				table.insert(nblocks, v)
			end
			table.insert(nblocks, pandoc.RawBlock("latex", "\\end{columns}"))
		else
			table.insert(nblocks, el)
		end
	end
	return pandoc.Doc(nblocks, getMeta(doc.meta))
end