#!/bin/bash

dir_path=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

function usage() {
    cat <<EOF
$(basename ${0}) is a tool for copy DragonBones Cocos2d-x Library to import..
Usage: 
    ./$(basename ${0})
EOF
}

function error() {
    echo -e "\033[31mError\033[m : $@"
    exit
}

function deploy() {
    dir=${1:-DragonBonesCpp}
    bonesDir=$dir_path/$dir
    if [ -e $bonesDir ]; then
        rm -rf $bonesDir
    fi
    mkdir $bonesDir
    echo "copy directory..."
    cp -rf $dir_path/DragonBones/src/dragonBones $bonesDir/
    cp -rf $dir_path/Cocos2DX_3.x/src/dragonBones/cocos2dx $bonesDir/dragonBones/
    cp -rf $dir_path/Cocos2DX_3.x/src/dragonBones/proj.android $bonesDir/dragonBones/proj.android
    cp -rf $dir_path/Cocos2DX_3.x/src/*.h $bonesDir/dragonBones/
    cp -rf $dir_path/Cocos2DX_3.x/src/*.cpp $bonesDir/dragonBones/
    cp -rf $dir_path/3rdParty/rapidjson $bonesDir/rapidjson
    cp -rf $dir_path/3rdParty/rapidxml $bonesDir/rapidxml
    rm -rf $bonesDir/rapidjson/msinttypes
    echo "Done!"
}

if [ $# -lt 1 ]; then
usage
exit 1
fi

deploy $1

