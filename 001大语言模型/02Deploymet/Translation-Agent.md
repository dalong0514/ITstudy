### 资源

[andrewyng/translation-agent](https://github.com/andrewyng/translation-agent?tab=readme-ov-file)

### 部署记录

安装依赖包：

pip install langchain

安装 OpenAI sdk：

pip install -U langchain-openai


### 跑模型记录

激活虚拟环境：

poetry shell

跑模型：

python3.9 example_script.py

### 问题记录

1、忘记通过 poetry 安装项目自动配置的虚拟环境的依赖包。

poetry install

2、找不到 translation_agent 包。

Traceback (most recent call last):
  File "/Users/Daglas/dalong.llm/translation-agent/examples/example_script.py", line 3, in <module>
    import translation_agent as ta
ModuleNotFoundError: No module named 'translation_agent'

原因：

自己的 mac 不知道为啥 Python 默认的是 3.9 版，一直想改。

poetry install 安装的虚拟环境用的是 Python3.9 的，跑模型的时候自己用的命令是：python example_script.py

之前环境变量自己设置调 python 是调 Python3.10 的。

解决方案：

python3.9 example_script.py

