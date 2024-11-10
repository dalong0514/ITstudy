### 运行

python client/cli.py ocr --file examples/example-mri.pdf --ocr_cache --prompt_file=examples/example-mri-remove-pii.txt --model llama3.1:latest

python client/cli.py ocr --file /Users/Daglas/Downloads/2019623管理行为_1-5.pdf --ocr_cache --prompt_file=examples/example-mri-remove-pii.txt --model qwen2.5:72b

python client/cli.py ocr --file /Users/Daglas/Downloads/2019623管理行为_1-5.pdf --ocr_cache --prompt_file=examples/example-mri-remove-pii.txt --model llama3.1:70b

上面三个模型识别出来的都不理想。（2024-11-09）

图片目前无法识别。

python client/cli.py ocr --file /Users/Daglas/Downloads/2019623管理行为_1-5_00.png --ocr_cache --prompt_file=examples/example-mri-remove-pii.txt --model llama3.2-vision:90b

### 资源

[CatchTheTornado/pdf-extract-api: Document (PDF) extraction and parse API using state of the art modern OCRs + Ollama supported models. Anonymize documents. Remove PII. Convert any document or picture to structured JSON or Markdown](https://github.com/CatchTheTornado/pdf-extract-api)

### 搭建服务

本来想着用 docker 跑的，但跑完发现本地已安装的 ollama 和 docker 里的 ollama 会冲突：1）暴露的端口冲突了。2）docker 里的 ollama 又要重新下载本地模型。

基于以上考虑，还是本地跑的项目。

1、建虚拟环境。

python3 -m venv .venv
source .venv/bin/activate
\# now you've got access to `python` and `pip` commands

2、复制配置文件。

cp .env.localhost.example .env.localhost

3、修改执行文件权限并跑服务。

chmod +x run.sh
run.sh

### 问题

2024-11-09

1、每次跑都要重新拉本地的模型。

解决方案：

修改跑服务的文件 run.sh，把拉新模型的语句注释掉。

\# echo "Pulling LLama3.1 model"
\# ollama pull llama3.1

2、无法连接到本地模型。

解决方案：

.env.localhost 文件里改本地模型的地址：

\# OLLAMA_HOST=http://localhost:11434
OLLAMA_HOST=https://76b3-117-147-119-165.ngrok-free.app

上面是默认的，改成之前自己累积的经验，ngrok 配置的暴露 ollama 出来的地址。

3、跑的时候要下载 huggingface 上的一个模型，下载不下来。

报错信息：

OSError: We couldn't connect to 'https://huggingface.co' to load this file, couldn't find it in the cached files and it looks like vikp/surya_det2 is not the path to a directory containing a file named config.json.
Checkout your internet connection or see how to run the library in offline mode at 'https://huggingface.co/docs/transformers/installation#offline-mode'.

解决方案：突发奇想的，因为之前有遇到过下载 huggingface 的经验。需要先设置一下环境变量。

一定要在跑服务的那个 shell 里输入：

export HF_ENDPOINT=https://hf-mirror.com

这样跑服务的时候就能下载模型了。

改完之后还是没跑起来，不知道如何解决，但感觉可能是因为还有些模型文件没下载下来，后来第二次重新跑就成功了。

