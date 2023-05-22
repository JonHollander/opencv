#!/bin/bash
# cwd=$(pwd)
# Official build instructions don't seem to work, but this does
# https://github.com/mpizenberg/emscripten-opencv
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
opencv_src_dir=$script_dir/../../
emscripten_dir=$EMSDK
opencv_build_dir=$1/opencv-build-wasm
opencv_contrib_dir=$2/modules
eigen_dir=$3


echo Installing OpenCV from $opencv_src_dir to $opencv_build_dir

#Build OpenCV
export EMSCRIPTEN=$emscripten_dir/upstream/emscripten
#Threads
#python $opencv_src_dir/platforms/js/build_js.py $opencv_build_dir --build_wasm --threads --emscripten_dir=$emscripten_dir/upstream/emscripten/ --config=$opencv_src_dir/platforms/js/opencv_js.config.py
python $opencv_src_dir/platforms/js/build_js.py $opencv_build_dir --build_wasm --emscripten_dir=$emscripten_dir/upstream/emscripten/ --config=$opencv_src_dir/platforms/js/opencv_js.config.py --cmake_option="-DOPENCV_EXTRA_MODULES_PATH=$opencv_contrib_dir" --cmake_option="-DWITH_EIGEN=ON" --cmake_option="-DEIGEN_INCLUDE_PATH=$eigen_dir" --cmake_option="-DCMAKE_BUILD_TYPE=Debug"

#Copy header files to build_dir
mkdir -p $opencv_build_dir/include

cp -r $opencv_src_dir/include $opencv_build_dir/
cp -r $opencv_src_dir/modules $opencv_build_dir/
mkdir $opencv_build_dir/contrib
cp -r $opencv_contrib_dir $opencv_build_dir/contrib