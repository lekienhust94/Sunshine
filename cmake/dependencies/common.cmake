# load common dependencies
# this file will also load platform specific dependencies

# Resolve OpenSSL before subprojects run their own find_package(OpenSSL) calls.
# This ensures a user-provided OPENSSL_ROOT_DIR is honored consistently.
find_package(OpenSSL REQUIRED)

# boost, this should be before Simple-Web-Server as it also depends on boost
include(dependencies/Boost_Sunshine)

# submodules
# moonlight common library
set(ENET_NO_INSTALL ON CACHE BOOL "Don't install any libraries built for enet")
add_subdirectory("${CMAKE_SOURCE_DIR}/third-party/moonlight-common-c/enet")

# web server
add_subdirectory("${CMAKE_SOURCE_DIR}/third-party/Simple-Web-Server")

# libdisplaydevice
add_subdirectory("${CMAKE_SOURCE_DIR}/third-party/libdisplaydevice")

# common dependencies
include("${CMAKE_MODULE_PATH}/dependencies/nlohmann_json.cmake")
find_package(PkgConfig REQUIRED)
find_package(Threads REQUIRED)

# set the output directory for built objects.
# This makes sure that the dynamic library goes into the build directory automatically.
# set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/$<CONFIGURATION>")
# set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/$<CONFIGURATION>")

if(WIN32)
    add_subdirectory(vendored/SDL EXCLUDE_FROM_ALL)
    add_subdirectory(vendored/SDL_image EXCLUDE_FROM_ALL)
endif()
# option(MYGAME_VENDORED "Use vendored libraries" OFF)

# if(MYGAME_VENDORED)
#     # This assumes the SDL source is available in vendored/SDL
#     add_subdirectory(vendored/SDL EXCLUDE_FROM_ALL)

#     # This assumes the SDL_image source is available in vendored/SDL_image
#     add_subdirectory(vendored/SDL_image EXCLUDE_FROM_ALL)
# else()
#     # 1. Look for a SDL3 package,
#     # 2. look for the SDL3-shared component, and
#     # 3. fail if the shared component cannot be found.
#     find_package(SDL3 REQUIRED CONFIG REQUIRED COMPONENTS SDL3-shared)
# endif()

pkg_check_modules(CURL REQUIRED libcurl)

# miniupnp
pkg_check_modules(MINIUPNP miniupnpc REQUIRED)
include_directories(SYSTEM ${MINIUPNP_INCLUDE_DIRS})

# ffmpeg pre-compiled binaries
include("${CMAKE_MODULE_PATH}/dependencies/ffmpeg.cmake")

# Opus
# Homebrew provides opus as a dynamic library only, so disable static linking for Homebrew builds
if(SUNSHINE_BUILD_HOMEBREW)
    set(OPUS_USE_STATIC OFF CACHE BOOL "Static linking for libopus")
else()
    set(OPUS_USE_STATIC ON CACHE BOOL "Static linking for libopus")
endif()
include("${CMAKE_MODULE_PATH}/dependencies/FindOpus.cmake")

# platform specific dependencies
if(WIN32)
    include("${CMAKE_MODULE_PATH}/dependencies/windows.cmake")
elseif(UNIX)
    include("${CMAKE_MODULE_PATH}/dependencies/unix.cmake")

    if(APPLE)
        include("${CMAKE_MODULE_PATH}/dependencies/macos.cmake")
    else()
        include("${CMAKE_MODULE_PATH}/dependencies/linux.cmake")
    endif()
endif()
