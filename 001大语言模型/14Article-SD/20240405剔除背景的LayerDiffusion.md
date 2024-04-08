## 20240405剔除背景的LayerDiffusion

最早是在 Twitter 上看到的信息：

[(6) X 上的 fofr：“Generate transparent images directly with LayerDiffusion. No more background removal tools – it builds transparency into the diffusion process. It's only on A1111 at the moment: https://t.co/qAWpSVUmvP I need this in ComfyUI! This is the proper way. https://t.co/rctbiW743L” / X](https://twitter.com/fofrAI/status/1764958890246934554?s=20)

开始只有 A1111 上可以用。

[layerdiffusion/sd-forge-layerdiffuse: [WIP] Layer Diffusion for WebUI (via Forge)](https://github.com/layerdiffusion/sd-forge-layerdiffuse)

目前该插件应用也迁移至了 ComfyUI。

[huchenlei/ComfyUI-layerdiffuse: Layer Diffuse custom nodes](https://github.com/huchenlei/ComfyUI-layerdiffuse)

看了仓库的（layerdiffusion/sd-forge-layerdiffuse）的说明，目前这个插件只是在文生图时提供额外的一个选项，生成一张没有背景底图的图片。图直接去除底图目前还在开发中。