# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 2.8

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list

# Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/hex/dependencies/levmar-2.6

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/hex/dependencies/levmar-2.6

# Include any dependencies generated for this target.
include CMakeFiles/lmdemo.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/lmdemo.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/lmdemo.dir/flags.make

CMakeFiles/lmdemo.dir/lmdemo.c.o: CMakeFiles/lmdemo.dir/flags.make
CMakeFiles/lmdemo.dir/lmdemo.c.o: lmdemo.c
	$(CMAKE_COMMAND) -E cmake_progress_report /home/hex/dependencies/levmar-2.6/CMakeFiles $(CMAKE_PROGRESS_1)
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Building C object CMakeFiles/lmdemo.dir/lmdemo.c.o"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -o CMakeFiles/lmdemo.dir/lmdemo.c.o   -c /home/hex/dependencies/levmar-2.6/lmdemo.c

CMakeFiles/lmdemo.dir/lmdemo.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/lmdemo.dir/lmdemo.c.i"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -E /home/hex/dependencies/levmar-2.6/lmdemo.c > CMakeFiles/lmdemo.dir/lmdemo.c.i

CMakeFiles/lmdemo.dir/lmdemo.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/lmdemo.dir/lmdemo.c.s"
	/usr/bin/cc  $(C_DEFINES) $(C_FLAGS) -S /home/hex/dependencies/levmar-2.6/lmdemo.c -o CMakeFiles/lmdemo.dir/lmdemo.c.s

CMakeFiles/lmdemo.dir/lmdemo.c.o.requires:
.PHONY : CMakeFiles/lmdemo.dir/lmdemo.c.o.requires

CMakeFiles/lmdemo.dir/lmdemo.c.o.provides: CMakeFiles/lmdemo.dir/lmdemo.c.o.requires
	$(MAKE) -f CMakeFiles/lmdemo.dir/build.make CMakeFiles/lmdemo.dir/lmdemo.c.o.provides.build
.PHONY : CMakeFiles/lmdemo.dir/lmdemo.c.o.provides

CMakeFiles/lmdemo.dir/lmdemo.c.o.provides.build: CMakeFiles/lmdemo.dir/lmdemo.c.o

# Object files for target lmdemo
lmdemo_OBJECTS = \
"CMakeFiles/lmdemo.dir/lmdemo.c.o"

# External object files for target lmdemo
lmdemo_EXTERNAL_OBJECTS =

lmdemo: CMakeFiles/lmdemo.dir/lmdemo.c.o
lmdemo: CMakeFiles/lmdemo.dir/build.make
lmdemo: liblevmar.a
lmdemo: CMakeFiles/lmdemo.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --red --bold "Linking C executable lmdemo"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/lmdemo.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/lmdemo.dir/build: lmdemo
.PHONY : CMakeFiles/lmdemo.dir/build

CMakeFiles/lmdemo.dir/requires: CMakeFiles/lmdemo.dir/lmdemo.c.o.requires
.PHONY : CMakeFiles/lmdemo.dir/requires

CMakeFiles/lmdemo.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/lmdemo.dir/cmake_clean.cmake
.PHONY : CMakeFiles/lmdemo.dir/clean

CMakeFiles/lmdemo.dir/depend:
	cd /home/hex/dependencies/levmar-2.6 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/hex/dependencies/levmar-2.6 /home/hex/dependencies/levmar-2.6 /home/hex/dependencies/levmar-2.6 /home/hex/dependencies/levmar-2.6 /home/hex/dependencies/levmar-2.6/CMakeFiles/lmdemo.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/lmdemo.dir/depend

