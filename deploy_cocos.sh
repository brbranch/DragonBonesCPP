#!/bin/bash

dir_path=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

function usage() {
    cat <<EOF
$(basename ${0}) is a tool for copy DragonBones Cocos2d-x Library to ProjectDir.
Usage: 
    ./$(basename ${0}) [distDirectoryPath] [make directory name (default: DragonBonesCpp)]
EOF
}

function error() {
    echo -e "\033[31mError\033[m : $@"
    exit
}

function deploy() {
    dist=$1
    dir=${2:-DragonBonesCpp}
    if [ ! -e $dist ]; then
        error "$dist is not Directory path!"
        exit 1
    fi
    if [ -e $dist/$dir ]; then
        error "$dist/$dir is already exists!"
        exit 1
    fi
    bonesDir=$dist/$dir
    echo "copy directory..."
    cp -rf $dir_path/DragonBones/src/dragonBones $bonesDir
    cp -rf $dir_path/Cocos2DX_3.x/src/dragonBones/cocos2dx $bonesDir/
    cp -rf $dir_path/Cocos2DX_3.x/src/dragonBones/proj.android $bonesDir/proj.android
    cp -rf $dir_path/3rdParty/rapidjson $bonesDir/rapidjson
    cp -rf $dir_path/3rdParty/rapidxml $bonesDir/rapidxml
    echo "Done!"
}

if [ $# -lt 1 ]; then
usage
exit 1
fi

deploy $1 $2

