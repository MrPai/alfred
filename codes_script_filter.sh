#!/bin/bash

# 此脚本是用来检索所有codes下的repo目录，并通过快捷命令直接在IDE中打开 
# 建议生成json后直接copy，避免在每次通过关键词search时都要执行脚本
# 考虑后续在rust二进制中集成此功能

# ls -l $path | awk '/^d/ {print $NF}'
path="$HOME/zlp_workfiles/codes"
files=$(ls $path)

demo='
{
    "type": "file",
    "title": "parallel",
    "subtitle": "~/zlp_workfiles/codes/parallel-finance/parallel",
    "arg": "~/zlp_workfiles/codes/parallel-finance/parallel",
    "autocomplete": "parallel",
    "icon": {
        "type": "fileicon",
        "path": "~/zlp_workfiles/codes"
    }
}
'

# t="test12"
# json=$(echo $demo | jq '(.title="'$t'")|(.arg="neww")')
# echo $json | jq
# exit

declare -a items
num=0

for filename in $files
do
    # echo $filename
    subfiles=$(ls $path/$filename)
    for subfilename in $subfiles
    do
        # echo $num
        # echo $path/$filename/$subfilename
        codepath=$path/$filename/$subfilename
        # json={\\\"title\\\":\\\"$subfilename\\\",\\\"arg\\\":\\\"$codepath\\\"}
        json=$(echo $demo | jq '(.title="'$subfilename'")|(.subtitle="'$codepath'")|(.arg="'$codepath'")|(.autocomplete="'$subfilename'")')
        # rst=$(echo $rst | jq '.items['$num']+='$json'')
        

        items[$num]=$json,
        let num++

    done
done
# echo ${items[*]}

rst='
{
    "items": ['${items[*]}$demo']
}
'
# echo $rst | jq
# 建议生成json后直接copy，避免在每次通过关键词search时都要执行脚本
echo $rst | jq >> .local/codes_folder_list.json

exit
cat << EOB
{"items": [

	{
		"type": "file",
		"title": "Desktop",
		"subtitle": "~/Desktop",
		"arg": "~/Desktop",
		"autocomplete": "Desktop",
		"icon": {
			"type": "fileicon",
			"path": "~/Desktop"
		}
	},
	{
		"type": "file",
		"title": "parallel",
		"subtitle": "~/zlp_workfiles/codes/parallel-finance/parallel",
		"arg": "~/zlp_workfiles/codes/parallel-finance/parallel",
		"autocomplete": "parallel",
		"icon": {
			"type": "fileicon",
			"path": "~/zlp_workfiles/codes"
		}
	}

]}
EOB