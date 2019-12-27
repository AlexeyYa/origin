cmake_minimum_required(VERSION 3.5)

project(HelloWorld VERSION 0.1.$ENV{TRAVIS_BUILD_NUMBER} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(USE_MYMATH "Use tutorial provided math implementation" OFF)

configure_file(tutorial.h.in tutorial.h)

if(USE_MYMATH)
    add_subdirectory(MathFunctions)
    list(APPEND EXTRA_LIBS MathFunctions)
endif()

add_executable(HelloWorld main.cpp)

target_link_libraries(HelloWorld PUBLIC ${EXTRA_LIBS})

target_include_directories(HelloWorld PUBLIC
                            "${PROJECT_BINARY_DIR}"
                            )

install(TARGETS HelloWorld DESTINATION bin)
install(FILES "${PROJECT_BINARY_DIR}/tutorial.h"
    DESTINATION include
    )

enable_testing()

add_test(NAME Runs COMMAND HelloWorld 2)

add_test(NAME Counts COMMAND HelloWorld 7)
set_tests_properties(Counts
    PROPERTIES PASS_REGULAR_EXPRESSION "Hello World! OutVal 9")

include(InstallRequiredSystemLibraries)
set(CPACK_PACKAGE_VERSION_MAJOR "${HelloWorld_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${HelloWorld_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${HelloWorld_VERSION_PATCH}")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Alexey")
include(CPack)
