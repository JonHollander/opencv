Building contrib modules required setting flags on python build script

```
--cmake_option="-DOPENCV_EXTRA_MODULES_PATH=$opencv_contrib_dir" --cmake_option="-DWITH_EIGEN=ON" --cmake_option="-DEIGEN_INCLUDE_PATH=$eigen_dir"
``` 

Eigen flags are used for alphamat
See ./build_wasm_static_opencv.sh

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

To build native alphamat with test program
```
cmake -DOPENCV_EXTRA_MODULES_PATH=~/Dev/opencv_contrib/modules -DWITH_EIGEN=ON -DEIGEN_INCLUDE_PATH=~/Dev/eigen-3.4.0 -DBUILD_EXAMPLES=ON -DBUILD_TESTS=ON ../opencv

cmake --build . --config Release --target example_alphamat_information_flow_matting

```
