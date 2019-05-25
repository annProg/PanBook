regext device
getArrayVar _G "ext-device" true
getArrayVar _G "ext-device-tex" "$SCRIPTDIR/${_G[extdir]}/device/device.tex"

function device() {
	echo ${_V[device]} |grep -wE "pc|mobile|kindle" &>/dev/null && r=0 || r=1
	if [ $r -eq 0 ];then
		echo "\device${_V[device]}" >> ${_G[header]}
	else
		echo "\devicepc" >> ${_G[header]}
	fi
}

function ext_device() {
	# 依赖add header功能
	if [ "${_G[ext-device]}"x == "true"x -a "${_G[ext-header]}"x == "true"x ];then
		writeHeader ${_G[ext-device-tex]}
		device
	fi
}

function ext_device_help() {
	echo -e "\t-G ext-device:<true|false>                        enable device(default true)"
	echo -e "\t-G ext-device-tex:<custom device set file>        change device set file"
	echo -e "\t-V device:<pc|mobile|kindle>                      set device"
	exit 0
}