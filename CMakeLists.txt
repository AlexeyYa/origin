cmake_minimum_required(VERSION 3.5)

if($ENV{TRAVIS_BUILD_NUMBER})
    project(HelloWorld VERSION 0.1.$ENV{TRAVIS_BUILD_NUMBER} LANGUAGES CXX)
else()
    project(HelloWorld VERSION 0.1.1 LANGUAGES CXX)
endif()

# Download and unpack googletest at configure time
configure_file(CMakeLists.txt.in googletest-download/CMakeLists.txt)
execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/googletest-download )
if(result)
  message(FATAL_ERROR "CMake step for googletest failed: ${result}")
endif()
execute_process(COMMAND ${CMAKE_COMMAND} --build .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/googletest-download )
if(result)
  message(FATAL_ERROR "Build step for googletest failed: ${result}")
endif()

# Prevent overriding the parent project's compiler/linker
# settings on Windows
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

# Add googletest directly to our build. This defines
# the gtest and gtest_main targets.
add_subdirectory(${CMAKE_CURRENT_BINARY_DIR}/googletest-src
                 ${CMAKE_CURRENT_BINARY_DIR}/googletest-build
                 EXCLUDE_FROM_ALL)

# The gtest/gtest_main targets carry header search path
# dependencies automatically when using CMake 2.8.11 or
# later. Otherwise we have to add them here ourselves.
if (CMAKE_VERSION VERSION_LESS 2.8.11)
  include_directories("${gtest_SOURCE_DIR}/include")
endif()

# Now simply link against gtest or gtest_main as needed. Eg
#add_executable(example example.cpp)
#target_link_libraries(example gtest_main)
#add_test(NAME example_test COMMAND example)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(USE_VERSION "Use version" ON)


configure_file(bintray.json.in bintray.json)
if(USE_VERSION)
    configure_file(tutorial.h.in tutorial.h)
endif()

add_executable(HelloWorld main.cpp)

target_include_directories(HelloWorld PUBLIC
                            "${PROJECT_BINARY_DIR}"
                            )

install(TARGETS HelloWorld DESTINATION bin)
install(FILES "${PROJECT_BINARY_DIR}/tutorial.h"
    DESTINATION include
    )

include(InstallRequiredSystemLibraries)
set(CPACK_PACKAGE_VERSION_MAJOR "${HelloWorld_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${HelloWorld_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${HelloWorld_VERSION_PATCH}")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Alexey")
include(CPack)

#add_executable(tests tests/tests.cpp)

# Add src to the include directories for the test target
#target_include_directories(
#    tests PRIVATE
#    "${CMAKE_CURRENT_SOURCE_DIR}"
#)

# Link test target against gtest libraries
#target_link_libraries(tests PRIVATE gtest gtest_main)

#if (MSVC)
#    target_compile_options(
#        HelloWorld PRIVATE
#        /W4
#    )
#    target_compile_options(
#        tests PRIVATE
#        /W4
#    )
#else ()
#    target_compile_options(
#        HelloWorld PRIVATE
#        -Wall -Wextra -pedantic -Werror
#    )
#    target_compile_options(
#        tests PRIVATE
#        -Wall -Wextra -pedantic -Werror
#    )
#endif()
