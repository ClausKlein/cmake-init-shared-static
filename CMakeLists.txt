cmake_minimum_required(VERSION 3.25...3.29)

include(cmake/prelude.cmake)

project(
  shared
  VERSION 0.1.0
  DESCRIPTION "Short description"
  HOMEPAGE_URL "https://example.com/"
  LANGUAGES CXX
)

include(cmake/variables.cmake)

# ---- Declare library ----

add_library(shared_shared source/shared.cpp)

add_library(shared::shared ALIAS shared_shared)

include(GenerateExportHeader)
generate_export_header(
  shared_shared
  BASE_NAME
  shared
  EXPORT_FILE_NAME
  export/shared/shared_export.hpp
  CUSTOM_CONTENT_FROM_VARIABLE
  pragma_suppress_c4251
)

# cmake-format: off
target_sources(
  shared_shared PUBLIC
    FILE_SET HEADERS
    BASE_DIRS include
      ${PROJECT_BINARY_DIR}/export
    FILES include/shared/shared.hpp
      ${PROJECT_BINARY_DIR}/export/shared/shared_export.hpp
)
# cmake-format: on

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(shared_shared PUBLIC SHARED_STATIC_DEFINE)
endif()

set_target_properties(
  shared_shared
  PROPERTIES CXX_VISIBILITY_PRESET hidden
             VISIBILITY_INLINES_HIDDEN YES
             VERSION "${PROJECT_VERSION}"
             SOVERSION "${PROJECT_VERSION_MAJOR}"
             EXPORT_NAME shared
             OUTPUT_NAME shared
)

target_compile_features(shared_shared PUBLIC cxx_std_20)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT shared_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(AUTHOR_WARNING "Developer mode is intended for developers of shared")
endif()

include(cmake/dev-mode.cmake)
