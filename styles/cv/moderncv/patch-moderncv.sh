#!/bin/bash

note "use -M style=(classic|casual|oldstyle|banking|fancy) default classic"
note "use -M color=(blue|orange|green|red|purple|grey|black|burgundy) default blue"
note "use -M fontsize=(10pt|11pt|12pt) default 11pt"
note "use -M size=(a4paper|letterpaper|a5paper|legalpaper|executivepaper|landscape) default a4paper"
note "use -M fontfamily=(roman|sans) default sans"

getArrayVal _V CJKmainfont "SimSun"
getArrayVal _V CJKoptions "BoldFont=微软雅黑,ItalicFont=KaiTi,SmallCapsFont=微软雅黑"

getArrayVal _M style "classic"
getArrayVal _M color "blue"
getArrayVal _M fontsize "11pt"
getArrayVal _M size "a4paper"
getArrayVal _M fontfamily "sans"

# 自定义filter
_F[style-${_G[function]}-${_G[style]}]="--lua-filter ${_G[style]}.lua"

# casual样式个人信息在底部，和foot有冲突，加vspace处理
if [ "${_M[style]}"x == "casual"x ];then
	_V[vspace]="0.7cm"
	_V[geometry]="top=2cm,bottom=2cm,left=2cm,right=2cm,includefoot"
fi

# 修改文件名，区分cv style和 color
_G[ofile]=${_G[ofile]}-${_M[style]}-${_M[color]}

_P[template]="moderncv.tpl"

note "cv style is ${_M[style]}"
note "cv color is ${_M[color]}"

note "This Template support the following variables, they can set via metadata or -V option\n
\tname                 Your name
\ttitle                Your title
\tmobile               Your mobile phone number
\tfixed                Your fixed phone number
\tgithub               Your Github user name
\tlinkedin             Your LinkedIn account
\ttwitter              Your Twitter account
\twechat               Your WeChat account
\tweibo                Your Weibo account
\tqq                   Your QQ number
\tskype                Your Skype
\thomepage             Your website link
\tdatewidth            Change the width of the dates column. default 3cm
\temail                Your Email address
\taddress              Your address
\textrainfo            Additional information
\tphoto                Your photo(put photo to src/images/ dir; photo value should be images/filename)
\tquote                Some quote
\tonlinecv             Your cv url
\tshowdate             Show cv compile date (true|false)
\tCJKmainfont          Change CJKmainfont. default SimSun
\tCJKoptions           Change CJKoptions default (BoldFont=微软雅黑,ItalicFont=KaiTi,SmallCapsFont=微软雅黑)"