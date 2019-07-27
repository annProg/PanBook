--[[ only for debug
table_print = require('table_print')
table.print = table_print.print_r
--]]

-- reference: https://github.com/pandoc/lua-filters/blob/master/diagram-generator/diagram-generator.lua

function inTable(t, val)
	for _, v in pairs(t) do
		if v == val then
			return true
		end
	end
	return false
end

function table.keys( t )
    local keys = {}
    for k, _ in pairs( t ) do
        keys[#keys + 1] = k
    end
    return keys
end

function file_exists(filename)
	return os.execute("[ -f " .. filename .. " ]")
end

-- The default format is SVG i.e. vector graphics:
local filetype = "svg"
local mimetype = "image/svg+xml"

-- Check for output formats that potentially cannot use SVG
-- vector graphics. In these cases, we use a different format
-- such as PNG:
if inTable({'docx', 'pptx', 'rtf'}, FORMAT) then
	filetype = "png"
	mimetype = "image/png"
end

function writefile(filename, text)
	local file = io.open(filename, "w")
	file:write(text)
	file:close()
end

function graphviz(engine, code, filetype, fname)
	local final = pandoc.pipe(engine, {"-T" .. filetype, "-o" .. fname}, code)
	return final
end

function dot(code, filetype, fname)
	return graphviz("dot", code, filetype, fname)
end

function neato(code, filetype, fname)
	return graphviz("neato", code, filetype, fname)
end

function fdp(code, filetype, fname)
	return graphviz("fdp", code, filetype, fname)
end

function sfdp(code, filetype, fname)
	return graphviz("sfdp", code, filetype, fname)
end

function twopi(code, filetype, fname)
	return graphviz("twopi", code, filetype, fname)
end

function circo(code, filetype, fname)
	return graphviz("circo", code, filetype, fname)
end

function ditaa(code, filetype, fname, cname)
	writefile(cname, code)
	return pandoc.pipe("ditaa", {cname,fname}, code)
end

local validEngines = {
	dot = dot, 
	fdp = fdp, 
	sfdp = sfdp, 
	twopi = twopi, 
	neato = neato, 
	circo = circo, 
	ditaa = ditaa, 
	gnuplot = gnuplot
}

local renderDir = "_plot_render"
if not os.execute("[ -d " .. renderDir .. " ]") then
	os.execute("mkdir " .. renderDir)
end

function CodeBlock(block)
	if block.attr.classes[1] == nil then
		return block
	end
	
	-- valid engine
	local engine = string.gsub(block.attr.classes[1], 'plot:', '')
	if not inTable(table.keys(validEngines), engine) then
		return block
	end

	-- 有些engine不支持svg
	if inTable({"ditaa"}, engine) then
		filetype = "png"
		mimetype = "image/png"	
	end
	
	local sha1file = renderDir .. "/" .. pandoc.sha1(block.text) .. "_" ..engine
	local fname = sha1file .. "." .. filetype
	local cname = sha1file .. ".txt"

	-- 如果文件存在，可以不用再次渲染
	if file_exists(fname) then
		print("Plot Cache Hit: " .. fname)
	else
		local success, img = pcall(validEngines[engine], block.text, filetype, fname, cname, block.attributes["additionalPackages"] or nil)

		-- Was ok?
		if not success or not file_exists(fname) then
			-- an error occured; img contains the error message
			io.stderr:write(tostring(img))
			io.stderr:write('\n')
			error 'Image conversion failed. Aborting.'
		end
	end

	-- Case: This code block was an image e.g. PlantUML or dot/Graphviz, etc.:
	if fname then
		-- Define the default caption:
		local caption = {}
		local enableCaption = nil

		-- If the user defines a caption, use it:
		if block.attributes["caption"] then
			caption = pandoc.read(block.attributes.caption).blocks[1].content

			-- This is pandoc's current hack to enforce a caption:
			enableCaption = "fig:"
		end

		-- Create a new image for the document's structure. Attach the user's
		-- caption. Also use a hack (fig:) to enforce pandoc to create a
		-- figure i.e. attach a caption to the image.
		local imgObj = pandoc.Image(caption, fname, enableCaption)
		imgObj.attr.identifier = block.attr.identifier
		-- Now, transfer the attribute "name" from the code block to the new
		-- image block. It might gets used by the figure numbering lua filter.
		-- If the figure numbering gets not used, this additional attribute
		-- gets ignored as well.
		if block.attributes["name"] then
			imgObj.attributes["name"] = block.attributes["name"]
		end

		-- Finally, put the image inside an empty paragraph. By returning the
		-- resulting paragraph object, the source code block gets replaced by
		-- the image:
		return pandoc.Para{ imgObj }
	end	
end
