regext plot
# 通用
getArrayVar _G "ext-plot" true

function ext_plot() {
	# 依赖add header功能
	if [ "${_G[ext-plot]}"x == "true"x ];then
		_F[plot]="--lua-filter $SCRIPTDIR/${_G[extdir]}/plot/plot.lua"

		extStat plot done
	else
		extStat plot skip
	fi
}

function ext_plot_help() {
	echo -e "\t-G ext-plot:<true|false>                        enable plot(default true)"
	exit 0
}