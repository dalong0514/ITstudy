## 20240302SD-XL-Model

[Stable Diffusion XL 1.0 model - Stable Diffusion Art](https://stable-diffusion-art.com/sdxl-model/)

Stable Diffusion XL 1.0 model

159,600 views

Updated November 17, 2023

By Andrew

Stable Diffusion XL (SDXL) is the latest AI image model that can generate realistic people, legible text, and diverse art styles with excellent image composition. It is a larger and better version of the celebrated Stable Diffusion v1.5 model, and hence the name SDXL.

As described in the article "SDXL: Improving Latent Diffusion Models for High-Resolution Image Synthesis" by Podell and coworkers, the Stable Diffusion XL is in every way better than the v1.5 model.

Stable Diffusion XL（SDXL）是一款前沿的 AI 图像生成模型，它以其能力生成栩栩如生的人像、清晰的文字和丰富多变的艺术风格而闻名，图像布局也处理得非常出色。SDXL 是基于备受赞誉的 Stable Diffusion v1.5 模型的升级版，因此命名为 SDXL，代表了更大规模和更高质量的进步。

根据 Podell 及其团队在《SDXL：提升潜在扩散模型以实现高分辨率图像合成》一文中的描述，Stable Diffusion XL 模型在每一个方面都超越了 v1.5 版本。这篇文章深入探讨了如何通过改进潜在扩散模型来增强高分辨率图像的合成质量，明确指出 SDXL 模型在技术和应用层面上的显著优势。

[[2307.01952] SDXL: Improving Latent Diffusion Models for High-Resolution Image Synthesis](https://arxiv.org/abs/2307.01952)

2『已存入 Zotero「2024001SDXL: Improving Latent Diffusion Models for High-Resolution Image Synthesis」（2024-03-02）』

The improvements are:

Higher quality images

Follows the prompt more closely

More fine details

Larger image size

Ability to generate legible text

Ability to produce darker images

This post will go through:

What the SDXL model is.

My test result of comparing images generated with the v1 and SDXL models.

Running SDXL 1.0 on AUTOMATIC1111 Stable Diffusion WebUI.

Update:

Sept 6, 2023: AUTOMATIC1111 WebUI supports refiner pipeline starting v1.6.0. Updated refiner workflow section.

### 01. What is the Stable Diffusion XL model?

The Stable Diffusion XL (SDXL) model is the official upgrade to the v1.5 model. The model is released as open-source software.

It is a much larger model. In the AI world, we can expect it to be better. The total number of parameters of the SDXL model is 6.6 billion, compared with 0.98 billion for the v1.5 model.

Differences between SDXL and v1.5 models

SDXL model pipeline

The SDXL model consists of two models – The base model and the refiner model. (figure from the research article)

The SDXL model is, in practice, two models. You run the base model, followed by the refiner model. The base model sets the global composition. The refiner model adds finer details. (You can optionally run the base model alone.)

The language model (the module that understands your prompts) is a combination of the largest OpenClip model (ViT-G/14) and OpenAI's proprietary CLIP ViT-L. This is a smart choice because Stable Diffusion v2 uses OpenClip alone and is hard to prompt. Bringing back OpenAI's CLIP makes prompting easier. The prompts that work on v1.5 will have a good chance to work on SDXL.

The SDXL model has a new image size conditioning that aims to use training images smaller than 256×256. This significantly increases the training data by not discarding 39% of the images.

The U-Net, the most crucial part of the diffusion model, is now 3 times larger. Together with the larger language model, the SDXL model generates high-quality images matching the prompt closely.

The default image size of SDXL is 1024×1024. This is 4 times larger than v1.5 model's 512×512.

Stable Diffusion XL（SDXL）模型是对 v1.5 版本的官方升级版，它已作为开源软件发布，为广大研究者和开发者提供了更广阔的创新空间。

SDXL 不仅模型规模更大，而且在 AI 领域中，我们期待它展现出更卓越的性能。与 v1.5 模型的 9.8 亿参数相比，SDXL 模型拥有高达 66 亿的参数总数。

SDXL 与 v1.5 模型的关键差异

SDXL 模型采用了双模型策略 —— 基础模型与细化模型，通过这种创新的双阶段处理，首先由基础模型确定整体构图，随后细化模型进一步丰富图像细节，使得生成的图像更加精细和真实。用户也可以选择仅运行基础模型来快速生成图像。

语言理解模块结合了最大的 OpenClip 模型（ViT-G/14）和 OpenAI 的专有 CLIP 模型（ViT-L），这一策略的采用显著提升了模型对提示的响应能力，使得在 SDXL 上使用 v1.5 时有效的提示同样能够产生优质结果。

SDXL 还引入了一项新的图像尺寸调整技术，通过利用小于 256×256 尺寸的图像进行训练，大幅增加了可用的训练数据量，这一策略有效避免了大量图像的浪费。

此外，作为扩散模型中最核心的部件，U-Net 的规模现已扩大 3 倍，配合更为强大的语言模型，SDXL 能够生成与输入提示高度匹配的高质量图像。

SDXL 模型的默认生成图像尺寸为 1024×1024，是 v1.5 模型的四倍，这意味着它能够提供更为细腻和丰富的图像细节，极大地提升了视觉体验。

### 02. Sample images from SDXL

Users overwhelmingly prefer the SDXL model over the 1.5 model (figure from the research article)

『

目前实际的模型效果（2024-03-02）：

SDXL 1.0(base and refiner) > SDXL 0.9(base and refiner) > SDXL 1.0(base) > SDXL 0.9(base) > SD1.5 > SD2.1

』

According to Stability AI's own study, most users prefer the images from the SDXL model over the v1.5 base model. You will find a series of images generated with the same prompts from the v1.5 and SDXL models. You can decide for yourself.

#### Realistic images

I tested the SDXL model, so you don't have to.

Let's first compare realistic images generated using the prompt in the realistic people tutorial.

Prompt:

photo of young Caucasian woman, highlight hair, sitting outside restaurant, wearing dress, rim lighting, studio lighting, looking at the camera, dslr, ultra quality, sharp focus, tack sharp, dof, film grain, Fujifilm XT3, crystal clear, 8K UHD, highly detailed glossy eyes, high detailed skin, skin pores

Negative prompt:

disfigured, ugly, bad, immature, cartoon, anime, 3d, painting, b&w

All parameters except image sizes are kept the same for comparison. The size for the v1 models is 512×512. The size for the SDXL model is 1024×1024.

Here's the SD 1.5 images.

Here are the base and the base + refiner models.

Some observations:

The SDXL model produces higher quality images.

The refiner model improves rendering details.

Using the base v1.5 model does not do justice to the v1 models. Most users use fine-tuned v1.5 models to generate realistic people. So I include the result using URPM, an excellent realistic model, below.

URPM (fine-tuned v1.5)

You can see the SDXL model still wins in fine detail. It is capable of generating because of the larger VAE.

Below is another set of comparison images using a different seed value.

SD v1.5.

SDXL base

SDXL base + refiner

URPM

The SDXL base model produced a usable image in this set, although the face looks a bit too smooth for a realistic image. The refiner adds nice realistic details to the face.

Note that the SDXL model can generate darker images, which the v1.5 model is not very good at.

#### Legible text

The ability to generate correct text stood out as a ground-breaking capability when I tested the SDXL Beta Model. SDXL should be at least as good.

Prompt:

A fast food restaurant on the moon with name "Moon Burger"

Negative prompt:

disfigured, ugly, bad, immature, cartoon, anime, 3d, painting, b&w

Here are the images from the SDXL base and the SDXL base with refiner.

SDXL base.

SDXL base + refiner

On the other hand, the v1.5 base model fails miserably. Not only did it fail to produce legible text, but it also did not generate a correct image.

v1.5 model.

#### Anime Style

Let's compare the images with the Anime style.

anime, photorealistic, 1girl, collarbone, wavy hair, looking at viewer, upper body, necklace, floral print, ponytail, freckles, red hair, sunlight

disfigured, ugly, bad, immature, photo, amateur, overexposed, underexposed

Here are images from SDXL models with and without refiners.

SDXL base.

SDXL base + refiner.

Here are images from v1.5 and the Anything v4.5 model (fine-tuned v1.5).

SD v1.5.

Anything v4.5.

The SDXL base model produces decant anime images. The images are fantastic for a base model. The refiner adds good details but seems to add some repeating artifacts. Getting to a particular style likely needs custom fine-tuned models like the v1.

#### Scenes

Finally, some sample images of a city with this simple prompt.

Painting of a beautiful city by Brad Rigney.

SDXL Base.

SDXL base + refiner.

This is from v1.5 for comparison.

SD v1.5.

### 03. Download and install SDXL 1.0 models

You can find the SDXL base, refiner and VAE models in the following repository.

SDXL 1.0 base model page

SDXL 1.0 refiner model page

SDXL VAE page

Here are the direct download links of the safetensor model files. You typically don't need to download the VAE file unless you plan to try out different ones.

Download SDXL 1.0 base model

Download SDXL 1.0 refiner model

Download SDXL VAE file

To install the models in AUTOMATIC1111, put the base and the refiner models in the folder stable-diffusion-webui > models > Stable-diffusion.

### 04. Tips on using SDXL 1.0 model

A Stability AI's staff has shared some tips on using the SDXL 1.0 model. Here's the summary.

#### Image size

The native size is 1024×1024. SDXL supports different aspect ratios but the quality is sensitive to size. Here are the image sizes used in DreamStudio, Stability AI's official image generator

1:1 – 1024 x 1024

5:4 – 1152 x 896

3:2 – 1216 x 832

16:9 – 1344 x 768

21:9 – 1536 x 640

Use the Aspect Ratio Selector extension to conveniently switch to these image sizes. Add the following lines to resolutions.txt in the extension's folder (stable-diffusion-webui\extensions\sd-webui-ar).

XL1:1, 1024, 1024

XL5:4, 1152, 896

XL3:2, 1216, 832

XL16:9, 1344, 768

XL21:9, 1536, 640

Aspect Ratio selector presets for SDXL.

2『按上面的步骤，这个插件没加载进去，后续待研究。（2024-03-02）』

#### Negative prompt

Negative prompts are not as necessary in the 1.5 and 2.0 models. Many common negative terms are useless, e.g. Extra fingers.

#### Keyword weight

You don't need to use a high keyword weight like the v1 models. 1.5 is very high for the SDXL model. You may need to reduce the weights when you reuse the prompt from v1 models. Lowering a weight works better than increasing a weight.

#### Safetensor

Always use the safetensor version, not the checkpoint version. It is safer and won't execute codes on your machine.

#### Refiner strength

Use a low refiner strength for the best outcome.

#### Refiner

Use a noisy image to get the best out of the refiner.

关键字权重

在使用 SDXL 模型时，不必像早期的 v1 模型那样设置很高的关键字权重。对于 SDXL 模型，1.5 的权重已经算是很高的了。如果你在从 v1 模型迁移时沿用了原来的设置，可能需要考虑降低权重，因为减少权重往往比增加权重带来更好的效果。

安全张量版

无论何时，都应该选择安全张量（safetensor）版本，而不是检查点（checkpoint）版本。安全张量版更加安全，不会在你的计算机上执行任何代码，这对保护你的系统安全至关重要。

精炼强度设置

为了达到最佳的效果，建议设置较低的精炼强度。这样可以在调整模型输出时，保持更高的灵活性和控制度。

使用精炼器的技巧

当你使用精炼器时，试着用一张含有噪声的图片。这种方式可以让精炼器发挥出最好的效果，帮助你获得更优质的模型输出结果。

### 05. Run SDXL model on AUTOMATIC1111

AUTOMATIC1111 Web-UI now supports the SDXL models natively. You no longer need the SDXL demo extension to run the SDXL model.

The update that supports SDXL was released on July 24, 2023. You may need to update your AUTOMATIC1111 to use the SDXL models.

You can use AUTOMATIC1111 on Google Colab, Windows, or Mac.

Download the Quick Start Guide if you are new to Stable Diffusion.

Installing SDXL 1.0 models on Google Colab

Installing the SDXL model in the Colab Notebook in the Quick Start Guide is easy. All you need to do is to select the SDXL_1 model before starting the notebook.

Installing SDXL 1.0 models on Windows or Mac

Download the SDXL base and refiner models and put them in the models/Stable-diffusion folder as usual. See the model install guide if you are new to this.

Download SDXL 1.0 base model

Download SDXL 1.0 refiner model

After clicking the refresh icon next to the Stable Diffusion Checkpoint dropdown menu, you should see the two SDXL models showing up in the dropdown menu.

Using SDXL base model in text-to-image

Using the SDXL base model on the txt2img page is no different from using any other model. The basic steps are:

Select the SDXL 1.0 base model in the Stable Diffusion Checkpoint dropdown menu

Enter a prompt and, optionally, a negative prompt.

Set image size to 1024×1024, or something close to 1024 for a different aspect ratio. (See the tips section above.)

IMPORTANT: Make sure you didn't select a VAE of a v1 model. Go to Settings > Stable Diffusion. Set SD VAE to None or Automatic.

TIPS: In Settings > User Interface > QuickSetting: Add sd_vae to add a dropdown menu for selecting VAEs next to the checkpoint dropbox.

Prompt:

1girl ,solo,high contrast, hands on the pocket, (black and white dress, looking at viewer, white and light blue theme, white and light blue background, white hair, blue eyes, full body, black footwear the light blue water on sky and white cloud and day from above, Ink painting

Negative prompt:

sketch, ugly, huge eyes, text, logo, monochrome, bad art

Size: 896 x 1152

20 sampling steps

#### Using the base + refiner models

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

#### Using preset styles for SDXL

DreamStudio, the official Stable Diffusion generator, has a list of preset styles available. They are actually implemented by adding keywords to the prompt and negative prompt. You can install the StyleSelectorXL extension to add the same list of presets styles to AUTOMATIC1111.

DreamStudio，作为官方推出的 Stable Diffusion 图像生成工具，提供了一系列可供选择的预设风格。这些风格实际上是通过在生成命令的正面提示词和反面提示词中加入特定的关键字来实现的。为了在另一个流行的图像生成平台 AUTOMATIC1111 上使用这些同样的预设风格，用户可以安装一个名为 StyleSelectorXL 的扩展程序。

Installing StyleSelectorXL extension

To install the extension, navigate to the Extensions page in AUTOMATIC1111. Select the Install from URL tab. Put the following in the URL for extension's git repository.

https://github.com/ahgsql/StyleSelectorXL

Press Install. After you see the confirmation of successful installation, restart the AUTOMATIC1111 Web-UI completely.

Using SDXL style selector

You should see a new section appear on the txt2img page.

Write the prompt and the negative prompt as usual. Make sure the SDXL Styles option is enabled. Select a style other than base to apply a style.

Isometric

Photographic

Anime

Comic Book

SDXL preset styles.

### 06. Some notes about SDXL

Make sure to use an image size of 1024 x 1024 or similar. 512×512 doesn't work well with SDXL.

You normally don't use the refiner model with a fine-tuned SDXL model. The style may not be compatible.

### 07. Frequently Asked Questions

Can I use SDXL on Mac?

Yes, you will need Mac with Apple Silicon M1 or M2. Make sure your AUTOMATIC1111 is up-to-date. See the installation tutorial.

[How to install and run Stable Diffusion on Apple Silicon M1/M2 Macs - Stable Diffusion Art](https://stable-diffusion-art.com/install-mac/)

Can I use ControlNet with SDXL models?

ControlNet currently only works with v1 models. SDXL is not supported.

But it appears to be in the work.

[ControlNet v1.1: A complete guide - Stable Diffusion Art](https://stable-diffusion-art.com/controlnet/)

[ControlNet + SDXL 1.0：r/StableDiffusion --- ControlNet + SDXL 1.0 : r/StableDiffusion](https://www.reddit.com/r/StableDiffusion/comments/158n1td/controlnet_sdxl_10/)

What image sizes should I use with SDXL models?

Here are the recommended image sizes for different aspect ratios.

21:9 – 1536 x 640

16:9 – 1344 x 768

3:2 – 1216 x 832

5:4 – 1152 x 896

1:1 – 1024 x 1024

Stable Diffusion XL Resources

SDXL prompts: Get a quick start with these prompts.

[15 Stable Diffusion XL prompts + tips - Stable Diffusion Art](https://stable-diffusion-art.com/sdxl-prompts/)

Styles for SDXL: Over a hundred styles were demonstrated.

[106 styles for Stable Diffusion XL model - Stable Diffusion Art](https://stable-diffusion-art.com/sdxl-styles/)

SDXL Artist browser: Investigate artistic styles in Stable Diffusion XL.

[SD Artists Browser - a Hugging Face Space by mattthew](https://huggingface.co/spaces/mattthew/SDXL-artists-browser)

### 08. Interesting reads

Stability AI launches SDXL 0.9: A Leap Forward in AI Image Generation – Official press release of SDXL 0.9.

ANNOUNCING SDXL 1.0 — Stability AI – Official press release of SDXL 1.0

SDXL: Improving Latent Diffusion Models for High-Resolution Image Synthesis – Research article detailing the SDXL model.

Diffusers · vladmandic/automatic Wiki – Using Diffusers mode in SD.Next

[Diffusers · vladmandic/automatic Wiki](https://github.com/vladmandic/automatic/wiki/Diffusers)

[[2307.01952] SDXL: Improving Latent Diffusion Models for High-Resolution Image Synthesis](https://arxiv.org/abs/2307.01952)

[Announcing SDXL 1.0 — Stability AI](https://stability.ai/news/stable-diffusion-sdxl-1-announcement)

[Stability AI launches SDXL 0.9: A Leap Forward in AI Image Generation — Stability AI](https://stability.ai/news/sdxl-09-stable-diffusion)

[Stability AI](https://stability.ai/)