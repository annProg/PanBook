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

local headers,err = io.open('add-headers.tex', 'rb')

if err ~= nil then
	print(err)
	return 
end

local header = headers:read("*a")

headers:close()

-- 空字符串直接退出
if string.len(header) == 0 then
	return
end

-- 将header拼成meta yaml格式 -- 改为直接创建rawblock
-- header = '---\nheader-includes:\n  - |\n    ' .. string.gsub(header, '\n', '\n    ') .. '\n...'
custom_header = pandoc.MetaBlocks({pandoc.RawBlock("latex", header)})

return {
	{
		Meta = function(meta)
			k='header-includes'
			if meta[k] == nil then
				meta[k] = {custom_header}
			else
				-- MetaBlock和MetaList处理方式不同
				t = meta[k].tag
				if t == "MetaList" then
					meta[k][#meta[k]+1] = custom_header
				else
					table.insert(meta[k], custom_header)
				end
			end
			return meta
		end,
	}
}
