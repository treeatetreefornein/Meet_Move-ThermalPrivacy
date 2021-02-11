cmake_minimum_required(VERSION 3.16)

project(poseVerifier CXX)

add_compile_options(-Wall -Wextra -pedantic -ggdb -O0 -std=c++17 -Iproduct -pg)

# View ../poc/amgVidDemo for (broken) automagic prerequisite fetching

find_package(OpenCV REQUIRED)

include_directories(${OpenCV_INCLUDE_DIRS})
include_directories(src/)

## DEBUG
foreach(path ${CMAKE_PREFIX_PATH})
  message("Path: " ${path})
endforeach(path)

add_executable(${PROJECT_NAME} src/main.cpp src/pose.cpp)

target_link_libraries(${PROJECT_NAME} ${OpenCV_LIBS})
