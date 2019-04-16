#!/bin/bash
METADATA="../../src/metadata.yaml"
function parseMeta() {
	# 仅支持key全为字母且值为string
	source <(grep -E "^[a-zA-Z]+: " $METADATA | sed -e 's/\s*#.*$//g;s/:[^:\/\/]/="/g;s/$/"/g;s/ *=/=/g' |grep "=")
}

parseMeta

echo "$title"
echo "$author"