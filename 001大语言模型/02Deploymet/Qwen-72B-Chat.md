[Qwen/Qwen-72B · Hugging Face](https://huggingface.co/Qwen/Qwen-72B)

[QwenLM/Qwen: The official repo of Qwen (通义千问) chat & pretrained large language model proposed by Alibaba Cloud.](https://github.com/QwenLM/Qwen/tree/main)

[Qwen/README\_CN.md at main · QwenLM/Qwen](https://github.com/QwenLM/Qwen/blob/main/README_CN.md)



### 下载模型文件

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

1、先 buid 项目。

直接在仓库文件根目录下面运行：

make

2、转为 gguf 文件。

python convert-hf-to-gguf.py /Users/Daglas/dalong.datasets/Qwen-72B-Chat --outfile /Users/Daglas/dalong.datasets/qwen72b-chat-f16.gguf --outtype f16

3、量化。

./quantize /Users/Daglas/dalong.datasets/qwen72b-chat-f16.gguf /Users/Daglas/dalong.datasets/qwen72b-chat-q4_0.gguf q4_0

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

###  CLI 运行

./main -m /Users/Daglas/dalong.datasets/qwen72b-chat-q4_0.gguf -n 512 --color -i -cml -f prompts/chat-with-qwen.txt

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
    --url http://192.168.31.208:8081/v1/chat/completion \
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
    --url http://localhost:8081/completions \
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



