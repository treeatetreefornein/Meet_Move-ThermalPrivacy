cmake_minimum_required(VERSION 3.16)

project(anonimisationDemo CXX)

#include(FetchContent)
#FetchContent_Declare(
#      vtk
#      GIT_REPOSITORY https://gitlab.kitware.com/vtk/vtk
      #SOURCE_SUBDIR CMake
#)
#FetchContent_Declare(
#    libdc1394
#    GIT_REPOSITORY https://git.code.sf.net/p/libdc1394/code
#)
#FetchContent_Declare(
#      opencv
#      GIT_REPOSITORY https://github.com/opencv/opencv
#)
#FetchContent_MakeAvailable(libdc1394 opencv)

#include_directories(build/_deps/opencv-src/modules/)

#RM?:
#FetchContent_GetProperties(opencv)
#if (NOT opencv_POPULATED)
#    FetchContent_Populate(opencv)
#endif()
#####################

# Point to fetched lib
#set(OpenCV_DIR ${CMAKE_CURRENT_BINARY_DIR})
#set(OpenCV_DIR _deps/opencv-build/)
#set(VTK_DIR _deps/vtk-src/VTK-build/lib/)
#set(VTK_DIR _deps/vtk-build/CMakeFiles/)
#set(VTK_DIR _deps/vtk-build/lib/)
#RM?:
#include_directories(OpenCV_DIR _deps/opencv-build/lib/)
#include_directories(${OpenCV_INCLUDE_DIRS})
#include_directories(${VTK_DIR})

find_package(OpenCV REQUIRED)
#find_package(vtk REQUIRED)
#find_package(vtk REQUIRED NO_MODULE)

# Link
#install(TARGETS pxVid DESTINATION bin)
#add_subdirectory(build/_deps/opencv-src)

include_directories(${OpenCV_INCLUDE_DIRS})

## DEBUG
foreach(path ${CMAKE_PREFIX_PATH})
  message("Path: " ${path})
endforeach(path)
add_executable(${PROJECT_NAME} src/main.cpp)

# Pulls in everything
#target_link_libraries(pxVid ${OpenCV_LIBS})
target_link_libraries(${PROJECT_NAME} ${OpenCV_LIBS})
    #        ${VTK_DIR})

#target_link_libraries(pxVid opencv_core, opencv_imgcodecs, opencv_imgproc)

###         cmake .. -DCMAKE_INSTALL_PREFIX=../install


