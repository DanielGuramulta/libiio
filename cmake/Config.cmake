include("${CMAKE_CURRENT_LIST_DIR}/@PROJECT_NAME@Targets.cmake")
set(libiio_LIBRARIES libiio::libiio)

find_path(libiio_INCLUDE_DIRS
    NAMES iio.h
    PATHS ${CMAKE_PREFIX_PATH}/include
    /usr/local/include
    /usr/include)

# CMake 2.8.11 supports populating the INTERFACE_INCLUDE_DIRECTORIES through
# target_include_directories(libiio PUBLIC $<INSTALL_INTERFACE:${CMAKE_PREFIX_PATH}/include>)
# the desired behaviour is to only provide $<INSTALL_INTERFACE:include> as this will force
# CMake to find the location of the packages include folder, thus making the package
# relocatable. But cmake 2.8.11 complains of $<INSTALL_INTERFACE:include> for being a relative path
# lets manually populate the INTERFACE_INCLUDE_DIRECTORIES in this case
# we also populate this for framework install on macos cmake version greater than 2.8.10 to keep
# the same usage of cmake consistent between framework / non framework installs
if((${CMAKE_VERSION} VERSION_GREATER "2.8.10" AND ${CMAKE_VERSION} VERSION_LESS "2.8.12") OR
                (${CMAKE_VERSION} VERSION_GREATER "2.8.10" AND ${CMAKE_SYSTEM_NAME} MATCHES "Darwin"))
    set_target_properties(libiio::libiio PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES ${libiio_INCLUDE_DIRS}
    )
endif()

set(TOOLS @IIO_TESTS_TARGETS@)

foreach(tool ${TOOLS})
    include("${CMAKE_CURRENT_LIST_DIR}/${tool}Targets.cmake")
endforeach()
