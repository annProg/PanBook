---[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]

-- 打印警告信息
function printWarn(text)
	print("\nModerncv Warning!\n" .. text .. "\nPlease Check\n\n")
end

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
		elseif v.t == "Header" and v.level == 1 then
			table.insert(newcite.content, pandoc.RawBlock("latex", "\\section{" .. getText(v.content) .. "}"))
		else
		end
	end
	return newcite
end

-- 一级标题后的列表转为cvlistitem
-- 此函数可能可以优化，不需要getText，定义一个空的Div table，把元素加进去更好
function cvlist(list)
	local nlist = pandoc.Div({})
	for k,v in pairs(list.content) do
		local spanCount = 0
		local item = pandoc.Plain({})
		local comment = pandoc.Plain({})
		local cat = {}
		local double = {}
		for i,val in pairs(v[1].content) do
			if val.t == "Span" then
				spanCount = spanCount + 1
				if #val.attr.classes > 0 then
					if val.attr.classes[1] == "comment" then
						table.insert(comment.content, val)
					end
					if val.attr.classes[1] == "cat" then
						table.insert(cat, getText(val.content))
					end
					if val.attr.classes[1] == "double" then
						table.insert(double, pandoc.Plain({val}))
					end
				end
			else
				table.insert(item.content, val)
			end
		end
		
		-- \cvitemwithcomment 优先级最高
		if spanCount == 2 and next(comment.content) ~= nil and #cat > 0 then
			table.insert(nlist.content, pandoc.RawBlock("latex", "\\cvitemwithcomment{" .. cat[1] .. "}{"))
			table.insert(nlist.content, item)
			table.insert(nlist.content, pandoc.RawBlock("latex", "}{"))
			table.insert(nlist.content, comment)
			table.insert(nlist.content, pandoc.RawBlock("latex", "}"))
		elseif spanCount == 1 and #cat == 1 then
			table.insert(nlist.content, pandoc.RawBlock("latex", "\\cvitem{" .. cat[1] .. "}{"))
			table.insert(nlist.content, item)
			table.insert(nlist.content,pandoc.RawBlock("latex","}"))
		elseif spanCount >= 2 and #cat >= 1 and #double >= 1 and spanCount < 5 then
			table.insert(nlist.content, pandoc.RawBlock("latex", "\\cvdoubleitem{" .. cat[1] .. "}{"))
			table.insert(nlist.content, double[1])
			table.insert(nlist.content, pandoc.RawBlock("latex", "}{" .. getValue(cat[2], "") .. "}{"))
			table.insert(nlist.content, getValue(double[2], pandoc.Plain({})))
			table.insert(nlist.content, pandoc.RawBlock("latex", "}"))
		elseif spanCount == 2 and #cat == 0 and #double == 2 then
			table.insert(nlist.content, pandoc.RawBlock("latex", "\\cvlistdoubleitem{"))
			table.insert(nlist.content, double[1])
			table.insert(nlist.content, pandoc.RawBlock("latex", "}{"))
			table.insert(nlist.content, double[2])
			table.insert(nlist.content, pandoc.RawBlock("latex", "}"))			
		else
			table.insert(nlist.content, pandoc.RawBlock("latex", "\\cvlistitem{"))
			-- 如果以上都不满足，按普通列表，远样返回
			table.insert(nlist.content, v[1])
			table.insert(nlist.content, pandoc.RawBlock("latex", "}"))
		end
		
		if spanCount > 4 then
			printWarn("You use more than 4 bracketed_spans in one list item. May cause unexpect result")
		end
	end
	
	return nlist
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

function getValue(v, d)
	if v ~= nil then
		return v
	else
		return d
	end
end

-- 求职信
local letterMeta = 0   -- recipient, opening, closing 都设置才能添加求职信
function letter(el)
	local rawtex = ""
	if el.level == 1 then
		rawtex = "\n\\clearpage\n\\recipient{" .. getText(el.content) .. "}{" .. getValue(el.attr.attributes.company, "Please set company attr") .. "\\\\" .. getValue(el.attr.attributes.addr, "Please set addr attr") .. "\\\\" .. getValue(el.attr.attributes.city, "Please set city attr") .. "}"
		letterMeta = letterMeta + 1
	elseif el.attr.classes[2] == "date" then
		rawtex = "\\date{" .. getText(el.content) .. "}"
	elseif el.attr.classes[2] == "opening" then
		rawtex = "\\opening{" .. getText(el.content) .. "}"
		letterMeta = letterMeta + 1
	elseif el.attr.classes[2] == "closing" then
		rawtex = "\\closing{" .. getText(el.content) .. "}"
		letterMeta = letterMeta + 1
	elseif el.attr.classes[2] == "enclosure" then
		rawtex = "\\enclosure[" .. getValue(el.attr.attributes.enclosure, "Enclosure") .. "]{" .. getText(el.content) .. "}"
	else
	end
	
	return pandoc.RawBlock("latex", rawtex)
