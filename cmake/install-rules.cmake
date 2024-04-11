if(PROJECT_IS_TOP_LEVEL)
  set(
      CMAKE_INSTALL_INCLUDEDIR "include/shared-${PROJECT_VERSION}"
      CACHE STRING ""
  )
  set_property(CACHE CMAKE_INSTALL_INCLUDEDIR PROPERTY TYPE PATH)
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package shared)

install(
    TARGETS shared_shared
    EXPORT sharedTargets
    RUNTIME #
    COMPONENT shared_Runtime
    LIBRARY #
    COMPONENT shared_Runtime
    NAMELINK_COMPONENT shared_Development
    ARCHIVE #
    COMPONENT shared_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    FILE_SET HEADERS
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    shared_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE STRING "CMake package config location relative to the install prefix"
)
set_property(CACHE shared_INSTALL_CMAKEDIR PROPERTY TYPE PATH)
mark_as_advanced(shared_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${shared_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT shared_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${shared_INSTALL_CMAKEDIR}"
    COMPONENT shared_Development
)

install(
    EXPORT sharedTargets
    NAMESPACE shared::
    DESTINATION "${shared_INSTALL_CMAKEDIR}"
    COMPONENT shared_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
