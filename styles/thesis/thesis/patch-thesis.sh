#!/bin/bash

parseMeta

# 检查必要的变量
subtitle=`getMetaVar subtitle`
etitle=`getMetaVar etitle`
xuehao=`getMetaVar xuehao`
supervisor=`getMetaVar supervisor`
college=`getMetaVar college`

FIX=${_G[build]}/fix-thesis.tex

cat > $FIX <<EOF
\subtitle{$subtitle}
\etitle{$etitle}
\xuehao{$xuehao}
\supervisor{$supervisor}
\college{$college}
EOF

writeHeader $FIX

# 使用默认模板
_P[standalone]=""