### 跑模型

python3.10 main.py


### 资源

[comfyanonymous/ComfyUI: The most powerful and modular stable diffusion GUI, api and backend with a graph/nodes interface.](https://github.com/comfyanonymous/ComfyUI?tab=readme-ov-file)

### 下载模型文件


### 问题记录

1、第一次跑不起来。

2024-06-02

报错：

Traceback (most recent call last):
  File "main.py", line 73, in <module>
    import comfy.utils
  File "/Users/Daglas/dalong.llm/ComfyUI/comfy/utils.py", line 5, in <module>
    import safetensors
ModuleNotFoundError: No module named 'safetensors'

即使重新建了一个 comfyui 的虚拟环境，依赖包全部重新安装，也没有解决。

试着在项目 sd-webui 里搜 import safetensors 关键词，也能搜到，说明那边可以调用的，包没问题。

灵光一闪，可以是命令 Python 没调 3.10 版本，直接更改为：

python3.10 main.py

能解决，运气使然。

### 好提示词收集

beautiful scenery nature glass bottle landscape, , purple galaxy bottle,


### 插件汇总



### 碎片记录

