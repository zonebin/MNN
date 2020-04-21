#!/bin/bash

platform=android-21
ANDROID_NDK=/opt/android-ndk-r21
ANDROID_TOOLCHAIN_CMAKE=$ANDROID_NDK/build/cmake/android.toolchain.cmake
ANDROID_ABI="armeabi-v7a with NEON"
ANDROID_PLATFORM=$platform

current_path=`dirname $0`
build_path=$current_path/build/$platform


if [ ! -d $build_path ]; then
        mkdir -p $build_path
fi

./schema/generate.sh

cd $build_path

cmake   -DCMAKE_TOOLCHAIN_FILE=$ANDROID_TOOLCHAIN_CMAKE \
        -DANDROID_NDK=$ANDROID_NDK    \
        -DANDROID_ABI=$ANDROID_ABI    \
        -DANDROID_PLATFORM=$ANDROID_PLATFORM  \
        -DCMAKE_BUILD_TYPE=Debug  \
        -DMNN_BUILD_SHARED_LIBS=ON  \
        -DMNN_FORBID_MULTI_THREAD=OFF   \
        -DMNN_OPENMP=OFF    \
        -DMNN_USE_THREAD_POOL=ON    \
        -DMNN_BUILD_DEMO=ON     \
        -DMNN_BUILD_QUANTOOLS=OFF    \
        -DMNN_BUILD_TRAIN=OFF   \
        -DMNN_EVALUATION=OFF    \
        -DMNN_BUILD_CONVERTER=OFF    \
        -DMNN_SUPPORT_TFLITE_QUAN=ON    \
        -DMNN_DEBUG_MEMORY=ON   \
        -DMNN_DEBUG_TENSOR_SIZE=ON  \
        -DMNN_GPU_TRACE=OFF \
        -DMNN_PORTABLE_BUILD=OFF    \
        -DMNN_SEP_BUILD=OFF \
        -DMNN_USE_SSE=OFF    \
        -DMNN_USE_AVX=OFF    \
        -DMNN_METAL=OFF \
        -DMNN_OPENCL=ON    \
        -DMNN_OPENGL=OFF    \
        -DMNN_VULKAN=OFF    \
        -DMNN_ARM82=OFF \
        -DMNN_BUILD_BENCHMARK=ON        \
        -DMNN_BUILD_TEST=OFF \
        -DMNN_BUILD_FOR_ANDROID_COMMAND=ON \
        ../..
if [ $? -ne 0 ]; then
echo "[ERROR] cmake failed..."
exit -1
fi

make -j6
if [ $? -ne 0 ]; then
echo "[ERROR make failed..."
exit -1
fi