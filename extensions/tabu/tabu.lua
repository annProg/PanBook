--[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]

if FORMAT ~= "latex" and FORMAT ~= "tex" and FORMAT ~= "pdf" then
	return {}
end

-- 以 `{.long} `（注意有空格）开头的caption 认为是 longtable
-- 由于pandoc-crossref 会添加 \label，{.long}是第二个元素
function checkLongtabu(caption)
	if #caption >= 2 and caption[2].text == "{.longtabu}" then
		return 1
	elseif #caption >= 2 and caption[2].text == "{.longtable}" then
		print("with {.longtable} ... [SKIP]")
		return 2  -- 用 pandoc 原生表格
	else
		return 0
	end
end

-- tabu
function tabu(tbl, longtable, caption)
	local macro = "\\begin{tabu}"
	local macroEnd = "\\end{tabu}"
	if longtable then
		macro = "\\begin{longtabu}"
		macroEnd = "\\end{longtabu}"
	end

	local xcolumn = ""

	for k,v in pairs(tbl.widths) do
		local width = string.format("%.2f", v * 10) -- 保留2为小数，位数太多 latex 会报错
		if v == 0.0 then
			width = 1
		end

		local align = "l"

		if tbl.aligns[k] == "AlignRight" then
			align = "r"
		elseif tbl.aligns[k] == "AlignCenter" then
			align = "c"
		else
		end

		xcolumn = xcolumn .. "X[" .. width .. "," .. align .. "]"
	end

	tbltop = pandoc.RawBlock("latex", macro .. "{" .. xcolumn .. "}\n")
	toprule = pandoc.RawBlock("latex", "\\toprule\n")

	column = #tbl.headers
	row = #tbl.rows

	local newtbl = {}
	if #caption > 0 then
		local cappre = pandoc.RawBlock("latex", "\\caption{")
		local cap = pandoc.Para({})
		cap.content = caption
		local capend = pandoc.RawBlock("latex", "}\\tabularnewline\n")
		if longtable then
			newtbl = {tbltop, cappre, cap, capend}
		else
			newtbl = {cappre, cap, capend, tbltop}
		end
	else
		newtbl = {tbltop}
	end

	table.insert(newtbl, toprule)
	local cline = pandoc.RawBlock("latex", " & ")
	local hline = pandoc.RawBlock("latex", " \\\\\n")

	local nohead = true
	for k,v in pairs(tbl.headers) do
		if #v > 0 then
			nohead = false
			break
		end
	end

	if not nohead then
		for k=1,column do
			for i,val in pairs(tbl.headers[k]) do
				table.insert(newtbl, val)
			end
			if k<column then
				table.insert(newtbl, cline)
			end
		end
		table.insert(newtbl, hline)
		table.insert(newtbl, pandoc.RawBlock("latex", " \\midrule\n"))
	end

	for k=1,row do
		for j=1,column do
			for i,val in pairs(tbl.rows[k][j]) do
				table.insert(newtbl, val)
			end
			if j<column then
				table.insert(newtbl, cline)
			end
		end
		table.insert(newtbl, hline)
	end

	tblbottom = pandoc.RawBlock("latex", "\\bottomrule\n" .. macroEnd)
	table.insert(newtbl, tblbottom)

	newtbl = pandoc.utils.blocks_to_inlines(newtbl, {})
	
	newtblBlock = pandoc.Para({})
	newtblBlock.content = newtbl
	return newtblBlock
end

function renderTabu(el)
	-- pandoc-crossref 使用 id 前缀为 tbl: 的 Div
	if el.t == "Div" and not string.match(el.attr.identifier, '^tbl:.*') then
		return el
	end

	-- 确保为 Table
	if el.t == "Div" and el.content[1].t ~= "Table" then
		return el
	end

	-- 新建一个 Div. 对于 tabu ，需要在将 Div 放入 table 和 center 环境
	-- 对于 longtabu，则不需要新 Div
	local newblock = pandoc.Div({})
	local wrapBlock = pandoc.Div({})
	if el.t == "Div" then
		newblock.attr.identifier = el.attr.identifier
	end

	local longtable, tbl, caption

	if el.t == "Div" then
		tbl = el.content[1]
		caption = el.content[1].caption
		longtable = checkLongtabu(caption)
	elseif el.t == "Table" then
		tbl = el
		caption = tbl.caption
		longtable = checkLongtabu(caption)
	else
	end

	if longtable == 0 then
		if #caption > 0 then
			table.insert(wrapBlock.content, pandoc.RawBlock("latex", "\\begin{table}\n\\begin{center}"))
			table.insert(newblock.content, tabu(tbl, false, caption))
		else
			-- 没有 caption 的表格用 longtabu，防止换页问题
			table.insert(newblock.content, tabu(tbl, true, caption))
		end
		table.insert(wrapBlock.content, newblock)
		if #caption > 0 then
			table.insert(wrapBlock.content, pandoc.RawBlock("latex", "\\end{center}\n\\end{table}"))
		end
		return wrapBlock
	elseif longtable == 1 then
		caption[2] = pandoc.Str("")
		table.insert(newblock.content, tabu(tbl, true, caption))
		return newblock
	elseif longtable == 2 then
		if el.t == "Div" then
			el.content[1].caption[2] = pandoc.Str("")
		else
			el.caption[2] = pandoc.Str("")
		end
		return el
	else
		return el
	end
end

function Pandoc(doc)
	local newblock = {}
	for k,el in pairs(doc.blocks) do
		if el.t == "Div" or el.t == "Table" then
			el = renderTabu(el)
		end
		table.insert(newblock, el)
	end
	return pandoc.Pandoc(newblock, doc.meta)
end