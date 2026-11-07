# linux-lv2-buildscripts

Build Linux LV2 plugins with Docker/Podman.

- `helm` — [mtytel/helm](https://github.com/mtytel/helm) 
- `gearmulator` — [dsp56300/gearmulator](https://github.com/dsp56300/gearmulator) 
- `chowkick` — [Chowdhury-DSP/ChowKick](https://github.com/Chowdhury-DSP/ChowKick)
- `chowmatrix` — [Chowdhury-DSP/ChowMatrix](https://github.com/Chowdhury-DSP/ChowMatrix)
- `chowmultitool` — [Chowdhury-DSP/ChowMultiTool](https://github.com/Chowdhury-DSP/ChowMultiTool)

```sh
make all          # build everything
make helm         # build helm
make gearmulator  # build gearmulator
make clean        # clear /out
```

Output goes to `out/<synth>/`.
