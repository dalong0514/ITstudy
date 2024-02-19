


### DeepSeek

2023-12-23


python convert.py /Users/Daglas/dalong.datasets/Yi-34B-Chat --outfile /Users/Daglas/dalong.datasets/yi-34b-chat.gguf --outtype f16 --padvocab



1、转 gguf 文件。

直接用之前转千问的，报错不支持。

python convert-hf-to-gguf.py /Users/Daglas/dalong.datasets/deepseek-llm-67b-chat --outfile /Users/Daglas/dalong.datasets/deepseek-llm-67b-chat.gguf --outtype f16

然后用 convert.py 转，也有问题，不过提示可以加上选项 --padvocab，加上后转成功了。

python convert.py /Users/Daglas/dalong.datasets/deepseek-llm-67b-chat --outfile /Users/Daglas/dalong.datasets/deepseek-llm-67b-chat.gguf --outtype f16 --padvocab

2、量化。

./quantize /Users/Daglas/dalong.datasets/deepseek-llm-67b-chat.gguf /Users/Daglas/dalong.datasets/deepseek-llm-67b-chat-q5_k_m.gguf q5_k_m

3、跑 API。

./server -m /Users/Daglas/dalong.datasets/deepseek-llm-67b-chat-q5_k_m.gguf -c 4096 --host 0.0.0.0

### 跑服务

跑 API：

./server -m /Users/Daglas/dalong.datasets/qwen72b-chat-q4_0.gguf -c 4096 --host 0.0.0.0

./server -m /Users/Daglas/dalong.datasets/qwen72b-chat-q4_0.gguf -c 8192 --host 0.0.0.0

make -j && ./server -m /Users/Daglas/dalong.datasets/qwen72b-chat-q4_0.gguf -c 4096 --host 0.0.0.0


跑 CLI：

./main -m /Users/Daglas/dalong.datasets/qwen72b-chat-q4_0.gguf -n 4096 --color -i -cml -f prompts/chat-with-qwen.txt



