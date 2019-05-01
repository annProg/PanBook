-- Pandoc filter to process code blocks with class "ci-dot" containing
-- graphviz dot code into images.
--
-- * Assumes that dot in the path.
-- * For textual output formats, use --extract-media=dot-images
-- * For HTML formats, you may alternatively use --self-contained

local filetypes = { html = {"png", "image/png"}
                  , latex = {"pdf", "application/pdf"}
                  }
local filetype = filetypes[FORMAT][1] or "png"
local mimetype = filetypes[FORMAT][2] or "image/png"

local function dot2image(dot, filetype)
    local image = pandoc.pipe("dot", {"-T" .. filetype}, dot)
    -- local final = pandoc.pipe("convert", {"-", filetype .. ":-"}, eps)
    return image
end

function CodeBlock(block)
    if block.classes[1] == "ci-dot" then
        local img = dot2image(block.text, filetype)
        local fname = pandoc.sha1(img) .. "." .. filetype
        pandoc.mediabag.insert(fname, mimetype, img)
		-- 增加 "fig:" 可以给生成的图片加caption，pandoc.Str中内容为caption
		-- 可以研究如何将codeblock的caption传递到这里
        return pandoc.Para{ pandoc.Image({pandoc.Str("dot tune")}, fname, "fig:") }
    end
end