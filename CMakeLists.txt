cmake_minimum_required(VERSION 3.22)
set(CMAKE_MESSAGE_LOG_LEVEL STATUS)

list(APPEND CMAKE_MODULE_PATH
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake
)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_COLOR_DIAGNOSTICS ON)
set(CMAKE_DIRECTORY_LABELS ON)

project(test
    LANGUAGES
        C CXX
    VERSION
        0.0.1
)

string(TOLOWER "${CMAKE_SYSTEM_NAME}" host_os)
string(TOLOWER "${CMAKE_BUILD_TYPE}" build_type)
string(TOLOWER "${CMAKE_CXX_COMPILER_ARCHITECTURE_ID}" architecture)
set(CMAKE_DEBUG_POSTFIX ".${build_type}.${architecture}")

set(compiler_is_msvc "$<CXX_COMPILER_ID:MSVC>")
set(compiler_is_gnu "$<CXX_COMPILER_ID:GNU>")
set(compiler_is_clang "$<OR:$<CXX_COMPILER_ID:AppleClang>,$<CXX_COMPILER_ID:Clang>>")

file(GLOB_RECURSE
    project_sources
        CONFIGURE_DEPENDS
            ${CMAKE_CURRENT_SOURCE_DIR}/src/*.[hc]
            ${CMAKE_CURRENT_SOURCE_DIR}/src/*.[hc]pp
)

add_executable(${PROJECT_NAME}
    ${project_sources}
)

include(compiler-warnings)

target_compile_features(${PROJECT_NAME} PRIVATE
    PRIVATE
        c_std_11
        cxx_std_23
)

target_compile_definitions(${PROJECT_NAME} PRIVATE
    NOMINMAX

    $<${compiler_is_msvc}:
        WIN32_LEAN_AND_MEAN
        VC_EXTRALEAN
        _CRT_SECURE_NO_WARNINGS
    >
)

target_compile_options(${PROJECT_NAME} PRIVATE
  $<${compiler_is_msvc}:
        /Zc:preprocessor
        /utf-8
        /EHsc
        /nologo
    >
)

target_link_options(${PROJECT_NAME} PRIVATE
    $<$<CONFIG:Debug>:
        -fsanitize=address
    >
)

set(BULLET_DIR ${CMAKE_CURRENT_SOURCE_DIR}/libs/bullet3)
set(RML_DIR ${CMAKE_CURRENT_SOURCE_DIR}/libs/rmlui)
set(RML_BACKEND_DIR ${RML_DIR}/Backends)
set(SDL_DIR ${CMAKE_CURRENT_SOURCE_DIR}/libs/sdl2)

set(RML_LIBRARIES RmlCore RmlDebugger RmlBackend)
set(SDL_LIBRARIES SDL2main SDL2-static)

add_subdirectory(${SDL_DIR})
add_subdirectory(${BULLET_DIR})
add_subdirectory(${RML_DIR})
add_subdirectory(${RML_BACKEND_DIR})

target_link_libraries(${PROJECT_NAME}
    PRIVATE ${RML_LIBRARIES}
    PRIVATE ${SDL_LIBRARIES}
)

target_include_directories(${PROJECT_NAME}
    PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src
    PRIVATE ${BULLET_DIR}/include/bullet
)

set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    PROPERTY VS_STARTUP_PROJECT
        ${PROJECT_NAME}
)

set_property(TARGET ${PROJECT_NAME}
    PROPERTY VS_DEBUGGER_ENVIRONMENT
        "PATH=${CMAKE_CURRENT_INSTALL_DIR}/${PROJECT_NAME}${CMAKE_EXECUTABLE_SUFFIX}"
)

include(cmake-utils)
