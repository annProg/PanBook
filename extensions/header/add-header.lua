--[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]

function get_header(build_id)
	local headers,err = io.open('add-headers/' .. build_id .. '.tex', 'rb')
	if err ~= nil then
		print(err)
		os.exit(1) 
	end
	local header = headers:read("*a")
	headers:close()
	-- 空字符串直接退出
	if string.len(header) == 0 then
		return
	end
	-- 将header拼成meta yaml格式 -- 改为直接创建rawblock
	-- header = '---\nheader-includes:\n  - |\n    ' .. string.gsub(header, '\n', '\n    ') .. '\n...'
	return pandoc.RawBlock("latex", string.gsub(header,'\r\n','\n'))
end

return {
	{
		Meta = function(meta)
			local custom_header = get_header(meta['build_id'])
			k='header-includes'
			if meta[k] == nil then
				meta[k] = pandoc.MetaBlocks({custom_header})
			else
				-- MetaBlock和MetaList处理方式不同
				t = meta[k].tag
				if t == "MetaList" then
					meta[k][#meta[k]+1] = pandoc.MetaBlocks({custom_header})
				else
					table.insert(meta[k], custom_header)
				end
			end
			return meta
		end,
	}
}
