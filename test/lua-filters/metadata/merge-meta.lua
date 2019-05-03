-- read metadata file into string
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
local metafile,err = io.open('metadata-file.yaml', 'r')
local headers,err2 = io.open('headers.tex', 'rb')

local inspect = require 'inspect'

if err ~= nil or err2 ~= nil then
	return 
end

local content = metafile:read("*a")
local header = headers:read("*a")

metafile:close()
headers:close()
-- get metadata
local default_meta = pandoc.read(content, "markdown").meta

-- 将header拼成meta yaml格式
header = '---\nheader-includes:\n  - |\n    ' .. string.gsub(header, '\n', '\n    ') .. '\n...'
custom_header = pandoc.read(header, "markdown").meta

--print(inspect(pandoc.Meta({['type']='RawBlock', ["format"]='tex', ['text']='\\newcommand{\\lishu}{\\LiSu}'})))
--os.exit(0)

return {
  {
    Meta = function(meta)
      -- use default metadata field if it hasn't been defined yet.

      for k, v in pairs(default_meta) do
		-- print(k)
        if meta[k] == nil then
          meta[k] = v
        end
		
		if k == 'header-includes' and custom_header ~= nil then
			table.insert(meta[k], custom_header['header-includes'][1])
			
			for key,val in pairs(meta[k]) do
				print(key)
				for i,vv in pairs(val) do
					print(i)
					for j,vvv in pairs(vv) do
						print(j)
						print(vvv)
					end
				end
			end
		end
      end
	  table.print(meta)
      return meta
    end,
  }
}