#!/bin/bash

note "use -E style=(classic|casul|oldstyle|banking|empty) default classic"
note "use -E color=(blue|orange|green|red|purple|grey|black|burgundy) default blue"
note "use -E fontsize=(10pt|11pt|12pt) default 11pt"
note "use -E size=(a4paper|letterpaper|a5paper|legalpaper|executivepaper|landscape) default a4paper"
note "use -E fontfamily=(roman|sans) default sans"

setPandocVar style "classic"
setPandocVar color "blue"
setPandocVar fontsize "11pt"
setPandocVar size "a4paper"
setPandocVar fontfamily "sans"