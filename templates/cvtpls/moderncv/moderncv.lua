--[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]

-- 获取一个table的所有text
function getText(content)
	local newcontent = ""
	if type(content) ~= "table" then
		return newcontent
	end

	for k,v in pairs(content) do
		if v.t == "Strong" then
			newcontent = newcontent .. "\\textbf{" .. getText(v) .. "}"
		elseif v.t == "Code" then
			newcontent = newcontent .. "\\passthrough{\\lstinline!" .. v.text .. "!}"
		elseif v.t == "Space" then
			newcontent = newcontent .. " "
		elseif v.text ~= nil then
			newcontent = newcontent .. v.text
		else
			newcontent = newcontent .. getText(v)
		end
	end
	
	return newcontent
end

function setAttr(attr)
	if attr == nil then
		return ""
	else
		return attr
	end
end

function citeproc(cite)
	local newcite = pandoc.Div({}, cite.attr)
	for k,v in pairs(cite.content) do
		if v.t == "Div" then
			table.insert(newcite.content, pandoc.RawBlock("latex", "\\cvlistitem{"))
			table.insert(newcite.content, v)
			table.insert(newcite.content, pandoc.RawBlock("latex", "}"))
		else
			table.insert(newcite.content, v)
		end
	end
	return newcite
end

-- 一级标题后的列表转为cvlistitem
-- 此函数可能可以优化，不需要getText，定义一个空的Div table，把元素加进去更好
function cvlistitem(list)
	local content = ""
	for k,v in pairs(list.content) do
		content = content .. "\\cvlistitem{" .. getText(v) .. "}\n"
	end
	return pandoc.RawBlock("latex", content)
end

function cvcolumns(el)
	local nblocks = pandoc.Div({})
	table.insert(nblocks.content, pandoc.RawBlock("latex", "\\begin{cvcolumns}"))
	
	for k,v in pairs(el.content) do
		if v.t == "Div" and v.attr.classes[1] == "cvcolumn" then
			local cat = "Cat"
			if v.attr.attributes.cat ~= nil then
				cat = v.attr.attributes.cat
			end
			table.insert(nblocks.content, pandoc.RawBlock("latex", "\\cvcolumn{" .. cat .. "}{"))
			for j,val in pairs(v.content) do
				table.insert(nblocks.content, val)
			end
			table.insert(nblocks.content, pandoc.RawBlock("latex", "}"))
		else
			table.insert(nblocks.content, v.content)
		end
	end
	table.insert(nblocks.content, pandoc.RawBlock("latex", "\\end{cvcolumns}"))
	
	return nblocks
end

function Pandoc(doc)
	local nblocks = {}
	local nel = {}
	for i,el in pairs(doc.blocks) do
		local addEl = nil
		if el.t == "Header" and el.level == 1 then
			nel = pandoc.RawBlock("latex", "\\section{" .. getText(el.content) .. "}")
		elseif el.t == "Header" and el.level == 2 then
			nel = pandoc.RawBlock("latex", "\\subsection{" .. getText(el.content) .. "}")
		elseif el.t == "Header" and el.level == 3 then
			local entry = getText(el.content)
			local dt = setAttr(el.attr.attributes.date)
			local title = setAttr(el.attr.attributes.title)
			local city = setAttr(el.attr.attributes.city)
			local score = setAttr(el.attr.attributes.score)
			local bracket = ""
			if i+1 <= #doc.blocks and doc.blocks[i+1].t ~= "BulletList" then
				bracket = "}"
			end
			nel = pandoc.RawBlock("latex", "\\cventry{" .. dt .. "}{" .. title .. "}{" .. entry .. "}{" .. city .. "}{" .. score .. "}{" .. bracket)
		elseif el.t == "BulletList" then
			if i > 1 and doc.blocks[i-1].t == "Header" and doc.blocks[i-1].level == 3 then
				addEl = pandoc.RawBlock("latex", "}")
				nel = el
			else
				nel = cvlistitem(el)
			end
		elseif el.t == "Div" and el.attr.identifier == "refs" then
			nel = citeproc(el)
		elseif el.t == "Div" and el.attr.classes[1] == "cvcolumns" then
			nel = cvcolumns(el)
		else
			nel = el
		end
		table.insert(nblocks, nel)
		
		if addEl ~= nil then
			table.insert(nblocks, addEl)
		end
	end
	return pandoc.Pandoc(nblocks, doc.meta)
end