# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.9

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


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
CMAKE_COMMAND = /home/sjming/Documents/software/clion-2017.3/bin/cmake/bin/cmake

# The command to remove a file.
RM = /home/sjming/Documents/software/clion-2017.3/bin/cmake/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/sjming/Documents/caffe-source-code-analysis/caffe-test

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/sjming/Documents/caffe-source-code-analysis/caffe-test/cmake-build-debug

# Include any dependencies generated for this target.
include examples/CMakeFiles/classification.dir/depend.make

# Include the progress variables for this target.
include examples/CMakeFiles/classification.dir/progress.make

# Include the compile flags for this target's objects.
include examples/CMakeFiles/classification.dir/flags.make

examples/CMakeFiles/classification.dir/cpp_classification/classification.cpp.o: examples/CMakeFiles/classification.dir/flags.make
examples/CMakeFiles/classification.dir/cpp_classification/classification.cpp.o: ../examples/cpp_classification/classification.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/sjming/Documents/caffe-source-code-analysis/caffe-test/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object examples/CMakeFiles/classification.dir/cpp_classification/classification.cpp.o"
	cd /home/sjming/Documents/caffe-source-code-analysis/caffe-test/cmake-build-debug/examples && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/classification.dir/cpp_classification/classification.cpp.o -c /home/sjming/Documents/caffe-source-code-analysis/caffe-test/examples/cpp_classification/classification.cpp

examples/CMakeFiles/classification.dir/cpp_classification/classification.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/classification.dir/cpp_classification/classification.cpp.i"
	cd /home/sjming/Documents/caffe-source-code-analysis/caffe-test/cmake-build-debug/examples && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/sjming/Documents/caffe-source-code-analysis/caffe-test/examples/cpp_classification/classification.cpp > CMakeFiles/classification.dir/cpp_classification/classification.cpp.i

examples/CMakeFiles/classification.dir/cpp_classification/classification.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/classification.dir/cpp_classification/classification.cpp.s"
	cd /home/sjming/Documents/caffe-source-code-analysis/caffe-test/cmake-build-debug/examples && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/sjming/Documents/caffe-source-code-analysis/caffe-test/examples/cpp_classification/classification.cpp -o CMakeFiles/classification.dir/cpp_classification/classification.cpp.s

examples/CMakeFiles/classification.dir/cpp_classification/classification.cpp.o.requires:

.PHONY : examples/CMakeFiles/classification.dir/cpp_classification/classification.cpp.o.requires

examples/CMakeFiles/classification.dir/cpp_classification/classification.cpp.o.provides: examples/CMakeFiles/classification.dir/cpp_classification/classification.cpp.o.requires
	$(MAKE) -f examples/CMakeFiles/classification.dir/build.make examples/CMakeFiles/classification.dir/cpp_classification/classification.cpp.o.provides.build
.PHONY : examples/CMakeFiles/classification.dir/cpp_classification/classification.cpp.o.provides

examples/CMakeFiles/classification.dir/cpp_classification/classification.cpp.o.provides.build: examples/CMakeFiles/classification.dir/cpp_classification/classification.cpp.o


# Object files for target classification
classification_OBJECTS = \
"CMakeFiles/classification.dir/cpp_classification/classification.cpp.o"

# External object files for target classification
classification_EXTERNAL_OBJECTS =

examples/cpp_classification/classification-d: examples/CMakeFiles/classification.dir/cpp_classification/classification.cpp.o
examples/cpp_classification/classification-d: examples/CMakeFiles/classification.dir/build.make
examples/cpp_classification/classification-d: lib/libcaffe-d.so.1.0.0
examples/cpp_classification/classification-d: lib/libcaffeproto-d.a
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libboost_system.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libboost_thread.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libboost_filesystem.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libboost_chrono.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libboost_date_time.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libboost_atomic.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libglog.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libgflags.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libprotobuf.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5_cpp.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libpthread.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libsz.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libz.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libdl.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libm.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5_hl_cpp.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5_hl.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5_cpp.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libpthread.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libsz.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libz.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libdl.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libm.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5_hl_cpp.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/hdf5/serial/libhdf5_hl.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/liblmdb.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libleveldb.so
examples/cpp_classification/classification-d: /usr/local/cuda/lib64/libcudart.so
examples/cpp_classification/classification-d: /usr/local/cuda/lib64/libcurand.so
examples/cpp_classification/classification-d: /usr/local/cuda/lib64/libcublas.so
examples/cpp_classification/classification-d: /usr/local/cuda/lib64/libcublas_device.a
examples/cpp_classification/classification-d: /usr/local/cuda/lib64/libcudnn.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libopencv_highgui.so.2.4.9
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libopencv_imgproc.so.2.4.9
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libopencv_core.so.2.4.9
examples/cpp_classification/classification-d: /usr/lib/liblapack.so
examples/cpp_classification/classification-d: /usr/lib/libcblas.so
examples/cpp_classification/classification-d: /usr/lib/libatlas.so
examples/cpp_classification/classification-d: /usr/lib/x86_64-linux-gnu/libboost_python.so
examples/cpp_classification/classification-d: examples/CMakeFiles/classification.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/sjming/Documents/caffe-source-code-analysis/caffe-test/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable cpp_classification/classification-d"
	cd /home/sjming/Documents/caffe-source-code-analysis/caffe-test/cmake-build-debug/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/classification.dir/link.txt --verbose=$(VERBOSE)
	cd /home/sjming/Documents/caffe-source-code-analysis/caffe-test/cmake-build-debug/examples && ln -sf /home/sjming/Documents/caffe-source-code-analysis/caffe-test/cmake-build-debug/examples/cpp_classification/classification-d /home/sjming/Documents/caffe-source-code-analysis/caffe-test/cmake-build-debug/examples/cpp_classification/classification-d.bin

# Rule to build all files generated by this target.
examples/CMakeFiles/classification.dir/build: examples/cpp_classification/classification-d

.PHONY : examples/CMakeFiles/classification.dir/build

examples/CMakeFiles/classification.dir/requires: examples/CMakeFiles/classification.dir/cpp_classification/classification.cpp.o.requires

.PHONY : examples/CMakeFiles/classification.dir/requires

examples/CMakeFiles/classification.dir/clean:
	cd /home/sjming/Documents/caffe-source-code-analysis/caffe-test/cmake-build-debug/examples && $(CMAKE_COMMAND) -P CMakeFiles/classification.dir/cmake_clean.cmake
.PHONY : examples/CMakeFiles/classification.dir/clean

examples/CMakeFiles/classification.dir/depend:
	cd /home/sjming/Documents/caffe-source-code-analysis/caffe-test/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/sjming/Documents/caffe-source-code-analysis/caffe-test /home/sjming/Documents/caffe-source-code-analysis/caffe-test/examples /home/sjming/Documents/caffe-source-code-analysis/caffe-test/cmake-build-debug /home/sjming/Documents/caffe-source-code-analysis/caffe-test/cmake-build-debug/examples /home/sjming/Documents/caffe-source-code-analysis/caffe-test/cmake-build-debug/examples/CMakeFiles/classification.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : examples/CMakeFiles/classification.dir/depend
