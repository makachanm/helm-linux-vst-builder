FROM docker.io/library/debian:bookworm

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates git build-essential clang cmake pkg-config \
      libasound2-dev libjack-jackd2-dev libcurl4-openssl-dev libfreetype6-dev libglu1-mesa-dev \
      libx11-dev libxext-dev libxinerama-dev libxrandr-dev libxcursor-dev libgtk-3-dev libwebkit2gtk-4.0-dev lv2-dev \
 && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --recurse-submodules --shallow-submodules https://github.com/Chowdhury-DSP/ChowMultiTool.git /src

# GCC hits an internal compiler error in LTO here; upstream CI builds with clang
RUN cmake -S /src -B /build -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ \
 && cmake --build /build --target ChowMultiTool_LV2 -j"$(nproc)"

RUN mkdir -p /out && find /build -type d -name '*.lv2' -path '*/LV2/*' -exec cp -r {} /out/ \;
