### 跑模型


1、通过 brew 安装相关的包。

brew install cmake protobuf rust python@3.10 git wget

2、启动。

./webui.sh --use-cpu USE_CPU

./webui.sh --no-half

./webui.sh


stable-diffusion-webui-forge:

Launching Web UI with arguments: --skip-torch-cuda-test --upcast-sampling --no-half-vae --use-cpu interrogate

stable-diffusion-webui:

--no-half --skip-torch-cuda-test --upcast-sampling --no-half-vae --use-cpu interrogate

[Civitai: The Home of Open-Source Generative AI](https://civitai.com/)


usage: launch.py [-h] [--disable-header-check [ORIGIN]] [--web-upload-size WEB_UPLOAD_SIZE] [--external-working-path PATH [PATH ...]]
                 [--output-path OUTPUT_PATH] [--temp-path TEMP_PATH] [--cache-path CACHE_PATH] [--in-browser] [--disable-in-browser]
                 [--gpu-device-id DEVICE_ID] [--disable-attention-upcast] [--all-in-fp32 | --all-in-fp16]
                 [--unet-in-bf16 | --unet-in-fp16 | --unet-in-fp8-e4m3fn | --unet-in-fp8-e5m2] [--vae-in-fp16 | --vae-in-fp32 | --vae-in-bf16]
                 [--vae-in-cpu] [--clip-in-fp8-e4m3fn | --clip-in-fp8-e5m2 | --clip-in-fp16 | --clip-in-fp32] [--directml [DIRECTML_DEVICE]]
                 [--disable-ipex-hijack] [--preview-option [none,auto,fast,taesd]] [--attention-split | --attention-quad | --attention-pytorch]
                 [--disable-xformers]
                 [--always-gpu | --always-high-vram | --always-normal-vram | --always-low-vram | --always-no-vram | --always-cpu]
                 [--always-offload-from-vram] [--pytorch-deterministic] [--disable-server-log] [--debug-mode] [--is-windows-embedded-python]
                 [--disable-server-info] [--multi-user] [--cuda-malloc] [--cuda-stream] [--pin-shared-memory] [--update-all-extensions]
                 [--skip-python-version-check] [--skip-torch-cuda-test] [--reinstall-xformers] [--reinstall-torch] [--update-check]
                 [--test-server] [--log-startup] [--skip-prepare-environment] [--skip-install] [--dump-sysinfo] [--loglevel LOGLEVEL]
                 [--do-not-download-clip] [--data-dir DATA_DIR] [--config CONFIG] [--ckpt CKPT] [--ckpt-dir CKPT_DIR] [--vae-dir VAE_DIR]
                 [--gfpgan-dir GFPGAN_DIR] [--gfpgan-model GFPGAN_MODEL] [--no-half] [--no-half-vae] [--no-progressbar-hiding]
                 [--max-batch-count MAX_BATCH_COUNT] [--embeddings-dir EMBEDDINGS_DIR]
                 [--textual-inversion-templates-dir TEXTUAL_INVERSION_TEMPLATES_DIR] [--hypernetwork-dir HYPERNETWORK_DIR]
                 [--localizations-dir LOCALIZATIONS_DIR] [--allow-code] [--medvram] [--medvram-sdxl] [--lowvram] [--lowram]
                 [--always-batch-cond-uncond] [--unload-gfpgan] [--precision {full,autocast}] [--upcast-sampling] [--share] [--ngrok NGROK]
                 [--ngrok-region NGROK_REGION] [--ngrok-options NGROK_OPTIONS] [--enable-insecure-extension-access]
                 [--codeformer-models-path CODEFORMER_MODELS_PATH] [--gfpgan-models-path GFPGAN_MODELS_PATH]
                 [--esrgan-models-path ESRGAN_MODELS_PATH] [--bsrgan-models-path BSRGAN_MODELS_PATH]
                 [--realesrgan-models-path REALESRGAN_MODELS_PATH] [--clip-models-path CLIP_MODELS_PATH] [--xformers] [--force-enable-xformers]
                 [--xformers-flash-attention] [--deepdanbooru] [--opt-split-attention] [--opt-sub-quad-attention]
                 [--sub-quad-q-chunk-size SUB_QUAD_Q_CHUNK_SIZE] [--sub-quad-kv-chunk-size SUB_QUAD_KV_CHUNK_SIZE]
                 [--sub-quad-chunk-threshold SUB_QUAD_CHUNK_THRESHOLD] [--opt-split-attention-invokeai] [--opt-split-attention-v1]
                 [--opt-sdp-attention] [--opt-sdp-no-mem-attention] [--disable-opt-split-attention] [--disable-nan-check]
                 [--use-cpu USE_CPU [USE_CPU ...]] [--use-ipex] [--disable-model-loading-ram-optimization] [--listen] [--port PORT]
                 [--show-negative-prompt] [--ui-config-file UI_CONFIG_FILE] [--hide-ui-dir-config] [--freeze-settings]
                 [--freeze-settings-in-sections FREEZE_SETTINGS_IN_SECTIONS] [--freeze-specific-settings FREEZE_SPECIFIC_SETTINGS]
                 [--ui-settings-file UI_SETTINGS_FILE] [--gradio-debug] [--gradio-auth GRADIO_AUTH] [--gradio-auth-path GRADIO_AUTH_PATH]
                 [--gradio-img2img-tool GRADIO_IMG2IMG_TOOL] [--gradio-inpaint-tool GRADIO_INPAINT_TOOL]
                 [--gradio-allowed-path GRADIO_ALLOWED_PATH] [--opt-channelslast] [--styles-file STYLES_FILE] [--autolaunch] [--theme THEME]
                 [--use-textbox-seed] [--disable-console-progressbars] [--enable-console-prompts] [--vae-path VAE_PATH]
                 [--disable-safe-unpickle] [--api] [--api-auth API_AUTH] [--api-log] [--nowebui] [--ui-debug-mode] [--device-id DEVICE_ID]
                 [--administrator] [--cors-allow-origins CORS_ALLOW_ORIGINS] [--cors-allow-origins-regex CORS_ALLOW_ORIGINS_REGEX]
                 [--tls-keyfile TLS_KEYFILE] [--tls-certfile TLS_CERTFILE] [--disable-tls-verify] [--server-name SERVER_NAME] [--gradio-queue]
                 [--no-gradio-queue] [--skip-version-check] [--no-hashing] [--no-download-sd-model] [--subpath SUBPATH] [--add-stop-route]
                 [--api-server-stop] [--timeout-keep-alive TIMEOUT_KEEP_ALIVE] [--disable-all-extensions] [--disable-extra-extensions]
                 [--skip-load-model-at-start] [--forge-ref-a1111-home FORGE_REF_A1111_HOME] [--controlnet-dir CONTROLNET_DIR]
                 [--controlnet-preprocessor-models-dir CONTROLNET_PREPROCESSOR_MODELS_DIR]

### 下载模型文件

模型文件的路径：

/Users/Daglas/dalong.llm/stable-diffusion-webui/models/Stable-diffusion

/Users/Daglas/dalong.llm/stable-diffusion-webui-forge/models/Stable-diffusion

[lllyasviel/stable-diffusion-webui-forge](https://github.com/lllyasviel/stable-diffusion-webui-forge?tab=readme-ov-file)



[AUTOMATIC1111/stable-diffusion-webui: Stable Diffusion web UI](https://github.com/AUTOMATIC1111/stable-diffusion-webui)

[Installation on Apple Silicon · AUTOMATIC1111/stable-diffusion-webui Wiki](https://github.com/AUTOMATIC1111/stable-diffusion-webui/wiki/Installation-on-Apple-Silicon)

[绘世启动器官网,stable diffusion,sd-webui-启动器,github,mac,windows,秋叶-ai导航](https://feizhuke.com/sites/huishi-qidongqi.html)

[aimwise启动器官网,Stable Diffusion一键安装整合包,sd支持Windows,mac-ai导航](https://feizhuke.com/sites/aimwise-qidongqi.html)

[How to install and run Stable Diffusion on Apple Silicon M1/M2 Macs - Stable Diffusion Art](https://stable-diffusion-art.com/install-mac/)

SDXL 1.0(base and refiner) > SDXL 0.9(base and refiner) > SDXL 1.0(base) > SDXL 0.9(base) > SD1.5 > SD2.1

#### SDXL 1.0(base and refiner)

[Models - Hugging Face](https://huggingface.co/models?pipeline_tag=text-to-image&sort=downloads)

[stabilityai/stable-diffusion-xl-base-1.0 · Hugging Face](https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0)

[stabilityai/stable-diffusion-xl-refiner-1.0 · Hugging Face](https://huggingface.co/stabilityai/stable-diffusion-xl-refiner-1.0)

#### SD1.5

[runwayml/stable-diffusion-v1-5 at main](https://huggingface.co/runwayml/stable-diffusion-v1-5/tree/main)

#### Juggernaut XL

[Juggernaut XL - Version 6 + RunDiffusion | Stable Diffusion Checkpoint | Civitai](https://civitai.com/models/133005?modelVersionId=198530)

#### anima_pencil-XL

[anima\_pencil-XL - v1.0.0 | Stable Diffusion Checkpoint | Civitai](https://civitai.com/models/261336?modelVersionId=295158)


### 问题记录

1、安装时，三方包安装清华源问题。

报错：

stderr: ERROR: Ignored the following versions that require a different python version: 1.6.2 Requires-Python >=3.7,<3.10; 1.6.3 Requires-Python >=3.7,<3.10; 1.7.0 Requires-Python >=3.7,<3.10; 1.7.1 Requires-Python >=3.7,<3.10
ERROR: Could not find a version that satisfies the requirement tb-nightly (from versions: none)
ERROR: No matching distribution found for tb-nightly

解决方案：

[python · Issue #13363 · AUTOMATIC1111/stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui/issues/13363)

之前用的清华源：

pip 参考地址：

[pypi | 镜像站使用帮助 | 清华大学开源软件镜像站 | Tsinghua Open Source Mirror](https://mirrors.tuna.tsinghua.edu.cn/help/pypi/)

brew 参考地址：

[homebrew | 镜像站使用帮助 | 清华大学开源软件镜像站 | Tsinghua Open Source Mirror](https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/)

[homebrew-bottles | 镜像站使用帮助 | 清华大学开源软件镜像站 | Tsinghua Open Source Mirror](https://mirrors.tuna.tsinghua.edu.cn/help/homebrew-bottles/)

先改为阿里源：

pip config set global.index-url https://mirrors.aliyun.com/pypi/simple

2、跑步起来，报错：

NansException: A tensor with all NaNs was produced in Unet. This could be either because there's not enough precision to represent the picture, or because your video card does not support half type. Try setting the "Upcast cross attention layer to float32" option in Settings > Stable Diffusion or using the --no-half commandline argument to fix this. Use --disable-nan-check commandline argument to disable this check.

目前的解决方案：

[[Bug]: NansException: A tensor with all NaNs was produced in Unet. This could be either because there's not enough precision to represent the picture, or because your video card does not support half type. Try setting the "Upcast cross attention layer to float32" option in Settings > Stable Diffusion or using the --no-half commandline argument to fix this. Use --disable-nan-check commandline argument to disable this check. · Issue #12921 · AUTOMATIC1111/stable-diffusion-webui](https://github.com/AUTOMATIC1111/stable-diffusion-webui/issues/12921)

GitHub 上的找到的解决办法，跑的时候额外加个选项：

./webui.sh --no-half

另外一个感觉后续有用的信息：

I confirm this bug too- for SDXL models do any (empty) txt2img before to do img2img fixes it!

This is a workaround. I did this and then the reActor and SDXL base/refiner worked in img2img

[stable duffusion NansException: A tensor with all NaNs was produced in Unet. This could be either because there's not enough pre\_天空才是极限-lskyf博客社区](https://www.lskyf.com/post/258?action=btnFullClick)

这个错误提示是在 Unet 代码中产生了全部由 NaN 组成的张量。这可能有几个原因：

表示图像所需的精度不够：这意味着正在处理的图片可能包含非常小的值，这些值被舍入为零，从而导致 NaN。要解决此问题，可以尝试增加计算中使用的精度。

视频卡不支持半精度类型：半精度是一种表示浮点数的格式，使用的位数比单精度少一半，可以节省内存和计算时间。如果你的视频卡不支持这种格式，可能会导致产生 NaN。要解决此问题，可以尝试设置「将交叉关注层升级为 float32」选项在设置 > 稳定扩散中，或者使用 --no-half 命令行参数来解决这个问题。使用 --disable-nan-check 命令行参数可以禁用此检查。




Legacy Preprocessor init warning: Unable to install insightface automatically. Please try run `pip install insightface` manually.

Installing forge_legacy_preprocessor requirement: handrefinerportable
Installing forge_legacy_preprocessor requirement: depth_anything

Launching Web UI with arguments: --skip-torch-cuda-test --upcast-sampling --no-half-vae --use-cpu interrogate

3、用 LayerDiffusion 跑模型时报错。

stable-diffusion-webui-forge 里用的，不用透明插件可以跑，说明是透明插件造成的。

2024-05-25

/AppleInternal/Library/BuildRoots/91a344b1-f985-11ee-b563-fe8bc7981bff/Library/Caches/com.apple.xbs/Sources/MetalPerformanceShaders/MPSNDArray/Kernels/MPSNDArraySort.mm:287: failed assertion `(null)" Axis = 4. This class only supports axis = 0, 1, 2, 3
'
./webui.sh: line 292: 42309 Abort trap: 6           "${python_cmd}" -u "${LAUNCH_SCRIPT}" "$@"
/Users/Daglas/miniconda3/envs/llama/lib/python3.10/multiprocessing/resource_tracker.py:224: UserWarning: resource_tracker: There appear to be 1 leaked semaphore objects to clean up at shutdown
  warnings.warn('resource_tracker: There appear to be %d '

[[m1 pro] How to fix the problem? · Issue #62 · layerdiffusion/sd-forge-layerdiffuse](https://github.com/layerdiffusion/sd-forge-layerdiffuse/issues/62)

[Mac crash · Issue #1 · huchenlei/ComfyUI-layerdiffuse](https://github.com/huchenlei/ComfyUI-layerdiffuse/issues/1#issuecomment-2070451193)

问题卡住了，还没解决。（2024-05-25）



### 碎片记录

1、v2-1_768-nonema-pruned 和 v2-1_768-ema-pruned 的区别。

[v2-1\_768-ema-pruned vs v2-1\_768-nonema-pruned confusion. · AUTOMATIC1111/stable-diffusion-webui · Discussion #5538](https://github.com/AUTOMATIC1111/stable-diffusion-webui/discussions/5538)

I finally found an authoritative answer to my question (from someone who works with Stability AI). Use v2-1_768-ema-pruned for generation, and v2-1_768-nonema-pruned for fine-tuning. But you can also use the ema checkpoint for fine-tuning!

https://twitter.com/iScienceLuvr/status/1601011140934664193

### 好提示词收集

2024-03-02

[Stable Diffusion XL 1.0 model - Stable Diffusion Art](https://stable-diffusion-art.com/sdxl-model/)

01 Realistic images 类型的

Prompt:

photo of young Caucasian woman, highlight hair, sitting outside restaurant, wearing dress, rim lighting, studio lighting, looking at the camera, dslr, ultra quality, sharp focus, tack sharp, dof, film grain, Fujifilm XT3, crystal clear, 8K UHD, highly detailed glossy eyes, high detailed skin, skin pores

Negative prompt:

02 Legible text 带文字类型的

Prompt:

A fast food restaurant on the moon with name "Moon Burger"

Negative prompt:

disfigured, ugly, bad, immature, cartoon, anime, 3d, painting, b&w

03 Anime Style 动漫类型的

Prompt:

anime, photorealistic, 1girl, collarbone, wavy hair, looking at viewer, upper body, necklace, floral print, ponytail, freckles, red hair, sunlight

Negative prompt:

disfigured, ugly, bad, immature, photo, amateur, overexposed, underexposed

04 Scenes 类

Painting of a beautiful city by Brad Rigney.

2024-03-03

01

Imagine a cat, standing with a solemn expression, holding a sword in its paws, looking ahead with determination as if ready to enter battle. This scene combines a sense of whimsy with the seriousness of the cat's expression and stance. The background is a blurry suggestion of a medieval battlefield, enhancing the contrast between the cat's small form and the grandeur of its spirit. The lighting is dramatic, highlighting the cat's features and the gleam of the sword, casting long shadows that add to the scene's intensity. The cat's fur is detailed, with each whisker and tuft adding to its fierce appearance. The sword is styled to fit the scene, looking both ancient and noble, as if it has seen many battles but is still held with pride and readiness by this small but brave warrior.


### SD WebUI 的常用设置

1、base + refiner 双模型成图时，步数和模型切换点的设置。

30 步 + 切换点 0.6

2024-03-02

use 30 steps and switch at 0.6 for generating images with base + refiner.

[Stable Diffusion XL 1.0 model - Stable Diffusion Art](https://stable-diffusion-art.com/sdxl-model/)

You can now use the refiner model with the base model in the txt2img tab. You need WebUI version 1.6.0 or higher.

To enable the refiner, expand the Refiner section:

Checkpoint: Select the SD XL refiner 1.0 model.

Switch at: This value controls at which step the pipeline switches to the refiner model. E.g., Switching at 0.5 and using 40 steps means using the base in the first 20 steps and the refiner model in the next 20 steps. Switching at 1 uses the base model only.

Click Generate for text-to-image.

What Switch at value should you use? Below are images from switching at from 0.4 to 1.0 with 30 steps.

Prompt:

a woman dancing happily, cinematic photo, 35mm photograph, film, bokeh, professional, 4k, highly detailed

Negative prompt:

drawing, painting, crayon, sketch, graphite, impressionist, noisy, blurry, soft, deformed, ugly

Refiner switch at: 0.4

Refiner switch at: 0.6

Refiner switch at: 0.8

Refiner switch at: 1.0

Switching at 0.8 and 1.0 (not using refiner) are quite similar. 0.6 produces the highest quality image.

How about changing the number of sampling steps?

20 steps, switch at 0.6.

30 steps, switch at 0.6.

40 steps, switch at 0.6.

50 steps, switch at 0.6.

A higher number of steps produces slightly higher-quality images. But the difference are minimal above 30 steps.

To sum up, I would use 30 steps and switch at 0.6 for generating images with base + refiner.

### 插件汇总

安装插件的步骤：

1、安装插件。

Extensions => Install from URL

那里面把插件的 GitHub 仓库地址复制进去，用 https 开头的，git 的没试过。点击安装。

git 的也可以，一样的。（2024-05-25）

2、重启 UI。

Extensions => installed => Apply and restart UI

卸载插件。目前的办法是手动删除插件相关文件。

比如删除插件 sd-forge-layerdiffuse：

/Users/Daglas/dalong.llm/stable-diffusion-webui/extensions/sd-forge-layerdiffuse

#### StyleSelectorXL

内置成图风格的插件

[ahgsql/StyleSelectorXL: This repository contains a Automatic1111 Extension allows users to select and apply different styles to their inputs using SDXL 1.0.](https://github.com/ahgsql/StyleSelectorXL)

#### clip-interrogator-ext

图片中提取 Prompt 的插件

[pharmapsychotic/clip-interrogator-ext: Stable Diffusion WebUI extension for CLIP Interrogator](https://github.com/pharmapsychotic/clip-interrogator-ext)

#### 剔除背景的 LayerDiffusion

[(6) X 上的 fofr：“Generate transparent images directly with LayerDiffusion. No more background removal tools – it builds transparency into the diffusion process. It's only on A1111 at the moment: https://t.co/qAWpSVUmvP I need this in ComfyUI! This is the proper way. https://t.co/rctbiW743L” / X](https://twitter.com/fofrAI/status/1764958890246934554?s=20)

[layerdiffusion/sd-forge-layerdiffuse: [WIP] Layer Diffusion for WebUI (via Forge)](https://github.com/layerdiffusion/sd-forge-layerdiffuse)

遇到的问题：无法使用这个插件。

2024-05-25

今天在 YouTube 上看到一个教学视频才知道原因，这个插件只给 stable-diffusion-webui-forge 用的，这个仓库是 control-net 那个作者在 webui 的基础上分叉出来的优化版。

[lllyasviel/stable-diffusion-webui-forge](https://github.com/lllyasviel/stable-diffusion-webui-forge?tab=readme-ov-file)




### 图片中提取 Prompt

[How to get prompts from images for Stable Diffusion - Stable Diffusion Art](https://stable-diffusion-art.com/prompts-from-images/)

1、SD WebUI 自带的 PNG Info。

2、使用 CLIP interrogator 从图片中提取。

Guess prompts from images with CLIP interrogator

一个是 SD WebUI 原生的 CLIP interrogator。

1『

自己的 UI 里按钮的位置（界面）跟本文的不一样，我的应该是更新的版本。点击后，第一次用后台要下载模型。除了 CLIP 模型还多了 DeepBooru 可选。（2024-03-03）

Interrogate CLIP-use CUP neural network to create a text describing the image, and put it into the prompt field

Interronate DeepBooru-use DeepBooru neural network to create a text describing the image, and put it into the prompt field

下面模型的位置：

/Users/Daglas/dalong.llm/stable-diffusion-webui/models/BLIP

/Users/Daglas/dalong.llm/stable-diffusion-webui/models/deepbooru

deepbooru 在 mac 上不行，报错：

loc("mps_pad"("(mpsFileLoc): /AppleInternal/Library/BuildRoots/0032d1ee-80fd-11ee-8227-6aecfccc70fe/Library/Caches/com.apple.xbs/Sources/MetalPerformanceShadersGraph/mpsgraph/MetalPerformanceShadersGraph/Core/Files/MPSGraphUtilities.mm":859:0)): error: 'anec.padding' op Invalid configuration for the following reasons: Invalid background padding value. It should be in [-65504.00, 65504.00] for fp16 format

』

另一个是通过插件 clip-interrogator-ext 调用不同模型的 CLIP interrogator。

推荐：

适用于 SD v1.5 的：ViT-L-14-336/openai

适用于 SDXL 的：ViT-g-14/laion2b_s34b_b88k

感觉 ViT-L-14-336/openai 获得提示词效果一般。（2024-03-03）

You should always try the PNG info method (Method 1) first to get prompts from images because, if you are lucky, it gives you the complete information to recreate the image. This includes the prompt, model, sampling method, sampling steps, etc.

You can experiment with BLIP and the CLIP models for Stable Diffusion v1.5 and XL models. ViT-g-14/laion2b_s34b_b88k could work quite well with an v1.5 model, not just the SDXL.

Don't hesitate to revise the prompt. As the examples above show, the prompt can be incorrect or missing some objects. Edit the prompt accordingly to describe the image correctly.

Choosing an appropriate checkpoint model is important. The prompt won't necessarily include the correct style. For example, choose a realistic model if you want to generate realistic people.

Finally, the nuclear option is to use an image prompt. The SD v1.5 Plus model can reproduce an image faithfully with an appropriate prompt.