FROM docker.io/library/debian:bookworm

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates git build-essential cmake pkg-config \
      libasound2-dev libjack-jackd2-dev libcurl4-openssl-dev libfreetype6-dev libglu1-mesa-dev \
      libx11-dev libxext-dev libxinerama-dev libxrandr-dev libxcursor-dev libgtk-3-dev libwebkit2gtk-4.0-dev lv2-dev \
 && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --recurse-submodules --shallow-submodules https://github.com/Chowdhury-DSP/ChowKick.git /src

RUN cmake -S /src -B /build -DCMAKE_BUILD_TYPE=Release \
 && cmake --build /build --target ChowKick_LV2 -j"$(nproc)"

RUN mkdir -p /out && find /build -type d -name '*.lv2' -path '*/LV2/*' -exec cp -r {} /out/ \;
