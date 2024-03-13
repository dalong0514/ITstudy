## 20240311What-are-LoRA-models-and-how-to-use

20240311What-are-LoRA-models-and-how-to-use

[What are LoRA models and how to use them in AUTOMATIC1111 - Stable Diffusion Art](https://stable-diffusion-art.com/lora/)

Updated November 22, 2023

By Andrew

LoRA models are small Stable Diffusion models that apply tiny changes to standard checkpoint models. They are usually 10 to 100 times smaller than checkpoint models. That makes them very attractive to people who have an extensive collection of models.

This is a tutorial for beginners who haven't used LoRA models before. You will learn what LoRA models are, where to find them, and how to use them in AUTOMATIC1111 GUI. Then you will find a few demos of LoRA models at the end.

### 01. What are LoRA models?

LoRA (Low-Rank Adaptation) is a training technique for fine-tuning Stable Diffusion models.

But we already have training techniques such as Dreambooth and textual inversion. What's the big deal about LoRA? LoRA offers a good trade-off between file size and training power. Dreambooth is powerful but results in large model files (2-7 GBs). Textual inversions are tiny (about 100 KBs), but you can't do as much.

LoRA sits in between. Its file size is much more manageable (2 – 200 MBs), and the training power is decent.

Stable Diffusion users who like to try different models can tell you how quickly their local storage fills up. Because of the large size, It is hard to maintain a collection with a personal computer. LoRA is an excellent solution to the storage problem.

Like textual inversion, you cannot use a LoRA model alone. It must be used with a model checkpoint file. LoRA modifies styles by applying small changes to the accompanying model file.

LoRA is a great way to customize AI art models without filling up local storage.

### 02. How does LoRA work?

LoRA applies small changes to the most critical part of Stable Diffusion models: The cross-attention layers. It is the part of the model where the image and the prompt meet. Researchers found it sufficient to fine-tune this part of the model to achieve good training. The cross-attention layers are the yellow parts in the Stable Diffusion model architecture below.

LORA fine-tunes the cross-attention layers (the QKV parts of the U-Net noise predictor). (Figure from Stable Diffusion paper.)

The weights of a cross-attention layer are arranged in matrices. Matrices are just a bunch of numbers arranged in columns and rows, like on an Excel spreadsheet. A LoRA model fine-tunes a model by adding its weights to these matrices.

How can LoRA model files be smaller if they need to store the same number of weights? The trick of LoRA is breaking a matrix into two smaller (low-rank) matrices. It can store a lot fewer numbers by doing this. Let's illustrate this with the following example.

Let's say the model has a matrix with 1,000 rows and 2,000 columns. That's 2,000,000 numbers (1,000 x 2,000) to store in the model file. LoRA breaks down the matrix into a 1,000-by-2 matrix and a 2-by-2,000 matrix. That's only 6,000 numbers (1,000 x 2 + 2 x 2,000), 333 times less. That's why LoRA files are a lot smaller.

LoRA decomposes a big matrix into two small, low-rank matrices.

In this example, the rank of the matrices is 2. It is much lower than the original dimensions, so they are called low-rank matrices. The rank can be as low as 1.

But are there any harms in pulling a trick like that? Researchers found doing that in cross-attention layers did not affect the power of fine-tuning much. So we are good.

### 03. Where to find LoRA models?

Civitai

where to find lora models

LoRA models on Civitai.

The go-to place to find Lora is Civitai. The site hosts a large collection of LoRA models. Apply the LORA filter to see only LoRA models. You may find that they all tend to be similar: female portraits, anime, realistic illustration styles, etc.

(Be aware that there's a lot of NSFW stuff on Civitai. Make sure to put on NSFW filter if you don't want to see something you cannot unsee…)

Hugging Face

LoRA models on Hugging Face.

Hugging Face is another good source of LoRA libraries. You will find more varieties of LoRA models. But there are not as many LoRA models there. Their collection is a lot smaller.

Search LoRA models in Hugging Face

LoRA Library in Hugging Face

### 04. How to use LoRA?

In this section, you will find instructions to use LoRA model in AUTOMATIC1111 Stable Diffusion GUI. You can use this GUI on Windows, Mac, or Google Colab.

AUTOMATIC1111 supports LoRA natively. You don't need to install any extensions.

Step 1: Install the LoRA model

To install LoRA models in AUTOMATIC1111 webui, put the model files in the following folder.

stable-diffusion-webui/models/Lora

Step 2: Use the LoRA in the prompt

To add a LoRA with weight in AUTOMATIC1111 Stable Diffusion WebUI, use the following syntax in the prompt or the negative prompt:

<lora: name: weight>

name is the name of the LoRA model. It can be different from the filename.

weight is the emphasis applied to the LoRA model. It is similar to a keyword weight. The default is 1. Setting it to 0 disables the model.

How can you be sure the name is correct? Instead of typing this phrase, click the LoRA tab.

You should see a list of LoRA models installed. Click on the one you want to use.

The LoRA phrase will be inserted in the prompt.

That's it!

Notes on using LoRA

You may adjust the multiplier to crank up or tune down the effect. Setting the multiplier 0 disables the LoRA model. You can adjust the style effect between 0 and 1.

Some LoRA models are trained with Dreambooth. You will need to include a trigger keyword to use the LoRA model. You can find the trigger keyword on the model's page.

Similar to embeddings, you can use multiple LoRA models at the same time. You can also use them with embeddings.

In AUTOMATIC1111, the LoRA phrase is not part of the prompt. It will be removed after the LoRA model is applied. That means you cannot use prompt syntax like [keyword1:keyword2: 0.8] with them.

### 05. Useful LoRA models

Detail Tweaker

detail tweaker lora

Detail Tweaker LoRA lets increase or reduce details (Image: CyberAIchemist)

Who doesn't want more details in AI images? Detail Tweaker lets you increase or reduce fine details in an image. Now, you can dial in the amount of details you want.

Use a positive LoRA weight to increase the detail and a negative weight to decrease the detail.

Epi Noise Offset

Epi Noise OffSet LoRA generates darker images. (Image: epinikion)

It is well-known that many Stable Diffusion v1.5 models cannot generate dark images. The Epi Noise Offset LoRA lets you generate dark images with any v1.5 models. Use keywords dark studio, rim lighting, two tone lighting, dimly lit, low key, etc to induce the darkening effect.

Better Portrait lighting

Better lighting LoRA (Image: Phaitographer)

Better Portrait Lighting LoRA adds good lighting to images. It's worth a shot if you are working on portrait-style photorealistic images.

### 06. Interesting LoRA models

Here's my biased selection of interesting LoRA models.

Shukezouma

Shukezouma LoRA model brings out a stylish Chinese ink painting theme. Shukezouma means the negative space (commonly seen in Chinese paintings) of the painting is so ample that a horse can pass through it.

Shukezouma LoRA Model Page

Use this LoRA with the Chinese-style model Guo Feng.

Trigger keyword: shukezouma

Prompt:

(shukezouma:0.5) ,<lora:Moxin_Shukezouma:1> , chinese painting, half body, female, perfect symmetric face, detailed chinese dress, mountains, flowers, 1girl, tiger

Negative Prompt:

disfigured, ugly, bad, immature

Shukezouma LoRA model.

Akemi Takada (1980s) Style

Akemi Takada is a Japanese manga illustrator. This is for you if you like Japanese anime in the 1980s and 1990s.

LoRA model page

Use with AbyssOrangeMix2 model.

Prompt:

takada akemi, Tifa lockhart as magician, Final Fantasy VII, 1girl, small breast, beautiful eyes, brown hair, smiling, red eyes, highres, diamond earring, long hair, side parted hair, hair behind ear, upper body, stylish dress, indoors, bar 1980s (style), painting (medium), retro artstyle, watercolor (medium) <lora:akemiTakada1980sStyle_1:0.6>

Negative prompt:

(worst quality, low quality:1.4), (painting by bad-artist-anime:0.9), (painting by bad-artist:0.9), watermark, text, error, blurry, jpeg artifacts, cropped, worst quality, low quality, normal quality, jpeg artifacts, signature, watermark, username, artist name, bad anatomy

Cyberpunk 2077 Tarot card

This LoRA model generates cyborgs and cities with a futuristic cyberpunk style.

LoRA model page

Used with Anything v5

Prompt:

cyberpunk, tarot card, close up, portrait, bionic body, cat, young man, perfect human symmetric face, leather metallic jacket, circuit, city street in background, natural lighting, masterpiece <lora:cyberpunk2077Tarot_tarotCard512x1024:0.6>

Negative prompt:

(worst quality, low quality:1.4), (painting by bad-artist-anime:0.9), (painting by bad-artist:0.9), watermark, text, error, blurry, jpeg artifacts, cropped, worst quality, low quality, normal quality, jpeg artifacts, signature, watermark, username, artist name, bad anatomy, big breast

### 07. Summary

LoRA models are small modifiers of checkpoint models. You can easily use them in AUTOMATIC1111 by including a phrase in the prompt.

That's it for today! I will tell you how to train LoRA models in a future article.

Below are some additional readings for curious minds.

Using LoRA for Efficient Stable Diffusion Fine-Tuning (Hugging Face blog). A good overview of how LoRA is applied to Stable Diffusion.

LoRA: Low-Rank Adaptation of Large Language Models (2021). The research article first proposed the LoRA technique. (for language models)

Github: Low-rank Adaptation for Fast Text-to-Image Diffusion Fine-tuning. This is the initial work applying LoRA to Stable Diffusion. You will find an excellent technical description of LoRA.

[Using LoRA for Efficient Stable Diffusion Fine-Tuning](https://huggingface.co/blog/lora)

[[2106.09685] LoRA: Low-Rank Adaptation of Large Language Models](https://arxiv.org/abs/2106.09685)

[cloneofsimo/lora: Using Low-rank adaptation to quickly fine-tune diffusion models.](https://github.com/cloneofsimo/lora)