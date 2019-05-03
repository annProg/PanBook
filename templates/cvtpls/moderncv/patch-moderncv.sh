#!/bin/bash

note "use -V style=(classic|casul|oldstyle|banking|empty) default classic"
note "use -V color=(blue|orange|green|red|purple|grey|black|burgundy) default blue"
note "use -V fontsize=(10pt|11pt|12pt) default 11pt"
note "use -V size=(a4paper|letterpaper|a5paper|legalpaper|executivepaper|landscape) default a4paper"
note "use -V fontfamily=(roman|sans) default sans"

setPandocVar style "classic"
setPandocVar color "blue"
setPandocVar fontsize "11pt"
setPandocVar size "a4paper"
setPandocVar fontfamily "sans"