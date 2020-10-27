install(EXPORT ${PROJECT_NAME}Targets
    FILE ${PROJECT_NAME}Targets.cmake
    NAMESPACE ${PROJECT_NAME}::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

foreach(tool ${IIO_TESTS_TARGETS})
    install(EXPORT ${tool}Targets
        FILE ${tool}Targets.cmake
        NAMESPACE ${PROJECT_NAME}::
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})
endforeach()

if(${CMAKE_VERSION} VERSION_GREATER "2.8.11")
    target_include_directories(${PROJECT_NAME} PUBLIC $<INSTALL_INTERFACE:include>)         
endif()

configure_file(${CMAKE_SOURCE_DIR}/cmake/Config.cmake
               ${CMAKE_BINARY_DIR}/${PROJECT_NAME}Config.cmake
               @ONLY)
configure_file(${CMAKE_SOURCE_DIR}/cmake/ConfigVersion.cmake
               ${CMAKE_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
               @ONLY)

install(FILES ${CMAKE_BINARY_DIR}/${PROJECT_NAME}Config.cmake
              ${CMAKE_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})
