### 01. 信息资源

[Insanely Fast Whisper: 音频极快转录！](https://mp.weixin.qq.com/s/jGHpSyS0ceXCQa9kv_uc8w)

[chenxwh/insanely-fast-whisper: Incredibly fast Whisper-large-v3](https://github.com/chenxwh/insanely-fast-whisper)

下载模型文件：

[whisper-large-v3 · 模型库](https://www.modelscope.cn/models/AI-ModelScope/whisper-large-v3/summary)

git lfs install
git clone https://www.modelscope.cn/AI-ModelScope/whisper-large-v3.git

### 02. 问题汇总

坑 1：通过 pip 安装 pipx，而不是用 brew 安装 pipx。

坑 2：自己下载本地大模型 whisper-large-v3。

一直报错说找不到 transformers 里的 openai/whisper-large-v3 文件。也是问 GPT 获得的灵感，需要手动去下在模型文件。

hugging face 上找到了模型文件：

[openai/whisper-large-v3 at main](https://huggingface.co/openai/whisper-large-v3/tree/main)

因速度慢，改成了 modelscope 里下载的。

下载后又遇到个问题，不知道把模型文件放在哪里，transformers 可以识别到，一点头绪都没有。也是无异中看到仓库里调用命令里，有一个命令里包含模型文件：

insanely-fast-whisper --model-name distil-whisper/large-v2 --file-name <filename or URL> 
	
真是豁然开朗。

Traceback (most recent call last):
  File "/Users/Daglas/.local/bin/insanely-fast-whisper", line 8, in <module>
    sys.exit(main())
  File "/Users/Daglas/.local/pipx/venvs/insanely-fast-whisper/lib/python3.10/site-packages/insanely_fast_whisper/cli.py", line 230, in main
    pipe = pipeline(
  File "/Users/Daglas/.local/pipx/venvs/insanely-fast-whisper/lib/python3.10/site-packages/transformers/pipelines/__init__.py", line 782, in pipeline
    config = AutoConfig.from_pretrained(
  File "/Users/Daglas/.local/pipx/venvs/insanely-fast-whisper/lib/python3.10/site-packages/transformers/models/auto/configuration_auto.py", line 1048, in from_pretrained
    config_dict, unused_kwargs = PretrainedConfig.get_config_dict(pretrained_model_name_or_path, **kwargs)
  File "/Users/Daglas/.local/pipx/venvs/insanely-fast-whisper/lib/python3.10/site-packages/transformers/configuration_utils.py", line 622, in get_config_dict
    config_dict, kwargs = cls._get_config_dict(pretrained_model_name_or_path, **kwargs)
  File "/Users/Daglas/.local/pipx/venvs/insanely-fast-whisper/lib/python3.10/site-packages/transformers/configuration_utils.py", line 677, in _get_config_dict
    resolved_config_file = cached_file(
  File "/Users/Daglas/.local/pipx/venvs/insanely-fast-whisper/lib/python3.10/site-packages/transformers/utils/hub.py", line 470, in cached_file
    raise EnvironmentError(
OSError: We couldn't connect to 'https://huggingface.co' to load this file, couldn't find it in the cached files and it looks like openai/whisper-large-v3 is not the path to a directory containing a file named config.json.
Checkout your internet connection or see how to run the library in offline mode at 'https://huggingface.co/docs/transformers/installation#offline-mode'.

坑 3：跑的时候报错说必须用显卡 cuid。

在仓库文件里的 QA 里看到：

How to avoid Out-Of-Memory (OOM) exceptions on Mac?

The mps backend isn't as optimised as CUDA, hence is way more memory hungry. Typically you can run with --batch-size 4 without any issues (should use roughly 12GB GPU VRAM). Don't forget to set --device mps.

然后知道了在跑的命令后后面加选项 --device mps。

坑 4：通过 brew 安装 ffmpeg，而不是用 pip 安装 ffmpeg。

brew install ffmpeg

接着继续跑，提示没安装 ffmpeg，直觉直接用 pip 安装，发现不行。问了 GPT 后改用 brew 安装，跑通了！

### 03. 部署

1、安装 pipx。

pip install pipx


开始用的 brew 安装，应该是没安装完整，后改为用 pip 安装的。安装后设置了全局变量。

brew install pipx

==> Running `brew cleanup pipx`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
==> Caveats
==> pipx
zsh completions have been installed to:
  /opt/homebrew/share/zsh/site-functions


(llm) ➜  ~ pipx install insanely-fast-whisper
  installed package insanely-fast-whisper 0.0.10, installed using Python 3.10.13
  These apps are now globally available
    - insanely-fast-whisper
⚠️  Note: '/Users/Daglas/.local/bin' is not on your PATH environment variable. These apps will not be globally accessible until your
    PATH is updated. Run `pipx ensurepath` to automatically add it, or manually modify your PATH in your shell's config file (i.e.
    ~/.bashrc).


echo 'export PATH="/Users/Daglas/.local/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc

### 04. 使用

insanely-fast-whisper --model-name /Users/Daglas/dalong.datasets/whisper-large-v3 --file-name /Users/Daglas/Desktop/20230705舒伟杰培训HAZOP.mp3  --device mps

insanely-fast-whisper --model-name /Users/Daglas/dalong.datasets/whisper-large-v3 --file-name /Users/Daglas/Music/dalong.knowledgeAudio/2023001数智设计/20231207与金玉宏交流罐区HAZOP分析模块.mp3 --device mps --transcript-path /Users/Daglas/Music/dalong.knowledgeAudio/2023001数智设计/20231207与金玉宏交流罐区HAZOP分析模块.json


/Users/Daglas/Music/dalong.knowledgeAudio/2023001数智设计/20231207与金玉宏交流罐区HAZOP分析模块.mp3



20230713舒伟杰HAZOP分析培训