end

function cventry(el,meta,bracket)
	local entry = pandoc.Plain({})
	local dt = ""
	local title = ""
	local tag = ""
	local desc = ""
	
	for k,v in pairs(el.content) do
		if v.t == "Str" then
			table.insert(entry.content, v)
		elseif v.t == "Span" then
			if v.attr.classes[1] == "date" then
				dt = getText(v)
			elseif v.attr.classes[1] == "title" then
				title = getText(v)
			elseif v.attr.classes[1] == "tag" then
				tag = getText(v)
			elseif v.attr.classes[1] == "desc" then
				desc = getText(v)
			else
				table.insert(entry.content, v)
			end
		else
			table.insert(entry.content, v)
		end
	end
	
	entry = getText(entry)
	
	local tmp
	if meta.style == "banking" then
		tmp = entry
		entry = title
		title = tmp
	end
	return pandoc.RawBlock("latex", "\\cventry{" .. dt .. "}{" .. entry .. "}{" .. title .. "}{" .. tag .. "}{" .. desc .. "}{" .. bracket)
end

function Pandoc(doc)
	local nblocks = {}
	local inletter = nil
	local letterContent = pandoc.Div({})
	table.insert(letterContent.content, pandoc.RawBlock("latex", "\\makelettertitle\n\\setlength{\\parindent}{2em}"))
	for i,el in pairs(doc.blocks) do
		local addEl = nil
		local nel = pandoc.Null()
		if el.t == "Header" and el.attr.classes[1] == "letter" then
			inletter = true
			nel = letter(el)
		elseif el.t ~= "Header" and inletter ~= nil then
			table.insert(letterContent.content, el)
			-- 显式分段 module-cv.sh 中会删除所有空行
			if el.t == "Para" then
				table.insert(letterContent.content, pandoc.RawBlock("latex", "\\par"))
			end
		-- 带label的section和subsection会影响fancy样式显示，所以手动转一下
		elseif el.t == "Header" and el.level == 1 and inletter == nil then
			nel = pandoc.RawBlock("latex", "\\section{" .. getText(el.content) .. "}")
		elseif el.t == "Header" and el.level == 2 and inletter == nil then
			nel = pandoc.RawBlock("latex", "\\subsection{" .. getText(el.content) .. "}")
		elseif el.t == "Header" and el.level == 3 and inletter == nil then
			local bracket = ""
			if i+1 <= #doc.blocks and doc.blocks[i+1].t ~= "BulletList" then
				bracket = "}"
			end	
			nel = cventry(el, doc.meta, bracket)
		elseif el.t == "BulletList" and inletter == nil then
			if i > 1 and doc.blocks[i-1].t == "Header" and doc.blocks[i-1].level == 3 then
				addEl = pandoc.RawBlock("latex", "}")
				nel = el
			else
				nel = cvlist(el)
			end
		elseif el.t == "Div" and el.attr.identifier == "refs" and inletter == nil then
			nel = citeproc(el)
		elseif el.t == "Div" and el.attr.classes[1] == "cvcolumns" and inletter == nil then
			nel = cvcolumns(el)
		else
			nel = el
		end
		table.insert(nblocks, nel)
		
		if addEl ~= nil then
			table.insert(nblocks, addEl)
		end
	end
	
	table.insert(letterContent.content, pandoc.RawBlock("latex", "\\setlength{\\parindent}{0em}\\makeletterclosing"))
	
	if letterMeta == 3 then
		table.insert(nblocks, letterContent)
	elseif letterMeta > 0 and letterMeta < 3 then
		printWarn("If you want to use letter, you need to provide recipient, opening and closing")
	else
	end
	
	return pandoc.Pandoc(nblocks, doc.meta)
end