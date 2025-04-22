cmake_minimum_required(VERSION 3.10)
project(LearningOpenGL LANGUAGES C CXX)

# Set C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Find GLFW
find_package(glfw3 3.3 REQUIRED)
if (NOT glfw3_FOUND)
    message(FATAL_ERROR "GLFW not found. Please install it (e.g., `brew install glfw` on macOS).")
endif()

# Find Assimp
find_package(assimp REQUIRED)
if (NOT assimp_FOUND)
    message(FATAL_ERROR "Assimp not found. Please install it (e.g., `brew install assimp` on macOS, `sudo apt install libassimp-dev` on Ubuntu).")
endif()

# Add source files
set(SOURCES
    src/main.cpp
    includes/glad/src/glad.c
    src/stb_image.cpp
)

# Include directories
include_directories(
    ${CMAKE_SOURCE_DIR}/includes
    ${CMAKE_SOURCE_DIR}/includes/glad/include
    ${CMAKE_SOURCE_DIR}/includes/glm
    ${ASSIMP_INCLUDE_DIRS}
)

# Create executable
add_executable(learning_opengl ${SOURCES})

# Link libraries
target_link_libraries(learning_opengl PRIVATE glfw ${ASSIMP_LIBRARIES})

# macOS-specific frameworks
if (APPLE)
    find_library(COCOA_LIBRARY Cocoa)
    find_library(OPENGL_LIBRARY OpenGL)
    find_library(IOKIT_LIBRARY IOKit)
    target_link_libraries(learning_opengl PRIVATE ${COCOA_LIBRARY} ${OPENGL_LIBRARY} ${IOKIT_LIBRARY})
endif()

# Ensure Apple Silicon compatibility
if (APPLE AND CMAKE_SYSTEM_PROCESSOR MATCHES "arm64")
    set(CMAKE_OSX_ARCHITECTURES arm64)
endif()
