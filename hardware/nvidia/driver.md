# NVIDIA Driver

To check the driver used:

```
> inxi -Gx
Graphics:
  Device-1: NVIDIA GA107 [GeForce RTX 3050 6GB] vendor: Gigabyte driver: N/A
    arch: Ampere bus-ID: 01:00.0
  Display: x11 server: X.Org v: 21.1.11 with: Xwayland v: 23.2.6 driver: X:
    loaded: modesetting,nouveau unloaded: fbdev,intel,vesa dri: swrast gpu: N/A
    resolution: 1920x1080~60Hz
  API: EGL v: 1.5 drivers: swrast platforms: active: x11,surfaceless,device
    inactive: gbm,wayland
  API: OpenGL v: 4.5 vendor: mesa v: 24.2.8-1ubuntu1~24.04.1 glx-v: 1.4
    direct-render: yes renderer: llvmpipe (LLVM 19.1.1 256 bits)
```

The above shows `nouveau` is used.
