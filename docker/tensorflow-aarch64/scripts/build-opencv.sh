#!/usr/bin/env bash

# *******************************************************************************
# Copyright 2020-2021 Arm Limited and affiliates.
# SPDX-License-Identifier: Apache-2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# *******************************************************************************


set -euo pipefail

cd $PACKAGE_DIR
readonly package=opencv
readonly src_host=https://github.com/opencv
readonly src_repo=opencv
readonly num_cpus=$(grep -c ^processor /proc/cpuinfo)

git clone ${src_host}/${src_repo}.git
cd $src_repo
mkdir -p build
cd build

export CFLAGS="${BASE_CFLAGS} -O3"
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$PROD_DIR/$package/install ..

make -j ${NP_MAKE:-$((num_cpus / 2))}
make install


