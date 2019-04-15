#!/bin/bash

# fix opensuse theme for newcommand

customHeader="-H fix-opensuse.tex"
authortitle="Author Title"
organization="Organization"
event="Event"
location="Beijing"
parseMeta  # 通过metadata.yaml重定义以上值
sed -i "s/AUTHORTITLE/$authortitle/g" fix-opensuse.tex
sed -i "s/ORGANIZATION/$organization/g" fix-opensuse.tex
sed -i "s/EVENT/$event/g" fix-opensuse.tex
sed -i "s/LOCATION/$location/g" fix-opensuse.tex

sed -i '/shadowbox/d' listings-set.tex
