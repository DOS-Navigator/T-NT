cmake_minimum_required(VERSION 3.10)

project(t2nt LANGUAGES CXX C)

# Parameterize compiler using CXX and CC
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_C_STANDARD 99)

# Compiler-specific options
if(MSVC)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS) # Disable deprecation warnings
    add_compile_options(/W4) # Warning level 4
else()
    add_compile_options(-Wall -Wextra -pedantic) # Enable all major warnings
endif()

# Source files
set(SOURCES 
  src/main.cpp
  src/lexer/scanner.l
  src/parser/grammar.y
  src/parser/ast.cpp
  src/ir/ir.cpp
  src/codegen/nasmgen.cpp
)

set(FL_LIBRARY "C:/tools/msys64/usr/lib/libfl.a")


# Flex/Bison generated files  
find_package(FLEX REQUIRED)
find_package(BISON REQUIRED)

flex_target(Scanner src/lexer/scanner.l ${CMAKE_CURRENT_BINARY_DIR}/scanner.cpp) 
bison_target(Grammar src/parser/grammar.y ${CMAKE_CURRENT_BINARY_DIR}/grammar.cpp)

add_flex_bison_dependency(Scanner Grammar)

list(APPEND SOURCES ${BISON_Grammar_OUTPUTS} ${FLEX_Scanner_OUTPUTS})

# Executable
add_executable(t2nt ${SOURCES}) 

# Link flex/bison libraries as needed
target_link_libraries(t2nt ${FLEX_LIBRARIES} ${BISON_LIBRARIES})

# If you need to link against Windows libraries, do it here.
if(WIN32)
    # e.g., target_link_libraries(t2nt some_windows_lib)
endif()

# Include the directory where the flex/bison generated files are.
target_include_directories(t2nt PRIVATE ${CMAKE_CURRENT_BINARY_DIR})

# Install to bin directory
install(TARGETS t2nt RUNTIME DESTINATION bin)
