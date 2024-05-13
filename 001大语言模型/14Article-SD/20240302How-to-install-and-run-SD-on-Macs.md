## 20240302How-to-install-and-run-SD-on-Macs

[How to install and run Stable Diffusion on Apple Silicon M1/M2 Macs - Stable Diffusion Art](https://stable-diffusion-art.com/install-mac/)

[How to run Stable Diffusion on Google Colab (AUTOMATIC1111) - Stable Diffusion Art](https://stable-diffusion-art.com/automatic1111-colab/)

233,933 views

Updated February 23, 2024

By Andrew

Stable Diffusion is a text-to-image AI that can be run on personal computers like Mac M1 or M2. In this article, you will find a step-by-step guide for installing and running Stable Diffusion on Mac.

Here are the install options I will go through in this article.

Draw Things – Easiest to install with a good set of features.

Diffusers – Easiest to install but with not many features.

DiffusionBee – Easy to install but with a smaller set of functions.

AUTOMATIC1111 – Best features but a bit harder to install.

Alternatively, run Stable Diffusion on Google Colab using AUTOMATIC1111 Stable Diffusion WebUI. Check the Quick Start Guide for details.

Read this install guide to install Stable Diffusion on a Windows PC.

Think Diffusion offers fully managed AUTOMATIC1111 online without setup. They offer our readers an extra 20% credit. (Affiliated link — a earn a small commission.)

### 01. Hardware requirements

For reasonable speed, you will need a Mac with Apple Silicon (M1 or M2).

Recommended CPUs are: M1, M1 pro, M1 max, M2, M2 pro and M2 max. In addition to the efficient cores, the performance cores are important for Stable Diffusion's performance.

The computer's form factor doesn't really matter. It can be a Macbook Air, Macbook Pro, Mac Mini, iMac, Mac Studio, or Mac Pro.

Ideally, your machine will have 16 GB of memory or more.

Stable Diffusion, like many AI models, runs slower on Mac. A similarly priced Windows PC with a dedicated GPU will deliver an image faster.

### 02. Draw Things App

[Draw Things: AI Generation on the App Store](https://apps.apple.com/us/app/draw-things-ai-generation/id6444050820)

Install Instructions

Draw Things

Draw Things is an Apple App that can be installed on iPhones, iPad, and Macs. Installing it is no different from installing any other App.

App Product Page

It supports a pretty extensive list of models out of the box and a reasonable set of customizations you can make. It also supports inpainting.

Pros and Cons of Draw Things App

Pros

Easy to install

A good set of features

Cons

Features are not as extensive as AUTOMATIC1111

### 03. Diffusers App

Install Instructions

Diffusers is a Mac app made by Hugging Face, the place where many Stable Diffusion models are hosted. You can install the app using the link below.

Link to Diffusers app page

Customizations and available models are pretty limited.

Pros and Cons of Diffusers App

Pros:

Easy to install.

Cons:

Very limited models and features.

### 04. DiffusionBee

In this section, you will learn how to install and run DiffusionBee on Mac step-by-step.

Install DiffusionBee on Mac

DiffusionBee is one of the easiest ways to run Stable Diffusion on Mac. Its installation process is no different from any other app.

Step 1: Go to DiffusionBee's download page and download the installer for MacOS – Apple Silicon. A dmg file should be downloaded.

Step 2: Double-click to run the downloaded dmg file in Finder. The following windows will show up.

Step 3: Drag the DiffusionBee icon on the left to the Applications folder on the right. Installation is now complete!

Run DiffusionBee on Mac

You can use the spotlight search bar to start StableBee. Press command + spacebar to bring up spotlight search. Type "DiffusionBee" and press return to start DiffusionBee.

It will download some models when it starts for the very first time.

After it is done, you can start using Stable Diffusion! Let's try putting the prompt "a cat" in the prompt box and hit Generate.

Works pretty well! You can click the option button to customize your images such as image size and CFG scale.

Go to the Next Step section to see what to do next.

Pros and Cons of DiffusionBee

Pros

Installation is relatively easy

Cons

Features are a bit lacking.

### 05. AUTOMATIC1111

[AUTOMATIC1111/stable-diffusion-webui: Stable Diffusion web UI](https://github.com/AUTOMATIC1111/stable-diffusion-webui)

This section shows you how to install and run AUTOMATIC1111 on Mac step-by-step.

DiffusionBee is easy to install, but the functionality is pretty limited. If you are (or aspire to be) an advanced user, you will want to use an advanced GUI like AUTOMATIC1111. You will need this GUI if you want to follow my tutorials.

System requirement

You should have an Apple Silicon M1 or M2, with at least 8GB RAM.

Your MacOS version should be at least 12.3. Click the Apple icon on the top left and click About this Mac. Update your MacOS before if necessary.

Install AUTOMATIC1111 on Mac

Step 1: Install Homebrew

Install Homebrew, a package manager for Mac, if you haven't already. Open the Terminal app, type the following command, and press return.

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

Step 2: Install the required packages

Install a few required packages. Open a new terminal and run the following command

brew install python@3.10 git wget

Step 3: Clone the webui repository

Clone the AUTOMATIC1111 repository by running the following command in the terminal

git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui

A new folder stable-diffusion-webui should be created under your home directory.

Run AUTOMATIC1111 on Mac

Follow the steps in this section to start AUTOMATIC1111 GUI for Stable Diffusion.

In the terminal, run the following command.

cd ~/stable-diffusion-webui;./webui.sh

It will take a while to run it for the first time because it will install a bunch of stuff and download a checkpoint model.

When it is done, you should see a message "Running on local URL…". This is the URL to access AUTOMATIC1111.

The WebUI page should be opened automatically. If not, open a web browser and click the following URL to start Stable Diffusion.

http://127.0.0.1:7860/

You should see the AUTOMATIC1111 GUI. Put in a prompt "a cat" and press Generate to test using the GUI.

Close the terminal when you are done. Follow the steps in this section the next time when you want to run Stable Diffusion.

Updating AUTOMATIC1111 Web-UI

Your AUTOMATIC1111 won't be automatically updated. You will miss new features if you don't upgrade it periodically. However, there's always a risk of breaking things every time you update.

To update AUTOMATIC1111, first open the Terminal App.

Go into the AUTOMATIC1111 Web-UI's folder.

cd ~/stable-diffusion-webui

Lastly, update the software by pulling the latest codes.

git pull

Run AUTOMATIC1111 to see if it's working properly. If you experience issues, delete the venv folder inside the stable-diffusion-webui folder and restart again.

Pros and Cons of AUTOMATIC1111

Pros

Best features among all apps

Cons

Difficult to install if you are not tech-savvy.

### 06. Frequently Asked Questions

Does AUTOMATIC1111 on Mac support SDXL?

Yes! You will need to update your AUTOMATIC1111 if you have not done it recently. Just do a git pull. See the SDXL tutorial for downloading the model.

『

Prompt：

与 stable diffusion 相关的 SDXL 是指什么，解释的越详细越好

GPT-4（2024-03-02）

"SDXL" 通常指的是与 "Stable Diffusion" 相关的一种扩展或增强版本，专门设计用于生成更高质量、更大尺寸的图像。"Stable Diffusion" 是一个流行的开源深度学习模型，用于生成高质量的图像。它是由稳定性 AI 公司和其他合作者开发的，能够根据用户输入的文本描述生成相应的图像。

具体到 "SDXL"，这个术语可能指的是对原始 "Stable Diffusion" 模型的一种修改或优化版本，这种版本被设计成能够处理更大的图像尺寸，同时保持或提高图像质量。在深度学习和图像生成领域，"XL" 通常用来表示 "Extra Large"，意味着这个版本在处理能力、图像尺寸或模型参数上超出了常规范围。

"SDXL" 可能包含以下几个方面的改进：

1、更大的图像尺寸：原始的 "Stable Diffusion" 模型可能限制在特定的最大图像尺寸，而 "SDXL" 版本可以生成更大尺寸的图像，这对于需要高分辨率输出的应用场景非常重要。

2、改进的图像质量：通过优化模型结构或训练过程，"SDXL" 可以提供更细腻的细节和更高的图像质量。

3、扩展的功能：除了提高图像尺寸和质量外，"SDXL" 还可能引入新的功能或改进，比如更好的文本到图像的映射能力、更广泛的风格支持或更高效的生成速度。

4、尽管 "SDXL" 提供了这些潜在的改进，但实现这些改进可能需要更强大的计算资源。生成更大尺寸的图像通常需要更多的显存和处理时间，这可能限制了某些用户的使用。

需要注意的是，"SDXL" 并不是一个官方术语，不同的社区或开发者可能有不同的实现和解释。如果你对 "SDXL" 的具体实现或版本感兴趣，建议查看相关的开发者文档或社区讨论以获得最准确的信息。

』

I got the error "urllib.error.URLError: <urlopen error [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: unable to get local issuer certificate (_ssl.c:997)>" when generating images

Press Command+Space to bring up Spotlight search.

Search for

Install Certificates.command

Open and run it. If will tell you which Python version you ran. Make sure you have run Python 3.10.

I got "RuntimeError: Cannot add middleware after an application has started"

If you get the following error:

File "/Users/XXXXX/stable-diffusion-webui/venv/lib/python3.10/site-packages/starlette/applications.py", line 139, in add_middleware

raise RuntimeError("Cannot add middleware after an application has started")

RuntimeError: Cannot add middleware after an application has started

This is caused by an outdated fastapi package. Run the following command in the webui folder.

./venv/bin/python -m pip install --upgrade fastapi==0.90.1

I got RuntimeError: "LayerNormKernelImpl" not implemented for ‘Half'

Start the webUI with the following command.

./webui.sh --precision full --no-half

When running v2-1_768-ema-pruned.ckpt model, the I got the error: "modules.devices.NansException: A tensor with all NaNs was produced in Unet. This could be either because there's not enough precision to represent the picture, or because your video card does not support half type. Try setting the "Upcast cross attention layer to float32″ option in Settings > Stable Diffusion or using the –no-half commandline argument to fix this. Use –disable-nan-check commandline argument to disable this check."

Start webUI with the following command to remove this error.

./webui.sh --no-half

However, as of July 2023, the v2.1 768 model does not produce sensible images.

### 07. Next Steps

Now you can run Stable Diffusion; below are some suggestions on what to learn next.

01 Check out how to build good prompts.

[Stable Diffusion prompt: a definitive guide - Stable Diffusion Art](https://stable-diffusion-art.com/prompt-guide/)

02 Check out this article to learn what the parameters in GUI mean.

[Know these Important Parameters for stunning AI images - Stable Diffusion Art](https://stable-diffusion-art.com/know-these-important-parameters-for-stunning-ai-images/)

03 Download some new models and have fun!

[Stable Diffusion Models: a beginner's guide - Stable Diffusion Art](https://stable-diffusion-art.com/models/)

Avatar, By Andrew

Andrew is an experienced engineer with a specialization in Machine Learning and Artificial Intelligence. He is passionate about programming, art, photography, and education. He has a Ph.D. in engineering.