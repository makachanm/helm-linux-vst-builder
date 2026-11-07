FROM docker.io/library/gcc:8

RUN sed -i 's|deb.debian.org|archive.debian.org|g; s|security.debian.org|archive.debian.org|g; /buster-updates/d' /etc/apt/sources.list \
 && apt-get -o Acquire::Check-Valid-Until=false update \
 && apt-get install -y --no-install-recommends git pkg-config \
      libasound2-dev libjack-jackd2-dev libfreetype6-dev libcurl4-openssl-dev \
      libx11-dev libxext-dev libxinerama-dev libxcursor-dev libxrandr-dev libxcomposite-dev libgl1-mesa-dev

RUN git clone --depth 1 https://github.com/mtytel/helm.git /helm \
 && make -C /helm vst -j"$(nproc)"
