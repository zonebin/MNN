#!/bin/bash

current_path=`dirname $0`
echo current_path:$current_path
build_path=$current_path/build/

if [ -d $build_path ]; then
        cd $build_path
        make clean
        cd -
fi

if [ ! -d $build_path ]; then
        mkdir -p $build_path
fi

cd $build_path
pwd
cmake   -DCMAKE_BUILD_TYPE=Debug  \
        -DMNN_BUILD_SHARED_LIBS=ON  \
        -DMNN_FORBID_MULTI_THREAD=OFF   \
        -DMNN_OPENMP=OFF    \
        -DMNN_USE_THREAD_POOL=ON    \
        -DMNN_BUILD_DEMO=ON     \
        -DMNN_BUILD_QUANTOOLS=ON    \
        -DMNN_BUILD_TRAIN=OFF   \
        -DMNN_EVALUATION=OFF    \
        -DMNN_BUILD_CONVERTER=ON    \
        -DMNN_SUPPORT_TFLITE_QUAN=ON    \
        -DMNN_DEBUG_MEMORY=ON   \
        -DMNN_DEBUG_TENSOR_SIZE=ON  \
        -DMNN_GPU_TRACE=OFF     \
        -DMNN_PORTABLE_BUILD=OFF    \
        -DMNN_SEP_BUILD=OFF     \
        -DMNN_USE_SSE=ON    \
        -DMNN_USE_AVX=ON        \
        -DMNN_METAL=OFF         \
        -DMNN_OPENCL=OFF        \
        -DMNN_OPENGL=OFF        \
        -DMNN_VULKAN=OFF        \
        -DMNN_ARM82=OFF         \
        -DMNN_BUILD_BENCHMARK=ON    \
        -DMNN_BUILD_TEST=ON \
        -DMNN_BUILD_FOR_ANDROID_COMMAND=OFF \
        ..
if [ $? -ne 0 ]; then
echo "[ERROR] cmake failed..."
exit -1
fi

make -j6
if [ $? -ne 0 ]; then
echo "[ERROR] make failed..."
exit -1
fi
