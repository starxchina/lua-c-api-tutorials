#!/bin/sh

SOURCE_DIR=`pwd`

# ============================================================================
# installls the luajit

cd $SOURCE_DIR/third_party
unzip LuaJIT-2.1.ROLLING.zip
cp Makefile LuaJIT-2.1.ROLLING/
cd $SOURCE_DIR/third_party/LuaJIT-2.1.ROLLING

# 获取 uname 命令的输出并存储在变量中
uname_output=$(uname)
# 检查 uname 输出的第一个单词是否为 "Darwin"
if [[ $uname_output == "Darwin" ]]; then
    echo "This is macOS system."
    macos_version=$(sw_vers -productVersion)
    export MACOSX_DEPLOYMENT_TARGET=${macos_version}
fi
make
make install  # luajit install should refer to its official website
# ============================================================================


cd $SOURCE_DIR
# CMAKE_INSTALL_PREFIX: 这是一个 CMake 变量，用于指定安装目录的根路径。当项目构建完成后，make install 命令将会将文件复制到这个目录中。在这个命令中，该变量被设置为当前目录（.），这意味着构建完成后的文件将会被安装到当前目录中。

mkdir -p build 
cd build 
cmake -D CMAKE_INSTALL_PREFIX=. $SOURCE_DIR
make
make install