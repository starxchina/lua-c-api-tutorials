cmake_minimum_required(VERSION 3.5)
# 定义了项目的名称为lua-c-api-tutorials。 
project(lua-c-api-tutorials)

# 这条指令设置库文件的输出目录为${PROJECT_BINARY_DIR}/lib。${PROJECT_BINARY_DIR}是一个CMake内置变量，指代当前项目的构建目录。
set(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)
# 这条指令设置可执行文件的输出目录为${PROJECT_BINARY_DIR}/bin。
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)
# 这条指令为C语言编译器添加了一些编译选项，如优化级别-O2、使用管道、生成位置无关代码-fPIC、开启所有警告-Wall以及不限制错误信息长度-fmessage-length=0。
SET(CMAKE_C_FLAGS  "-O2 -pipe -fPIC -Wall -fmessage-length=0")

# 这条指令将/usr/local/include目录添加到编译器的头文件搜索路径中。
# include_directories(/usr/local/include)
include_directories(${PROJECT_BINARY_DIR}/../third_party/LuaJIT-2.1.ROLLING/build/include/luajit-2.1)


# 这条指令指定了全局链接阶段需要链接的库，这里指定了数学库m、动态链接库dl。
link_libraries(m dl)

# 查找并链接luajit共享库, 这里添加NO_DEFAULT_PATH,避免加载系统文件
find_library(MYLUAJIT_LIBRARY
    NAMES luajit-5.1
    PATHS
        ${PROJECT_BINARY_DIR}/../third_party/LuaJIT-2.1.ROLLING/build/lib
    NO_DEFAULT_PATH
)

if(MYLUAJIT_LIBRARY)
    message("MYLUAJIT_LIBRARY path is: ${MYLUAJIT_LIBRARY}")
    link_libraries(${MYLUAJIT_LIBRARY})
else()
    message(FATAL_ERROR "MYLUAJIT_LIBRARY not found.")
endif()

# 这条指令用于安装时，将src/目录下所有的.lua文件安装到bin目录。
install(DIRECTORY src/ DESTINATION bin FILES_MATCHING PATTERN "*.lua")

# 这条指令将src目录添加到构建中。CMake会查找src目录下的CMakeLists.txt文件，并根据那里的指令进一步配置构建过程。
add_subdirectory(src)