[llama.cpp/examples/server/README.md at master · ggerganov/llama.cpp](https://github.com/ggerganov/llama.cpp/blob/master/examples/server/README.md)

This example demonstrates a simple HTTP API server and a simple web front end to interact with llama.cpp.

Command line options:

--threads N, -t N: Set the number of threads to use during generation.
-tb N, --threads-batch N: Set the number of threads to use during batch and prompt processing. If not specified, the number of threads will be set to the number of threads used for generation.
-m FNAME, --model FNAME: Specify the path to the LLaMA model file (e.g., models/7B/ggml-model.gguf).
-a ALIAS, --alias ALIAS: Set an alias for the model. The alias will be returned in API responses.
-c N, --ctx-size N: Set the size of the prompt context. The default is 512, but LLaMA models were built with a context of 2048, which will provide better results for longer input/inference. The size may differ in other models, for example, baichuan models were build with a context of 4096.
-ngl N, --n-gpu-layers N: When compiled with appropriate support (currently CLBlast or cuBLAS), this option allows offloading some layers to the GPU for computation. Generally results in increased performance.
-mg i, --main-gpu i: When using multiple GPUs this option controls which GPU is used for small tensors for which the overhead of splitting the computation across all GPUs is not worthwhile. The GPU in question will use slightly more VRAM to store a scratch buffer for temporary results. By default GPU 0 is used. Requires cuBLAS.
-ts SPLIT, --tensor-split SPLIT: When using multiple GPUs this option controls how large tensors should be split across all GPUs. SPLIT is a comma-separated list of non-negative values that assigns the proportion of data that each GPU should get in order. For example, "3,2" will assign 60% of the data to GPU 0 and 40% to GPU 1. By default the data is split in proportion to VRAM but this may not be optimal for performance. Requires cuBLAS.
-b N, --batch-size N: Set the batch size for prompt processing. Default: 512.
--memory-f32: Use 32-bit floats instead of 16-bit floats for memory key+value. Not recommended.
--mlock: Lock the model in memory, preventing it from being swapped out when memory-mapped.
--no-mmap: Do not memory-map the model. By default, models are mapped into memory, which allows the system to load only the necessary parts of the model as needed.
--numa: Attempt optimizations that help on some NUMA systems.
--lora FNAME: Apply a LoRA (Low-Rank Adaptation) adapter to the model (implies --no-mmap). This allows you to adapt the pretrained model to specific tasks or domains.
--lora-base FNAME: Optional model to use as a base for the layers modified by the LoRA adapter. This flag is used in conjunction with the --lora flag, and specifies the base model for the adaptation.
-to N, --timeout N: Server read/write timeout in seconds. Default 600.
--host: Set the hostname or ip address to listen. Default 127.0.0.1.
--port: Set the port to listen. Default: 8080.
--path: path from which to serve static files (default examples/server/public)
--embedding: Enable embedding extraction, Default: disabled.
-np N, --parallel N: Set the number of slots for process requests (default: 1)
-cb, --cont-batching: enable continuous batching (a.k.a dynamic batching) (default: disabled)
-spf FNAME, --system-prompt-file FNAME Set a file to load "a system prompt (initial prompt of all slots), this is useful for chat applications. See more
--mmproj MMPROJ_FILE: Path to a multimodal projector file for LLaVA.


####  CLI 运行

./server -m /Users/Daglas/dalong.datasets/qwen72b-chat-q8_0.gguf -c 4096 --host 0.0.0.0


./server -m /Users/Daglas/dalong.datasets/qwen72b-chat-q4_0.gguf -c 4096 --host 0.0.0.0

./main -m /Users/Daglas/dalong.datasets/qwen72b-chat-q4_0.gguf -n 4096 --color -i -cml -f prompts/chat-with-qwen.txt

### Qwen-72B-Chat

[Qwen/Qwen-72B · Hugging Face](https://huggingface.co/Qwen/Qwen-72B)

[QwenLM/Qwen: The official repo of Qwen (通义千问) chat & pretrained large language model proposed by Alibaba Cloud.](https://github.com/QwenLM/Qwen/tree/main)

[Qwen/README\_CN.md at main · QwenLM/Qwen](https://github.com/QwenLM/Qwen/blob/main/README_CN.md)

#### 下载模型文件

2023-12-04

下载模型文件。

注意事项：下载模型的时候把代理推出来。


[通义千问-72B-Chat · 模型库](https://modelscope.cn/models/qwen/Qwen-72B-Chat/files)

git lfs install
git clone https://www.modelscope.cn/qwen/Qwen-72B-Chat.git


Int4 版的

[通义千问-72B-Chat-Int4 · 模型库](https://modelscope.cn/models/qwen/Qwen-72B-Chat-Int4/files)

git lfs install
git clone https://www.modelscope.cn/qwen/Qwen-72B-Chat-Int4.git


git remote add upstream https://github.com/QwenLM/Qwen.git

###  量化

Allowed quantization types:
   2  or  Q4_0   :  3.56G, +0.2166 ppl @ LLaMA-v1-7B
   3  or  Q4_1   :  3.90G, +0.1585 ppl @ LLaMA-v1-7B
   8  or  Q5_0   :  4.33G, +0.0683 ppl @ LLaMA-v1-7B
   9  or  Q5_1   :  4.70G, +0.0349 ppl @ LLaMA-v1-7B
  10  or  Q2_K   :  2.63G, +0.6717 ppl @ LLaMA-v1-7B
  12  or  Q3_K   : alias for Q3_K_M
  11  or  Q3_K_S :  2.75G, +0.5551 ppl @ LLaMA-v1-7B
  12  or  Q3_K_M :  3.07G, +0.2496 ppl @ LLaMA-v1-7B
  13  or  Q3_K_L :  3.35G, +0.1764 ppl @ LLaMA-v1-7B
  15  or  Q4_K   : alias for Q4_K_M
  14  or  Q4_K_S :  3.59G, +0.0992 ppl @ LLaMA-v1-7B
  15  or  Q4_K_M :  3.80G, +0.0532 ppl @ LLaMA-v1-7B
  17  or  Q5_K   : alias for Q5_K_M
  16  or  Q5_K_S :  4.33G, +0.0400 ppl @ LLaMA-v1-7B
  17  or  Q5_K_M :  4.45G, +0.0122 ppl @ LLaMA-v1-7B
  18  or  Q6_K   :  5.15G, -0.0008 ppl @ LLaMA-v1-7B
   7  or  Q8_0   :  6.70G, +0.0004 ppl @ LLaMA-v1-7B
   1  or  F16    : 13.00G              @ 7B
   0  or  F32    : 26.00G              @ 7B
          COPY   : only copy tensors, no quantizing

1、先 buid 项目。

直接在仓库文件根目录下面运行：

make

2、转为 gguf 文件。

python convert-hf-to-gguf.py /Users/Daglas/dalong.datasets/Qwen-72B-Chat --outfile /Users/Daglas/dalong.datasets/qwen72b-chat-f16.gguf --outtype f16

python convert-hf-to-gguf.py /Users/Daglas/dalong.datasets/Qwen1.5-72B-Chat --outfile /Users/Daglas/dalong.datasets/qwen1.5-72b-chat-f16.gguf --outtype f16

python convert.py /Users/Daglas/dalong.datasets/Qwen1.5-72B-Chat --outfile /Users/Daglas/dalong.datasets/qwen1.5-72b-chat-f16.gguf --outtype f16





python convert-hf-to-gguf.py /Users/Daglas/dalong.datasets/chatglm3-6b-32k --outfile /Users/Daglas/dalong.datasets/chatglm3-6b-32k-f16.gguf --outtype f16

3、量化。

./quantize /Users/Daglas/dalong.datasets/qwen72b-chat-f16.gguf /Users/Daglas/dalong.datasets/qwen72b-chat-q4_0.gguf q4_0

./quantize /Users/Daglas/dalong.datasets/qwen72b-chat-f16.gguf /Users/Daglas/dalong.datasets/qwen72b-chat-q5_k_m.gguf q5_k_m

4、运行。

./main -m /Users/Daglas/dalong.datasets/qwen72b-chat-q4_0.gguf -n 512 --color -i -cml -f prompts/chat-with-qwen.txt

信息源：

[ggerganov/llama.cpp: Port of Facebook's LLaMA model in C/C++](https://github.com/ggerganov/llama.cpp)

[Merge qwen to llama cpp by simonJJJ · Pull Request #4281 · ggerganov/llama.cpp](https://github.com/ggerganov/llama.cpp/pull/4281)

\# convert Qwen HF models to gguf fp16 format
python convert-hf-to-gguf.py --outfile /Users/Daglas/dalong.datasets/qwen72b-chat-f16.gguf --outtype f16 Qwen-7B-Chat

\# quantize the model to 4-bits (using q4_0 method)
./build/bin/quantize qwen7b-chat-f16.gguf qwen7b-chat-q4_0.gguf q4_0

\# chat with Qwen models
./build/bin/main -m qwen7b-chat-q4_0.gguf -n 512 --color -i -cml -f prompts/chat-with-qwen.txt

###  做 API 接口

[llama.cpp/examples/server at master · ggerganov/llama.cpp](https://github.com/ggerganov/llama.cpp/tree/master/examples/server)

./server -m /Users/Daglas/dalong.datasets/qwen72b-chat-q4_0.gguf -c 2048

./server -m /Users/Daglas/dalong.datasets/qwen72b-chat-q4_0.gguf -c 4096 --host 0.0.0.0

./server -m /Users/Daglas/dalong.datasets/qwen72b-chat-q4_0.gguf -c 8192 --host 0.0.0.0 --embedding

备注：一定要改成 0.0.0.0，否则其他服务访问不了。




    parser.add_argument(
        "--server-name",
        type=str,
        default="0.0.0.0",
        help="Demo server name. Default: 127.0.0.1, which is only visible from the local computer."
        " If you want other computers to access your server, use 0.0.0.0 instead.",
    )


curl --request POST \
    --url http://localhost:8080/embedding \
    --header "Content-Type: application/json" \
    --data '{"content": "Building a website can be done in 10 simple steps:"}'
	
	

curl --request POST \
    --url http://localhost:8080/v1/embeddings \
    --header "Content-Type: application/json" \
    --data '{"content": "Building a website can be done in 10 simple steps:"}'



curl --request POST \
    --url http://localhost:8080/completion \
    --header "Content-Type: application/json" \
    --data '{"prompt": "Building a website can be done in 10 simple steps:","n_predict": 128}'
	

curl --request POST \
    --url http://192.168.31.208:8080/completion \
    --header "Content-Type: application/json" \
    --data '{"prompt": "你好，给我讲一个故事，大概100字","n_predict": 128}'

curl --request POST \
    --url http://127.0.0.1:8080/completion \
    --header "Content-Type: application/json" \
    --data '{"prompt": "你好，给我讲一个故事，大概100字","n_predict": 128}'

curl --request POST \
    --url http://localhost:8080/completion \
    --header "Content-Type: application/json" \
    --data '{"prompt": "你好，给我讲一个故事，大概100字","n_predict": 128}'

curl --request POST \
    --url http://localhost:8081/completion \
    --header "Content-Type: application/json" \
    --data '{"prompt": "你好，给我讲一个故事，大概100字","n_predict": 128}'






curl --request POST \
    --url http://localhost:8000/completion \
    --header "Content-Type: application/json" \
    --data '{"prompt": "你好，给我讲一个故事，大概100字","n_predict": 128}'


curl --request POST \
    --url http://localhost:8000/v1/embeddings \
    --header "Content-Type: application/json" \
    --data '{"content": "你好，给我讲一个故事，大概100字"}'


curl --request POST \
    --url http://localhost:8000/completions \
    --header "Content-Type: application/json" \
    --data '{"prompt": "你好，给我讲一个故事，大概100字","n_predict": 128}'


curl --request POST \
    --url http://localhost:8000/v1/chat/completions \
    --header "Content-Type: application/json" \
    --data '{"prompt": "你好，给我讲一个故事，大概100字","n_predict": 128}'

curl --request POST \
    --url http://localhost:8000/v1 \
    --header "Content-Type: application/json" \
    --data '{"prompt": "你好，给我讲一个故事，大概100字","n_predict": 128}'


### embedding

POST /embedding

改为：

POST /v1/embeddings

需要重新 make 构建一下整个。

[llama.cpp/examples/embedding at master · ggerganov/llama.cpp](https://github.com/ggerganov/llama.cpp/tree/master/examples/embedding)

./embedding -m ./path/to/model --log-disable -p "Hello World!" 2>/dev/null

向量化的接口传参不一样，用下面的可以跑通。

curl --request POST \
    --url http://localhost:8000/v1/embeddings \
    --header "Content-Type: application/json" \
    --data '{"content": "你好，给我讲一个故事，大概100字"}'

#### 2023-12-08

今晚连着好几个灵感，真爽！

灵感 01：会不会 server.cpp 和 api_like_OAI.py 同时跑。因为单独跑 api_like_OAI.py 看到说找不到接口。

灵感 02：意识到老代码用的是 Flask，而新代码（fastgpt）里用的是 FastAPI 实现的。

灵感 03：能不能让 GPT 把函数 async def completion 改写，从 Flask 模式改写成 FastAPI 模式。

01

核心难题解决，今天终于用里面的 api_like_OAI.py 接口跑通了。

核心问题是，python api_like_OAI.py 跑的时候，得先用：

./server -m /Users/Daglas/dalong.datasets/qwen72b-chat-q4_0.gguf -c 4096 --host 0.0.0.0

把基础服务跑起来，说白了 api_like_OAI 是个中转，它也是调 server.cpp 跑的基础接口。

另外一个注意事项，监听的本地默认 ip 要改成 0.0.0.0

原代码：

parser.add_argument("--host", type=str, help="Set the ip address to listen.(default: 127.0.0.1)", default='127.0.0.1')

更改后：

parser.add_argument("--host", type=str, help="Set the ip address to listen.(default: 127.0.0.1)", default='0.0.0.0')

02

用 llama.cpp 成功在本地跑通 Qwen72B 的大模型+关联外部知识库。llama.cpp仓库里实现了：chat+embedding。

整个过程记录：

1、原样把 fastgpt 的代码拷到 api_like_OAI.py 上，/v1/embeddings 接口无效的。

『
第一次问 GPT：

这个错误是因为在调用get_embeddings()函数时没有提供必需的参数request。在你的代码中，get_embeddings()函数定义为接收一个名为request的参数，这个参数是EmbeddingRequest类型的实例。

在Flask中，你通常会从请求中获取这个参数，例如使用request.get_json()。但是在你的代码中，你正在使用FastAPI，它有一个不同的方式来处理这个问题。

在FastAPI中，你可以直接在函数参数中定义你的请求体，FastAPI会自动处理它。但是你需要使用Pydantic模型来定义你的请求体。你已经正确地定义了EmbeddingRequest模型，但是你需要在函数参数中使用它。

你的函数定义应该看起来像这样：

from fastapi import FastAPI
from pydantic import BaseModel
from typing import List

class EmbeddingRequest(BaseModel):
    input: List[str]
    model: str

app = FastAPI()

@app.post("/v1/embeddings")
async def get_embeddings(request: EmbeddingRequest):
    # your code here

这样，FastAPI会自动从请求体中解析EmbeddingRequest模型，并将其作为参数传递给你的函数。

』

到这里还没意识到老代码用的是 Flask，而新代码（fastgpt）里用的是 FastAPI 实现的。

按提示修改后还是报错，接着问 GPT，回复如下：

『

这个错误是因为你试图使用app.run()来运行FastAPI应用，但是FastAPI没有这个方法。FastAPI应用通常使用ASGI服务器，如Uvicorn或Hypercorn来运行。

你可以修改你的代码，使用Uvicorn来运行你的应用。首先，你需要安装Uvicorn，你可以使用以下命令来安装：

pip install uvicorn

然后，你可以修改你的代码，使用Uvicorn来运行你的应用：

import uvicorn

if __name__ == '__main__':
    embeddings_model = SentenceTransformer('/Users/Daglas/dalong.datasets/m3e-base', device='cpu')
    uvicorn.run(app, host=args.host, port=args.port)

请注意，你需要将args.host和args.port替换为你的主机和端口。如果你没有定义这些变量，你可以直接使用字符串，例如'0.0.0.0'和8000。

』

这个时候才意识到老代码用的是 Flask，而新代码（fastgpt）里用的是 FastAPI 实现的。

发现跑的时候，新代码用的是 uvicorn.run，老代码用的是 app.run；定义接口时，新代码用的是 @app.post("/v1/embeddings")，老代码用的是：@app.route('/v1/chat/completions', methods=['POST', 'OPTIONS'])

修改完后，接口 @app.post("/v1/embeddings") 通了，可以量化外部文档了。

但接着又出现原来的 chat 接口：@app.route('/v1/chat/completions', methods=['POST', 'OPTIONS']) 不通了，卡在这里了。

改了好几版没解决。

『

GPT 的回复记录：

这个错误是因为在调用get_embeddings()函数时没有提供必需的参数request。在你的代码中，get_embeddings()函数定义为接收一个名为request的参数，这个参数是EmbeddingRequest类型的实例。

在Flask中，你通常会从请求中获取这个参数，例如使用request.get_json()。但是在你的代码中，你正在使用FastAPI，它有一个不同的方式来处理这个问题。

在FastAPI中，你可以直接在函数参数中定义你的请求体，FastAPI会自动处理它。但是你需要使用Pydantic模型来定义你的请求体。你已经正确地定义了EmbeddingRequest模型，但是你需要在函数参数中使用它。

你的函数定义应该看起来像这样：

这样，FastAPI会自动从请求体中解析EmbeddingRequest模型，并将其作为参数传递给你的函数。

你的错误日志显示你正在使用 Flask，但是你的代码是用 FastAPI 写的。这可能是问题的根源。你需要使用一个 ASGI 服务器，如 Uvicorn 或 Hypercorn，来运行你的 FastAPI 应用，而不是 Flask。

uvicorn server.fastgpt_api:app --host 0.0.0.0 --port 8000

』

虽然用 uvicorn server.fastgpt_api:app --host 0.0.0.0 --port 8000 没启动起来，但前面的语句：

你的错误日志显示你正在使用 Flask，但是你的代码是用 FastAPI 写的。这可能是问题的根源。

给了我灵感，我能不能让 GPT 把函数 async def completion 改写，从 Flask 模式改写成 FastAPI 模式。

接着选中代码里的 completion 函数，提示词：请将所选的代码，从用 Flask 改写为用 FastAPI

报错不一样了，说明有进展。

接着选中改写后的代码，提示词：所选的代码，Flask 代码转换为 FastAPI 代码后，出现了问题，报错： postData["prompt"] = convert_chat(body["messages"]) 请结合原来的FastAPI 代码进行修复，原代码如下：

（粘贴了仓库里原始的那个 completion 函数）

想不到真的跑通了！但有个警告，继续。

接着选中改写后的代码，提示词：所选代码改写成功了，但运行后报出提示，请进行优化： /Users/Daglas/dalong.llm/llama.cpp/examples/server/fastgpt_api.py:220: PydanticDeprecatedSince20: The dict method is deprecated; use model_dump instead. Deprecated in Pydantic V2.0 to be removed in V3.0. See Pydantic V2 Migration Guide at https://errors.pydantic.dev/2.5/migration/ postData = make_postData(body.dict(), chat=True, stream=stream)

改写成功！


```py
class Message(BaseModel):
    role: str
    content: str

class ChatCompletionBody(BaseModel):
    messages: List[Message] = Field(...)
    stream: Optional[bool] = False
    tokenize: Optional[bool] = False

app = FastAPI()

@app.post("/v1/chat/completions")
async def chat_completions(request: Request, body: ChatCompletionBody):
    if (args.api_key != "" and request.headers["Authorization"].split()[1] != args.api_key):
        raise HTTPException(status_code=403)
    stream = body.stream
    tokenize = body.tokenize
    postData = make_postData(body.dict(), chat=True, stream=stream)

    promptToken = []
    if (tokenize):
        tokenData = requests.request("POST", urllib.parse.urljoin(args.llama_api, "/tokenize"), data=json.dumps({"content": postData["prompt"]})).json()
        promptToken = tokenData["tokens"]

    if (not stream):
        data = requests.request("POST", urllib.parse.urljoin(args.llama_api, "/completion"), data=json.dumps(postData))
        print(data.json())
        resData = make_resData(data.json(), chat=True, promptToken=promptToken)
        return JSONResponse(content=resData)
    else:
        def generate():
            data = requests.request("POST", urllib.parse.urljoin(args.llama_api, "/completion"), data=json.dumps(postData), stream=True)
            time_now = int(time.time())
            resData = make_resData_stream({}, chat=True, time_now=time_now, start=True)
            yield 'data: {}\n\n'.format(json.dumps(resData))
            for line in data.iter_lines():
                if line:
                    decoded_line = line.decode('utf-8')
                    resData = make_resData_stream(json.loads(decoded_line[6:]), chat=True, time_now=time_now)
                    yield 'data: {}\n\n'.format(json.dumps(resData))
        return StreamingResponse(generate(), media_type='text/event-stream')


@app.route('/completions', methods=['POST', 'OPTIONS'])
@app.route('/v1/completions', methods=['POST', 'OPTIONS'])
def completion():
    if (args.api_key != "" and request.headers["Authorization"].split()[1] != args.api_key):
        return Response(status=403)
    if request.method == 'OPTIONS':
        return Response(headers={"Access-Control-Allow-Origin": "*", "Access-Control-Allow-Headers": "*"})
    body = request.get_json()
    stream = False
    tokenize = False
    if(is_present(body, "stream")): stream = body["stream"]
    if(is_present(body, "tokenize")): tokenize = body["tokenize"]
    postData = make_postData(body, chat=False, stream=stream)

    promptToken = []
    if (tokenize):
        tokenData = requests.request("POST", urllib.parse.urljoin(args.llama_api, "/tokenize"), data=json.dumps({"content": postData["prompt"]})).json()
        promptToken = tokenData["tokens"]

    if (not stream):
        data = requests.request("POST", urllib.parse.urljoin(args.llama_api, "/completion"), data=json.dumps(postData))
        print(data.json())
        resData = make_resData(data.json(), chat=False, promptToken=promptToken)
        return jsonify(resData)
    else:
        def generate():
            data = requests.request("POST", urllib.parse.urljoin(args.llama_api, "/completion"), data=json.dumps(postData), stream=True)
            time_now = int(time.time())
            for line in data.iter_lines():
                if line:
                    decoded_line = line.decode('utf-8')
                    resData = make_resData_stream(json.loads(decoded_line[6:]), chat=False, time_now=time_now)
                    yield 'data: {}\n\n'.format(json.dumps(resData))
        return Response(generate(), mimetype='text/event-stream', headers={"Access-Control-Allow-Origin": "*", "Access-Control-Allow-Headers": "*"})


class EmbeddingRequest(BaseModel):
    input: List[str]
    model: str

@app.post("/v1/embeddings")
async def get_embeddings(
    request: EmbeddingRequest
):
    # 计算嵌入向量和tokens数量
    embeddings = [embeddings_model.encode(text) for text in request.input]

    # 如果嵌入向量的维度不为1536，则使用插值法扩展至1536维度
    embeddings = [
        expand_features(embedding, 1536) if len(embedding) < 1536 else embedding
        for embedding in embeddings
    ]

    # Min-Max normalization 归一化
    embeddings = [embedding / np.linalg.norm(embedding) for embedding in embeddings]

    # 将numpy数组转换为列表
    embeddings = [embedding.tolist() for embedding in embeddings]
    prompt_tokens = sum(len(text.split()) for text in request.input)
    total_tokens = sum(num_tokens_from_string(text) for text in request.input)

    response = {
        "data": [
            {"embedding": embedding, "index": index, "object": "embedding"}
            for index, embedding in enumerate(embeddings)
        ],
        "model": request.model,
        "object": "list",
        "usage": {
            "prompt_tokens": prompt_tokens,
            "total_tokens": total_tokens,
        },
    }

    return response

def num_tokens_from_string(string: str) -> int:
    """Returns the number of tokens in a text string."""
    encoding = tiktoken.get_encoding('cl100k_base')
    num_tokens = len(encoding.encode(string))
    return num_tokens

def expand_features(embedding, target_length):
    poly = PolynomialFeatures(degree=2)
    expanded_embedding = poly.fit_transform(embedding.reshape(1, -1))
    expanded_embedding = expanded_embedding.flatten()
    if len(expanded_embedding) > target_length:
        # 如果扩展后的特征超过目标长度，可以通过截断或其他方法来减少维度
        expanded_embedding = expanded_embedding[:target_length]
    elif len(expanded_embedding) < target_length:
        # 如果扩展后的特征少于目标长度，可以通过填充或其他方法来增加维度
        expanded_embedding = np.pad(
            expanded_embedding, (0, target_length - len(expanded_embedding))
        )
    return expanded_embedding


if __name__ == '__main__':
    embeddings_model = SentenceTransformer('/Users/Daglas/dalong.datasets/m3e-base', device='cpu')
    uvicorn.run(app, host=args.host, port=args.port)
```

警告：

/Users/Daglas/dalong.llm/llama.cpp/examples/server/fastgpt_api.py:220: PydanticDeprecatedSince20: The `dict` method is deprecated; use `model_dump` instead. Deprecated in Pydantic V2.0 to be removed in V3.0. See Pydantic V2 Migration Guide at https://errors.pydantic.dev/2.5/migration/
  postData = make_postData(body.dict(), chat=True, stream=stream)
  
GPT 优化后：

```py
@app.route('/completions', methods=['POST', 'OPTIONS'])
@app.route('/v1/completions', methods=['POST', 'OPTIONS'])
def completion():
    if (args.api_key != "" and request.headers["Authorization"].split()[1] != args.api_key):
        return Response(status=403)
    if request.method == 'OPTIONS':
        return Response(headers={"Access-Control-Allow-Origin": "*", "Access-Control-Allow-Headers": "*"})
    body = request.get_json()
    stream = False
    tokenize = False
    if(is_present(body, "stream")): stream = body["stream"]
    if(is_present(body, "tokenize")): tokenize = body["tokenize"]
    postData = make_postData(body, chat=False, stream=stream)

    promptToken = []
    if (tokenize):
        tokenData = requests.request("POST", urllib.parse.urljoin(args.llama_api, "/tokenize"), data=json.dumps({"content": postData["prompt"]})).json()
        promptToken = tokenData["tokens"]

    if (not stream):
        data = requests.request("POST", urllib.parse.urljoin(args.llama_api, "/completion"), data=json.dumps(postData))
        print(data.json())
        resData = make_resData(data.json(), chat=False, promptToken=promptToken)
        return jsonify(resData)
    else:
        def generate():
            data = requests.request("POST", urllib.parse.urljoin(args.llama_api, "/completion"), data=json.dumps(postData), stream=True)
            time_now = int(time.time())
            for line in data.iter_lines():
                if line:
                    decoded_line = line.decode('utf-8')
                    resData = make_resData_stream(json.loads(decoded_line[6:]), chat=False, time_now=time_now)
                    yield 'data: {}\n\n'.format(json.dumps(resData))
        return Response(generate(), mimetype='text/event-stream', headers={"Access-Control-Allow-Origin": "*", "Access-Control-Allow-Headers": "*"}) 

```

### 问题汇总

1、中文有部分乱码。

2023-12-13

前面几天找了半天没解决，今天总算有些起色。

GPT：

如果你的 HTTP 响应头部没有设置正确的字符集，那么可能会导致解码问题。你可以尝试在请求头中设置 Accept-Charset 为 UTF-8，告诉服务器你期望的响应字符集是 UTF-8。

以下是修改后的代码：

在这段代码中，我添加了一个名为 headers 的字典，其中包含一个 Accept-Charset 键，其值为 UTF-8。然后，我在每个 requests.request 调用中添加了 headers=headers，以将这些头部信息发送给服务器。这可能可以解决你的问题。

修改后还是不想，后面又给了方案。

如果你的数据源是 UTF-8 编码的 JSON，但在解码时仍然出现乱码，那么可能的原因是数据源在发送数据时没有正确地编码数据，或者在传输过程中数据被损坏。

在这种情况下，你可以尝试使用 Python 的 codecs 库来解码数据。codecs 库提供了一种更强大的解码方法，可以处理一些复杂的编码问题。

以下是修改后的代码：

在这段代码中，我首先导入了 codecs 库。然后，我将 line.decode('utf-8') 替换为 codecs.decode(line, 'utf-8', 'ignore')。这将使用 codecs 库的解码方法来解码数据，而不是 Python 内置的解码方法。这可能可以解决你的问题。

这版修改后明显乱码比之前的少了。

备注：实验过，仅仅修改使用 codecs 库乱码还是多的，上面 2 个修改结合一起用才有效。




```py
import codecs

@app.post("/v1/chat/completions")
async def chat_completions(request: Request, body: ChatCompletionBody):
    if (args.api_key != "" and request.headers["Authorization"].split()[1] != args.api_key):
        raise HTTPException(status_code=403)
    stream = body.stream
    tokenize = body.tokenize
    postData = make_postData(body.model_dump(), chat=True, stream=stream)

    headers = {'Accept-Charset': 'UTF-8'}

    promptToken = []
    if (tokenize):
        tokenData = requests.request("POST", urllib.parse.urljoin(args.llama_api, "/tokenize"), data=json.dumps({"content": postData["prompt"]}), headers=headers).json()
        promptToken = tokenData["tokens"]

    if (not stream):
        data = requests.request("POST", urllib.parse.urljoin(args.llama_api, "/completion"), data=json.dumps(postData), headers=headers)
        print(data.json())
        resData = make_resData(data.json(), chat=True, promptToken=promptToken)
        return JSONResponse(content=resData)
    else:
        def generate():
            data = requests.request("POST", urllib.parse.urljoin(args.llama_api, "/completion"), data=json.dumps(postData), headers=headers, stream=True)
            time_now = int(time.time())
            resData = make_resData_stream({}, chat=True, time_now=time_now, start=True)
            yield 'data: {}\n\n'.format(json.dumps(resData))
            for line in data.iter_lines():
                if line:
                    decoded_line = codecs.decode(line, 'utf-8', 'ignore')
                    resData = make_resData_stream(json.loads(decoded_line[6:]), chat=True, time_now=time_now)
                    yield 'data: {}\n\n'.format(json.dumps(resData))
        return StreamingResponse(generate(), media_type='text/event-stream')
```

使用codecs 库有效，中文乱码明显少了很多。但还存在很少量的乱码。请根据你的经验分析可能的原因，并给出解决方案

如果使用 codecs 库后中文乱码问题得到了改善，但仍然存在少量乱码，那么可能的原因有以下几点：

数据源在发送数据时没有正确地编码数据。这可能是因为数据源在处理某些特殊字符时出现了问题，或者数据源使用的编码方法与你的解码方法不完全匹配。

在传输过程中数据被损坏。这可能是因为网络问题，或者是因为数据在传输过程中被修改。

你的解码方法没有完全匹配数据源的编码方法。这可能是因为数据源使用了一种特殊的编码方法，或者是因为数据源在编码数据时使用了一些特殊的设置。

针对这些可能的原因，你可以尝试以下解决方案：

联系数据源的提供者，询问他们是否可以提供更详细的编码信息，或者是否可以调整他们的编码方法以更好地匹配你的解码方法。

尝试使用其他的解码方法。Python 的 codecs 库提供了多种解码方法，你可以尝试使用其他的解码方法来看是否可以解决问题。

如果可能，尝试使用其他的传输方法。例如，如果你现在是通过 HTTP 获取数据，你可以尝试使用 HTTPS 来看是否可以解决问题。

如果数据源的编码方法是可配置的，你可以尝试调整编码设置来看是否可以解决问题。

希望这些信息对你有所帮助。



提供背景信息供参考：数据源的提供者的使用者是用 C++些的 http 接口，其接口的源代码如下：

从你提供的 C++ 代码来看，这段代码使用了 httplib 库来处理 HTTP 请求和响应。在处理 POST 请求 "/v1/chat/completions" 时，它会解析请求体中的 JSON 数据，然后请求一个任务完成，并根据任务的结果设置响应的内容。

如果你在接收这个接口的响应时遇到了乱码问题，那么可能的原因是这个接口在设置响应内容时没有正确地编码数据。在 C++ 中，字符串的编码通常是由程序员手动控制的，如果程序员没有正确地处理编码问题，那么可能会导致乱码。

你可以尝试以下解决方案：

联系这个接口的开发者，询问他们是否可以提供更详细的编码信息，或者是否可以调整他们的编码方法以更好地匹配你的解码方法。

在你的代码中添加一些调试信息，例如打印出你接收到的原始数据，这可以帮助你更好地理解问题的原因。

如果可能，尝试使用其他的 HTTP 客户端库来接收数据，看是否可以解决问题。不同的 HTTP 客户端库可能会有不同的处理方式，可能会有一些库可以更好地处理你的问题。

希望这些信息对你有所帮助。



