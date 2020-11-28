# Repo directory

## Apriltag
[Apriltag](https://github.com/AprilRobotics/apriltag) is a visual fiducial system popular for robotics research. Install with:
```
git clone https://github.com/AprilRobotics/apriltag.git
cd apriltag
mkdir build && cd build
cmake .. && sudo make install
```

## Brief Usage
Wrappers to Apriltag, e.g. [apriltag_ros](http://wiki.ros.org/apriltag_ros) are available for use. Developing an application using the native Apriltag API can be tricky due to its C-style syntax.

---
## ${fmt}
[fmt](https://github.com/fmtlib/fmt) is a modern formatting library providing type-safe string formatting with python-inspired syntax. Slated to be incorporated into the C++20 standard as `std::format`
```
git clone https://github.com/fmtlib/fmt.git
cd fmt
mkdir build && cd build
cmake .. && sudo make install
```

## Brief Usage
Format a string with fmt by
```
#define FMT_HEADER ONLY
// Use fmt in header only mode, avoiding linking to fmt libraries
// Downside is increased binary size and compile time
#include <fmt/format.h>

int main() {
    constexpr double kPi = 3.1415926;
    // Center align, field width 6, keep 3 decimal points
    std::string sentence = fmt::format("The value of pi is {:^6.3}", kPi);

    // Print using fmt syntax directly, avoiding ostream
    fmt::print("The value of pi is {:^6.3}", kPi);
    
    return 0;
}
```

---
## cxxopts
[cxxopts](https://github.com/jarro2783/cxxopts) is a lightweight C++ command line option parser. This is a header only library. Obtain the header ```cxxopts.hpp``` from the source repository by
```
git clone https://github.com/jarro2783/cxxopts.git
```

## Brief Usage
Clone ths cxxopts repository (or add as subtree / submodule) into your project directory, then include the header file `cxxopts.hpp`. The following example is adapted from cxxopts readme.
```
#include "cxxopts/cxxopts.hpp"

int main(int argc, char **argv) {
    cxxopts::Options opts("Project", "Description");

    opts.add_options()
      ("b,bool", "A bool") // Implied to be false by default
      ("i,integer", "An int", cxxopts::value<int>()->default_value("100"));

    cxxopts::ParseResult res = opts.parse(argc, argv);

    const bool bool_arg = res["bool"].as<bool>();
    const int int_arg = res["int"].as<int>();

    return 0;
}
```

---
## Ceres
[Ceres](https://github.com/ceres-solver/ceres-solver) is a large scale non-linear optimization library. Install Ceres from source with the following steps
1. Install dependencies
```
sudo apt-get install \
cmake \
libgoogle-glog-dev \
libgflags-dev \
libatlas-base-dev \
libeigen3-dev \
libsuitesparse-dev
```
2. Clone the Ceres sources
```
git clone https://github.com/ceres-solver/ceres-solver.git
cd ceres-solver
```
3. Configure the CMake build system and build and install
```
mkdir build && cd build
cmake .. && sudo make install
```

---
## OpenCV
[OpenCV](https://github.com/opencv/opencv) is an extensively used Open Source Computer Vision Library. For most basic applications, install from repositories with
```
sudo apt-get install python-opencv
```

For more advanced applications, install OpenCV from source with the following steps

1. Install dependencies

```
sudo apt-get install -y \
build-essential \
cmake \
g++ \
gcc \
libavcodec-dev \
libavformat-dev \
libgstreamer-plugins-base1.0-dev \
libgstreamer1.0-dev \
libgtk2.0-dev \
libjpeg-dev \
libopenexr-dev \
libpng-dev \
libswscale-dev \
libtiff-dev \
libwebp-dev \
python3-dev \
python3-numpy
```

2. Clone the OpenCV sources and checkout a recent stable branch. 
```
git clone https://github.com/opencv/opencv.git
cd opencv
git checkout 4.5.0
```

3. Configure the CMake build system. The following example adds Python3 linkage and Gstreamer support.
```
cd opencv
mkdir build && cd build 
cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D INSTALL_C_EXAMPLES=OFF \
-D PYTHON_EXECUTABLE=$(which python3) \
-D BUILD_opencv_python2=OFF \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D PYTHON3_EXECUTABLE=$(which python3) \
-D PYTHON3_INCLUDE_DIR=$(python3 -c 'from distutils.sysconfig import get_python_inc; print(get_python_inc())') \
-D PYTHON3_PACKAGES_PATH=$(python3 -c 'from distutils.sysconfig import get_python_lib; print(get_python_lib())') \
-D WITH_GSTREAMER=ON \
-D BUILD_EXAMPLES=ON ..
```
4. Build and install
```
sudo make install
```

---
## Sophus
[Sophus](https://github.com/strasdat/Sophus) is a C++ implementation of Lie Groups using Eigen. Install with:
```
https://github.com/strasdat/Sophus.git
cd Sophus
mkdir build && cd build
cmake .. && sudo make install
```

## Brief Usage
The following example demonstrates constructing SO3 and SE3 objects and interacting with them using exponential and log maps
```
#include <iostream>
#include <Eigen/Dense>
#include <Eigen/Geometry>
#include <sophus/se3.hpp>
#include <sophus/so3.hpp>

int main(void) {

    Eigen::Vector3d phi(0.3, 0, 0); // Rotation vector (c.f. rodrigues parameter)
    Sophus::SO3d C = Sophus::SO3d::exp(phi);    // SO3 exponential map
    Eigen::Vector3d r(1, 2, 3);     // Translation vector
    Sophus::SE3d T(C, r);

    Sophus::Vector6d xi;    // 6-DOF generalized velocity (c.f. twist)
    xi << 0.1, 0.2, 0.3, 0.4, 0.5, 0.6;
    
    double dT = 1e-3;
    Sophus::SE3d T_plus_dT = Sophus::SE3d::exp(xi * dT) * T;
    Sophus::Vector6d result = T_plus_dT.log();
    
    std::cout << result << "\n";
    return 0;
}
```