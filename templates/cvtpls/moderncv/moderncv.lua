function print_r ( t )
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end

table.print = print_r

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
function cvlistitem(list)
	local content = ""
	for k,v in pairs(list.content) do
		content = content .. "\\cvlistitem{" .. getText(v) .. "}\n"
	end
	return pandoc.RawBlock("latex", content)
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