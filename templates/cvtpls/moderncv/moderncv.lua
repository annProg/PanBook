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

function Header(block)
    if block.level == 1 then
        return pandoc.RawBlock("latex", "\\section{" .. block.content[1]['text'] .. "}")
    end
	
	-- table.print(block)
	if block.level == 2 then
		local entry = block.content[1]['text']
		local dt = setAttr(block.attr.attributes.date)
		local title = setAttr(block.attr.attributes.title)
		local city = setAttr(block.attr.attributes.city)
		local score = setAttr(block.attr.attributes.score)
		return pandoc.RawBlock("latex", "\\cventry{" .. dt .. "}{" .. title .. "}{" .. entry .. "}{" .. city .. "}{" .. score .. "}")
	end
end