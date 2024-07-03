### 资源

[2noise/ChatTTS: A generative speech model for daily dialogue.](https://github.com/2noise/ChatTTS?tab=readme-ov-file)

[2Noise/ChatTTS · Hugging Face](https://huggingface.co/2Noise/ChatTTS)

### 部署

1、安装依赖包。

pip install --upgrade -r requirements.txt

注意事项：手动删了 requirements 之前已经安装过的包。

2、跑服务。

python3.10 examples/web/webui.py

3、浏览器里使用。

http://localhost:8080/

### 问题汇总

1、必须用 python3.10 启动。

python examples/web/webui.py

报错：

ModuleNotFoundError: No module named 'gradio'

2、包 gradio 相关的错。

启动时报错：

Traceback (most recent call last):
  File "/Users/Daglas/dalong.llm/ChatTTS/examples/web/webui.py", line 236, in <module>
    main()
  File "/Users/Daglas/dalong.llm/ChatTTS/examples/web/webui.py", line 148, in main
    @gr.render(inputs=[auto_play_checkbox, stream_mode_checkbox])
AttributeError: module 'gradio' has no attribute 'render'

解决方案：先卸载掉，再重新安装。

pip uninstall gradio

pip install gradio