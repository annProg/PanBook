--[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]

-- 打印警告信息
function printWarn(text)
	print("\nResume Warning!\n" .. text .. "\nPlease Check\n\n")
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
			table.insert(newcite.content, v)
		elseif v.t == "Header" and v.level == 1 then
			table.insert(newcite.content, pandoc.RawBlock("latex", "\\section{" .. getText(v.content) .. "}"))
		else
		end
	end
	return newcite
end

-- resume没有专门的list语法，因此只需要把cat样式的替换为加粗即可
function cvlist(list)
	local nlist = pandoc.Div({})
	for k,v in pairs(list.content) do
		for i,val in pairs(v[1].content) do
			local item = pandoc.Plain({})
			if val.t == "Span" and val.attr.classes[1] == "cat" then
				table.insert(item.content, {
					pandoc.RawBlock("latex", "\\textbf{"),
					val,
					pandoc.RawBlock("latex", "}")
				})
			else
				table.insert(item.content, val)
			end
		end
		
		table.insert(nlist.content, item)
	end
	
	return nlist
end

function getWidth(width, count)
	if width ~= nil then
		width = string.match(width, "(%d+)%%$")
	end
	if width ~= nil then	
		return width/100
	else
		return 1/count
	end
end

function cvcolumns(el)
	local nblocks = pandoc.Div({})
	table.insert(nblocks.content, pandoc.RawBlock("latex", "\\begin{columns}[T]"))
	
	-- column数量
	local count = #el.content
	for k,v in pairs(el.content) do
		if v.t == "Div" and v.attr.classes[1] == "cvcolumn" then
			local cat = "Cat"
			if v.attr.attributes.cat ~= nil then
				cat = v.attr.attributes.cat
			end
			table.insert(nblocks.content, pandoc.RawBlock("latex", "\\begin{column}{" .. getWidth(v.attr.attributes.width, count) .. "\\textwidth}"))
			table.insert(nblocks, pandoc.RawBlock("latex", "\\subsection{" .. cat .. "}\n"))
			for j,val in pairs(v.content) do
				table.insert(nblocks.content, val)
			end
			table.insert(nblocks.content, pandoc.RawBlock("latex", "\\end{column}"))
		else
			table.insert(nblocks.content, v.content)
		end
	end
	table.insert(nblocks.content, pandoc.RawBlock("latex", "\\end{columns}"))
	
	return nblocks
end

function getValue(v, d)
	if v ~= nil and v ~= "" then
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

function letterHeader(meta)
	local header = ""
	
	header = "\\name{" .. getValue(string.gsub(getText(meta.name)," ","~"), "Your Name") .. "}\n\\basicInfo{"
		.. "\\email{" .. getValue(getText(meta.email), "you@qq.com") .. "} \\textperiodcentered\\ \n"
		.. "\\phone{" .. getValue(getText(meta.mobile), "13000000000") .. "}}\n\\vspace{1cm}\n"
		
	return header	
end

function Pandoc(doc)
	local nblocks = {}
	local inletter = nil
	local letterContent = pandoc.Div({})
	table.insert(letterContent.content, pandoc.RawBlock("latex", letterHeader(doc.meta) .. "\\makelettertitle\n\\setlength{\\parindent}{2em}"))
	for i,el in pairs(doc.blocks) do
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
			local entry = getText(el.content)
			local dt = setAttr(el.attr.attributes.date)
			local title = setAttr(el.attr.attributes.title)
			local city = setAttr(el.attr.attributes.city)
			local score = setAttr(el.attr.attributes.score)
			nel = pandoc.RawBlock("latex", "\\datedsubsection{\\textbf{" .. entry .. "}, " .. city .. "}{" .. dt .. "}\n\\textit{" .. title .. "}\\ " .. score .. "\n")
		elseif el.t == "BulletList" and inletter == nil then
			if i > 1 and doc.blocks[i-1].t == "Header" and doc.blocks[i-1].level == 3 then
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
	end
	
	table.insert(letterContent.content, pandoc.RawBlock("latex", "\\makeletterclosing"))
	
	if letterMeta == 3 then
		table.insert(nblocks, letterContent)
	elseif letterMeta > 0 and letterMeta < 3 then
		printWarn("If you want to use letter, you need to provide recipient, opening and closing")
	else
	end
	
	return pandoc.Pandoc(nblocks, doc.meta)
end