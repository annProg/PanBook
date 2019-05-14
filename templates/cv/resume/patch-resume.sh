#!/bin/bash

setPandocVar CJKmainfont "SimSun"
setPandocVar CJKoptions "BoldFont=微软雅黑,ItalicFont=KaiTi,SmallCapsFont=微软雅黑"


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
\temail                Your Email address
\taddress              Your address
\textrainfo            Additional information
\tphoto                Your photo(put photo to src/images/ dir; photo value should be images/filename)
\tquote                Some quote
\tonlinecv             Your cv url
\tshowdate             Show cv compile date (true|false)
\tCJKmainfont          Change CJKmainfont. default SimSun
\tCJKoptions           Change CJKoptions default (BoldFont=微软雅黑,ItalicFont=KaiTi,SmallCapsFont=微软雅黑)"