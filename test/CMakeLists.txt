cmake_minimum_required(VERSION 3.25...3.29)

project(sharedTests LANGUAGES CXX)

include(../cmake/folders.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package(shared REQUIRED)
  enable_testing()
endif()

# ---- Tests ----

add_executable(shared_test source/shared_test.cpp)
target_link_libraries(shared_test PRIVATE shared::shared)
target_compile_features(shared_test PRIVATE cxx_std_17)

add_test(NAME shared_test COMMAND shared_test)

# ---- End-of-file commands ----

add_folders(Test)
