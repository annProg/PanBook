function func_cv_moderncv_help() {
note "use -M style:(classic|casual|oldstyle|banking|fancy) default classic"
note "use -M color:(blue|orange|green|red|purple|grey|black|burgundy) default blue"
note "use -M fontsize:(10pt|11pt|12pt) default 11pt"
note "use -M size:(a4paper|letterpaper|a5paper|legalpaper|executivepaper|landscape) default a4paper"
note "use -M fontfamily:(roman|sans) default sans"

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
\tCJKoptions           Change CJKoptions default (BoldFont=微软雅黑,ItalicFont=KaiTi,SmallCapsFont=微软雅黑)
\tphotoheight          Change photo height. default 55
\tphotoframe           Change thickness of the frame around the picture. default 1"
}

function func_cv_moderncv_list() {
    note "List of moderncv styles. use -M style:<style>"
    echo -e "classic\ncasual\noldstyle\nbanking\nfancy"

    note "List of moderncv colorsa. use -M color:<color>"
    echo -e "blue\norange\ngreen\nred\npurple\ngrey\nblack\nburgundy"
}