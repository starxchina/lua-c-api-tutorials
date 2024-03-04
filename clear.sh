#!/bin/sh

# clear the env
if [ -d "build" ];then 
    rm -rf ./build
fi
if [ -d "./third_party/LuaJIT-2.1.ROLLING" ];then
    rm -rf "./third_party/LuaJIT-2.1.ROLLING"
fi
