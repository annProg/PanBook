#!/bin/bash
METADATA="../../src/metadata.yaml"
function parseMeta() {
	# 仅支持key全为字母且值为string
	source <(sed 's/[ ]+#.*$//g' $METADATA |grep -E "^[a-zA-Z]+: " | sed -e 's/\s*#.*$//g;s/:[^:\/\/]/="/g;s/$/"/g;s/ *=/=/g' |grep "=")
}

function parse_yaml {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|tr @ '\034')
   sed -r 's/\s+#.*$//g' $1 |sed 's/- /item: /g'|sed -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p" |
   awk -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
         vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
         printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}

# 如果一个变量有定义，第二行的方式将得到拼接的结果，因此除了数组，其他变量不使用第二行的方式
source <(parse_yaml $METADATA)
source <(parse_yaml $METADATA |grep "_item=" |sed 's/_item//' |tr -d '"' |awk -F'=' '{print $1"=\""$2"`[ \"$"$1"\"x != \"\"x ] && echo \", $"$1"\"`\""}')

#parseMeta

echo "$title"
echo "$author"