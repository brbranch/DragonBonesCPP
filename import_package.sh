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
    cd $dir_path
    bonesDir=$dir_path/$dir
    if [ -e $bonesDir ]; then
        rm -rf $bonesDir
    fi
    mkdir $bonesDir
    mkdir $bonesDir/dragonBones
    mkdir $bonesDir/rapidjson
    mkdir $bonesDir/rapidxml
    echo "Create link..."
    cd $bonesDir/dragonBones
    pwd
    ln -s ../../DragonBones/src/dragonBones/* .
    ln -s ../../Cocos2DX_3.x/src/dragonBones/cocos2dx .
    ln -s ../../Cocos2DX_3.x/src/dragonBones/proj.android .
    cd $bonesDir
    ln -s ../Cocos2DX_3.x/extension/* .
    cd $bonesDir/rapidjson
    ln -s ../../3rdParty/rapidjson/* .
    unlink ./msinttypes
    cd $bonesDir/rapidxml
    ln -s ../../3rdParty/rapidxml/* .
    cd $dir_path
    echo "Done!"
}

deploy $1

