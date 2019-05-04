#!/bin/bash

note "use -E style=(classic|casual|oldstyle|banking|fancy) default classic"
note "use -E color=(blue|orange|green|red|purple|grey|black|burgundy) default blue"
note "use -E fontsize=(10pt|11pt|12pt) default 11pt"
note "use -E size=(a4paper|letterpaper|a5paper|legalpaper|executivepaper|landscape) default a4paper"
note "use -E fontfamily=(roman|sans) default sans"

getVar style "classic"
getVar color "blue"
getVar fontsize "11pt"
getVar size "a4paper"
getVar fontfamily "sans"

addOptions="$addOptions -V style=$style -V color=$color -V fontsize=$fontsize -V size=$size -V fontfamily=$fontfamily"

OUTPUT="$BUILD/$ofile-cv-$t-$style-$color.tex"

note "cv style is $style"
note "cv color is $color"

note "This Template support the following variables, they can set via metadata or -V option\n
\tauthor               Your name
\ttitle                Your title
\tmobile               Your mobile phone number
\tfixed                Your fixed phone number
\tgithub               Your Github user name
\thomepage             Your website link
\tdatewidth            Change the width of the dates column. default 3cm
\temail                Your Email address
\taddress              Your address
\textrainfo            Additional information
\tphoto                Your photo(put photo to src/images/ dir; photo value should be images/filename)
\tquote                Some quote
\tonlinecv             Your cv url
\tshowdate             Show cv compile date (true|false)
\tfont                 Change CJKmainfont. default SimSun"