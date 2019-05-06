# lua utils module

此目录为自定义的lua module，主要用于开发调试，使用时请将此目录复制到`Pandoc`安装目录

## print table

```lua
require "table_print"
table.print = table_print.print_r
```