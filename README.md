# lv2plugin-buildscripts

Build Linux LV2 plugins with Docker/Podman.

`make` and `docker` or `podman` is required. (for GCC 8 dependency)

- `helm` — [mtytel/helm](https://github.com/mtytel/helm)
- `gearmulator` — [dsp56300/gearmulator](https://github.com/dsp56300/gearmulator)
- `chowmatrix` — [Chowdhury-DSP/ChowMatrix](https://github.com/Chowdhury-DSP/ChowMatrix)
- `chowmultitool` — [Chowdhury-DSP/ChowMultiTool](https://github.com/Chowdhury-DSP/ChowMultiTool)

```sh
make all          # build everything (if you want to build all of these)

make helm          # build helm
make gearmulator   # build gearmulator
make chowmatrix    # build chowmatrix
make chowmultitool # build chowmultitool

make install      # copy built plugins to ~/.lv2 (REAPER reads it)
make clean        # clear out/
```

Output goes to `out/<synth>/`.
