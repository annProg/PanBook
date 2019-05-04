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

function setAttr(attr)
	if attr == nil then
		return ""
	else
		return attr
	end
end

function Pandoc(doc)
	local nblocks = {}
	local nel = {}
	for i,el in pairs(doc.blocks) do
		local addEl = nil
		if el.t == "Header" and el.level == 1 then
			nel = pandoc.RawBlock("latex", "\\section{" .. el.content[1]['text'] .. "}")
		elseif el.t == "Header" and el.level == 2 then
			local entry = el.content[1]['text']
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
			if i > 1 and doc.blocks[i-1].t == "Header" and doc.blocks[i-1].level == 2 then
				addEl = pandoc.RawBlock("latex", "}")
			end
			nel = el
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