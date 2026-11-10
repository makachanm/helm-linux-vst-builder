FROM docker.io/library/debian:bookworm

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates git build-essential cmake pkg-config python3 \
      libcairo2-dev libx11-dev libxft-dev libfontconfig-dev libjpeg-dev libpng-dev libsndfile1-dev libgl1-mesa-dev lv2-dev \
 && rm -rf /var/lib/apt/lists/*

# Fabla links NTK statically; Debian doesn't package it
RUN git clone --depth 1 https://github.com/linuxaudio/ntk.git /ntk \
 && cd /ntk && python3 waf configure && python3 waf -j"$(nproc)" && python3 waf install

RUN git clone --depth 1 https://github.com/openAVproductions/openAV-Fabla.git /src

# upstream crashes on patch:Get for an empty pad (REAPER does this on load)
COPY empty-pad-crash.patch /
RUN patch -d /src -p1 < /empty-pad-crash.patch

RUN cd /src && PKG_CONFIG_PATH=/src cmake -S . -B /build -DCMAKE_INSTALL_PREFIX=/prefix \
 && cmake --build /build -j"$(nproc)" && cmake --install /build

RUN mkdir -p /out && cp -r /prefix/lib/lv2/. /out/
