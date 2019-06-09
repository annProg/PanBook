---[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]

--[[
1. 通过 -M 参数 传递 分隔符，默认使用 %（分隔符左右须有空格）
2. 以 moderncv 语法为蓝本，除标题外都转换为Div
3. 其他模板尽量用 newcommand的形式兼容 moderncv 语法，减少lua代码量
4. 列表cat用中文或者英文冒号为分隔符（分隔符左右无空格）

section: 大标题
subsection: 二级标题
cventry: 经历项
cvitem：带类别列表
cvlistitem: 普通列表
cvlistdoubleitem: 双列列表
cvdoubleitem: 带类别双列列表
cvcolumns: 分栏
cvitemwithcomment: 带评论列表
letter: cover letter
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

function getValue(key, val)
	if key ~= nil then
		return key
	else
		return val
	end
end

function cventryAttr(el, sep)
	local cventrySep = {"date", "main", "title", "tag", "desc"}
	local para = pandoc.Para({})
	local span = pandoc.Span({})
	local index = 1
	span.attr.classes[1] = cventrySep[index]
	for k,v in pairs(el) do
		if v.t == "Space" and k+2 <= #el and el[k+1].text ==  sep and el[k+2].t == "Space" then
			table.insert(para.content, span)
			index = index + 1
			span = pandoc.Span({})
			span.attr.classes[1] = cventrySep[index]
			table.remove(el, k+1)
			table.remove(el, k+1)
		else
			table.insert(span.content, v)
			if k == #el then
				table.insert(para.content, span)
			end
		end
	end

	local ret = {}
	for k,v in pairs(para.content) do
		ret[v.attr.classes[1]] = getText(v.content)
	end
	return ret
end

function cvlist(el)
	
end

function Pandoc(doc)
	local sep = getValue(doc.meta.cvsep, "%")
	local nblocks = {}
	local attr = {}
	attr.identifier = ""

	for k,v in pairs(doc.blocks) do
		if v.t == "Header" and v.level == 3 then
			local cventry = pandoc.Div({})
			cventry.attr.classes[1] = "cventry"
			cventry.attr.attributes = cventryAttr(v.content, sep)
			for i=k+1,#doc.blocks do
				if i <= #doc.blocks and (doc.blocks[i].t == "Header" or doc.blocks[i].t == "Div") then
					break
				else
					table.insert(cventry.content, doc.blocks[i])
					table.remove(doc.blocks, i)
				end
			end
			table.insert(nblocks, cventry)
		elseif v.t == "BulletList" then
			for i,j in pairs(v.content) do
				table.insert(nblocks, cvlist(j))
			end
		elseif v.t == "Div" and v.attr.classes[1] == "letter" then
			--table.insert(nblocks, letter(v))
		elseif v.t == "Div" and v.attr.classes[1] == "columns" then
			--table.insert(nblocks, cvcolumn(v)) 
		else
			table.insert(nblocks, v)
		end
	end
	table.print(nblocks)
end