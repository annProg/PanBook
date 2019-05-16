_G[ext_column]="$SCRIPTDIR/extensions/column"
_G[ext_column_filter]="${_G[ext_column]}/fenced_divs_columns.lua"

function addColumns() {
	if [ "$_V[column]"x == "true"x ];then
		_F[column]="--lua-filter ${_G[ext_column_filter]}"
	fi
}