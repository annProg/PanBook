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

function which(command)
	return os.execute("which " .. command .. ' >/dev/null 2>&1')
end

function rsvg(svg, output, format)
	if not which('rsvg-convert') then
		print("\27[31mPlot Warning: librsvg not installed!\27[m")
		return false
	end

	local r = os.execute('rsvg-convert -f ' .. format .. ' -o ' .. output .. ' ' .. svg)

	if not r then
		print("\n\27[31mPlot Warning: rsvg convert failed! -> " .. svg .. "\27[m")
	end
	return r
end

function getfiletype(engine)
	-- The default format is pdf
	local filetype = "pdf"

	if inTable({'docx', 'pptx', 'rtf'}, FORMAT) then
		filetype = "png"
	end

	if inTable({'epub', 'epub2', 'epub3', 'html', 'html5'}, FORMAT) then
		filetype = "svg"
	end

	-- 有些engine不支持svg
	if inTable({"ditaa"}, engine) then
		filetype = "png"
	end

	return filetype
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

function goseq(code, filetype, fname, cname)
	writefile(cname, code)
	local nfname = string.gsub(fname, '.' .. filetype, '.svg')
	local success,img = pandoc.pipe("goseq", {"-o", nfname, cname}, code)

	if filetype ~= 'svg' then
		rsvg(nfname, fname, filetype)
	end
	return success,img
end

function a2s(code, filetype, fname, cname)
	local nfname = string.gsub(fname, '.' .. filetype, '.svg')
	local success,img = pandoc.pipe("a2s", {"-i", "-", "-o", nfname}, code)

	if filetype ~= 'svg' then
		rsvg(nfname, fname, filetype)
	end
	return success,img
end

function gnuplot(code, filetype, fname, cname)
	local ncode = string.gsub(code, '(set ter)', '#%1')
	local ncode = string.gsub(ncode, '(se t)', "#%1")
	local ncode = string.gsub(ncode, '(se o)', "#%1")
	local ncode = string.gsub(ncode, '(set out)', "#%1")

	writefile(cname, ncode)

	local term = filetype
	if filetype == 'png' or filetype == 'pdf' then
		term = filetype .. "cairo"
	end
	local success,img = pandoc.pipe("gnuplot", {"-e","set term " .. term .. " enhanced;set out '" .. fname .. "';", cname}, code)

	return success,img
end

function asy(code, filetype, fname, cname)
	local success,img = pandoc.pipe("asy", {"-f", filetype, "-o", fname}, code)
	return success,img
end

local validEngines = {
	dot = dot, 
	fdp = fdp, 
	sfdp = sfdp, 
	twopi = twopi, 
	neato = neato, 
	circo = circo, 
	ditaa = ditaa, 
	gnuplot = gnuplot,
	goseq = goseq,
	a2s = a2s,
	asy = asy,
	gnuplot = gnuplot
}

local renderDir = "_plot_render"
if not os.execute("[ -d " .. renderDir .. " ]") then
	os.execute("mkdir " .. renderDir)
end

function renderImg(block)
	if block.attr.classes[1] == nil then
		return block
	end

	-- valid engine
	local engine = string.gsub(block.attr.classes[1], 'plot:', '')
	if not inTable(table.keys(validEngines), engine) then
		return block
	end

	if not which(engine) then
		block.text = "! Note: " .. engine .. " not installed ! So I did not render this code\n\n" .. block.text
		print("\27[31mPlot Warning: " .. engine .. " not installed!\27[m")
		return block
	end

	local filetype = getfiletype(engine)
	
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
			print("\n\27[31mPlot Error: " .. engine .. " error!\27[m")
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

		-- 支持 class 和 key=val 属性
		table.remove(block.attr.classes, 1)
		imgObj.attr.classes = block.attr.classes
		imgObj.attributes = block.attributes

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
		return imgObj
	end	
end

function Div(block)
	if not string.match(block.attr.identifier, '^fig:.*') then
		return block
	end

	local nblock = pandoc.Div({})
	nblock.attr.identifier = block.attr.identifier

	local subfig = {}
	local group = 1
	subfig[group] = {}
	for k,v in pairs(block.content) do
		if v.t == "CodeBlock" and v.attributes["subfig"] ~= nil then
			group = v.attributes["subfig"]
			if subfig[group] == nil then
				subfig[group] = {}
			end
			table.insert(subfig[group], renderImg(v))
		else
			table.insert(subfig[group], v)
		end
	end

	for k,v in pairs(subfig) do
		local imgGroup = pandoc.Para({})
		local para = {}
		for i,j in pairs(v) do
			if j.t == "Image" then
				table.insert(imgGroup.content, j)
				table.insert(imgGroup.content, pandoc.SoftBreak())
			else
				table.insert(para, j)
			end
		end
		table.insert(nblock.content, imgGroup)
		for m,n in pairs(para) do
			table.insert(nblock.content, n)
		end
	end
	return nblock
end

function CodeBlock(block)
	if block.attributes["subfig"] == nil then
		local img = renderImg(block)
		if img.t == "Image" then
			return pandoc.Para{ img }
		else
			return img
		end
	end
end