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
CMAKE_SOURCE_DIR = /home/ms/Lynx/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ms/Lynx/build

# Utility rule file for _run_tests_serial_gtest_serial-test.

# Include the progress variables for this target.
include serial/tests/CMakeFiles/_run_tests_serial_gtest_serial-test.dir/progress.make

serial/tests/CMakeFiles/_run_tests_serial_gtest_serial-test:
	cd /home/ms/Lynx/build/serial/tests && ../../catkin_generated/env_cached.sh /usr/bin/python /opt/ros/indigo/share/catkin/cmake/test/run_tests.py /home/ms/Lynx/build/test_results/serial/gtest-serial-test.xml /home/ms/Lynx/devel/lib/serial/serial-test\ --gtest_output=xml:/home/ms/Lynx/build/test_results/serial/gtest-serial-test.xml

_run_tests_serial_gtest_serial-test: serial/tests/CMakeFiles/_run_tests_serial_gtest_serial-test
_run_tests_serial_gtest_serial-test: serial/tests/CMakeFiles/_run_tests_serial_gtest_serial-test.dir/build.make
.PHONY : _run_tests_serial_gtest_serial-test

# Rule to build all files generated by this target.
serial/tests/CMakeFiles/_run_tests_serial_gtest_serial-test.dir/build: _run_tests_serial_gtest_serial-test
.PHONY : serial/tests/CMakeFiles/_run_tests_serial_gtest_serial-test.dir/build

serial/tests/CMakeFiles/_run_tests_serial_gtest_serial-test.dir/clean:
	cd /home/ms/Lynx/build/serial/tests && $(CMAKE_COMMAND) -P CMakeFiles/_run_tests_serial_gtest_serial-test.dir/cmake_clean.cmake
.PHONY : serial/tests/CMakeFiles/_run_tests_serial_gtest_serial-test.dir/clean

serial/tests/CMakeFiles/_run_tests_serial_gtest_serial-test.dir/depend:
	cd /home/ms/Lynx/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ms/Lynx/src /home/ms/Lynx/src/serial/tests /home/ms/Lynx/build /home/ms/Lynx/build/serial/tests /home/ms/Lynx/build/serial/tests/CMakeFiles/_run_tests_serial_gtest_serial-test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : serial/tests/CMakeFiles/_run_tests_serial_gtest_serial-test.dir/depend

