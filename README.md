# T2NT
This is a transpiler that converts  Turrbo Assembler (TASM) code to Netwide Assembler (NASM) assembly.


## Features
* Handles common TASM syntax including procedures, conditionals, loops, macros etc.
* Generates equivalent NASM assembly output.
* Intermediate representation for analysis and optimizations.
* Modular architecture with lexer, parser, IR and codegen stages.
* Built using Flex, Bison, CMake.
* Cross platform support for Linux, macOS and Windows.

## Usage

    t2nt <input.tasm> <output.nasm>

This will transpile the input TASM file to an equivalent NASM output file.

## Building
The project uses CMake as the build system.

To build on Linux/Mac:

~~~
mkdir build
cd build
cmake ..
make
~~~
This will generate the `t2nt` executable.

On Windows, use CMake GUI or adapt above commands for Visual Studio build.

## Contributing
Contributions are welcome! Please check issues or feel free to add new issues for bugs and feature requests.

## License
This project is licensed under the GPL license. See LICENSE for more details.

References
* TASM Manual
* NASM Manual
* Flex Manual
* Bison Manual
