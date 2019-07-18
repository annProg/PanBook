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
	if #caption >= 2 and caption[2] == "{.longtabu}" then
		return true
	elseif #caption >= 2 and caption[2] == "{.longtable}" then
		os.exit(0)  -- 用 pandoc 原生表格
	else
		return false
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

	tbltop = pandoc.RawBlock("latex", macro .. "{" .. xcolumn .. "}\n\\toprule\n")

	column = #tbl.headers
	row = #tbl.rows

	local newtbl = {}
	if caption then
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

	local cline = pandoc.RawBlock("latex", " & ")
	local hline = pandoc.RawBlock("latex", " \\\\\n")

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
	if el.t == "Div" then
		newblock.attr.identifier = el.attr.identifier
	end

	local longtable = false
	local tbl = el
	local caption = nil

	if el.t == "Div" then
		tbl = el.content[1]
		caption = el.content[1].caption
		longtable = checkLongtabu(caption)
	end

	if not longtable then
		table.insert(newblock.content, pandoc.RawBlock("latex", "\\begin{table}\n\\begin{center}"))
		table.insert(newblock.content, tabu(tbl, false, caption))
		table.insert(newblock.content, pandoc.RawBlock("latex", "\\end{center}\n\\end{table}"))
	else
		table.insert(newblock.content, tabu(tbl, true, caption))
	end

	return newblock
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