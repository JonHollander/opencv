# Building OpenCV as a static WASM library
Source emscripten and run the attached shell script 
```bash
build_wasm_static_opencv.sh <target_directory> <optional_dir_for_opencv_contrib> <optional_dir_for_eigen_lib>
```
# Notes on using alphamat from OpenCV contrib repo
The following flags are set automatically if an opencv_contrib directory is included as an arg for the build script.

Building contrib modules required setting flags on python build script

```
--cmake_option="-DOPENCV_EXTRA_MODULES_PATH=$opencv_contrib_dir" --cmake_option="-DWITH_EIGEN=ON" --cmake_option="-DEIGEN_INCLUDE_PATH=$eigen_dir"
``` 

Eigen flags are used for alphamat
See ./build_wasm_static_opencv.sh

## Generating WASM binding for alphamat
However, alphamat is not included in the opencv output for js by default. Following the instructions here, 
https://github.com/ganwenyao/opencv_js

add 'js' as a platform in the desired modules CMakeLists.txt file, such as in alphamat/CMakeLists.txt
```
ocv_define_module(alphamat
    opencv_core
    opencv_imgproc
    WRAP python
    ***js***
)
```

Also, in the main opencv repo, update core_bindings.cpp with the added module's namespace

```
#ifdef HAVE_OPENCV_ALPHAMAT
using namespace alphamat;
#endif

```

# Building alphamat as native app for testing
To build native alphamat with test program
```
cmake -DOPENCV_EXTRA_MODULES_PATH=~/Dev/opencv_contrib/modules -DWITH_EIGEN=ON -DEIGEN_INCLUDE_PATH=~/Dev/eigen-3.4.0 -DBUILD_EXAMPLES=ON -DBUILD_TESTS=ON ../opencv

cmake --build . --config Release --target example_alphamat_information_flow_matting

```
