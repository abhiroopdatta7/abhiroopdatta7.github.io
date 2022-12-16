CMake is an extensible, open-source system that manages the build process in an operating system and in a compiler-independent manner.

## Home Page
[Home Page](http://www.cmake.org/download)

## Installation

```bash
wget https://cmake.org/files/v$version/cmake-$version.$build.tar.gz # Download

tar -xzvf cmake-$version.$build.tar.gz # Untar

cd <directory>

./bootstrap

make -j$(nproc)

sudo make install
```

After installation confirm the version installed:

```bash
cmake --version
```


## Example
Let's now create one simple project with CMake.
Here in this example our project Hello World, has two modules, DemoLib and DemoBin.

```cmake
# Confirm minimum CMake Version Required.
cmake_minimum_required(VERSION 3.5.1)

# Create One New Project with name: "My-Project" 
project(Hello-World))

# Generate Compile command json file, which required by intellisense or cland.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Adding Option which is by default True
option(DEMO_LIB_OPTION "Build Demo Library" ON)


if(DEMO_LIB_OPTION)
	# Defined Macro `DEMO_OPTION`
	add_definitions(-DDEMO_LIB)
	
	# This will call `CMakeLists.txt` file in the demo_lib directory
	add_subdirectory(${PROJECT_SOURCE_DIR}/demo_lib)
	
endif(DEMO_LIB_OPTION)

add_subdirectory(${PROJECT_SOURCE_DIR}/demo_bin)
```

Now let's see how the `DemoLib` CMakeLists.txt looks like:
```cmake
project(demo-library)

find_package(Threads REQUIRED)

find_package(PkgConfig REQUIRED)
pkg_check_modules(DPDK REQUIRED IMPORTED_TARGET libdpdk)

file(GLOB_RECURSE C_SOURCES CONFIGURE_DEPENDS "*.c")

add_library (${PROJECT_NAME} STATIC ${C_SOURCES})
add_library(sub::${PROJECT_NAME} ALIAS ${PROJECT_NAME})

target_include_directories (${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR})

target_link_libraries(${PROJECT_NAME} PUBLIC Threads::Threads PkgConfig::DPDK)
```

Then this the `DemoBin` looks like:
```cmake
project(demo-binary)

# Add sources manually as below:
set(SOURCES main.c)

# Name of the executable
add_executable(${PROJECT_NAME} ${SOURCES})

target_link_libraries(${PROJECT_NAME} PUBLIC sub::demo-library)
```

