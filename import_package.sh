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
    mkdir $bonesDir/dragonBones
    mkdir $bonesDir/rapidjson
    mkdir $bonesDir/rapidxml
    echo "Create link..."
    ln -s $dir_path/DragonBones/src/dragonBones/* $bonesDir/dragonBones
    ln -s $dir_path/Cocos2DX_3.x/src/dragonBones/cocos2dx $bonesDir/dragonBones
    ln -s $dir_path/Cocos2DX_3.x/src/dragonBones/proj.android $bonesDir/dragonBones
    ln -s $dir_path/Cocos2DX_3.x/src/*.h $bonesDir
    ln -s $dir_path/Cocos2DX_3.x/src/*.cpp $bonesDir
    ln -s $dir_path/3rdParty/rapidjson/* $bonesDir/rapidjson
    ln -s $dir_path/3rdParty/rapidxml/* $bonesDir/rapidxml
    unlink $bonesDir/rapidjson/msinttypes
    echo "Done!"
}

deploy $1

