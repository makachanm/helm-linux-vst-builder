FROM docker.io/library/debian:trixie

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates git build-essential cmake ninja-build pkg-config \
      libasound2-dev libfreetype-dev libcurl4-openssl-dev libgl1-mesa-dev \
      libx11-dev libxext-dev libxinerama-dev libxrandr-dev libxcursor-dev libxcomposite-dev \
 && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --recurse-submodules --shallow-submodules https://github.com/dsp56300/gearmulator.git /gearmulator

WORKDIR /gearmulator
RUN cmake -G Ninja -B build -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF \
      -Dgearmulator_BUILD_JUCEPLUGIN=ON \
      -Dgearmulator_BUILD_JUCEPLUGIN_VST2=OFF \
      -Dgearmulator_BUILD_JUCEPLUGIN_VST3=OFF \
      -Dgearmulator_BUILD_JUCEPLUGIN_CLAP=OFF \
      -Dgearmulator_BUILD_JUCEPLUGIN_LV2=ON \
      -Dgearmulator_BUILD_JUCEPLUGIN_Standalone=ON \
 && cmake --build build -j"$(nproc)"

# 88Emu has no plugin version upstream, only the standalone 88emuPlayer app
RUN mkdir -p /out && cd /gearmulator/bin/plugins/Release \
 && cp -r LV2 /out/ \
 && cp Standalone/88emuPlayer /out/
