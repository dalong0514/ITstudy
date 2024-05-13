### 运行

python -m llama_cpp.server --model /Users/Daglas/dalong.datasets/qwen72b-chat-q4_0.gguf --host 0.0.0.0

明显推理速度比直接用 llama.cpp 慢很多。

python -m llama_cpp.server --model /Users/Daglas/dalong.datasets/qwen72b-chat-q4_0.gguf 



### 部署

[Getting Started - llama-cpp-python](https://llama-cpp-python.readthedocs.io/en/latest/)

[abetlen/llama-cpp-python: Python bindings for llama.cpp](https://github.com/abetlen/llama-cpp-python)

[MacOS Install with Metal GPU - llama-cpp-python --- 使用 Metal GPU 安装 MacOS - llama-cpp-python](https://llama-cpp-python.readthedocs.io/en/latest/install/macos/)

[Run LLMs on Your CPU with Llama.cpp: A Step-by-Step Guide --- 使用 Llama.cpp 在 CPU 上运行 LLM：分步指南](https://awinml.github.io/llm-ggml-python/)

1、使用 Metal 加速安装 llama-cpp-python。

Installation with Specific Hardware Acceleration (BLAS, CUDA, Metal, etc)
使用特定硬件加速（BLAS、CUDA、Metal 等）进行安装


pip uninstall llama-cpp-python -y
CMAKE_ARGS="-DLLAMA_METAL=on" pip install -U llama-cpp-python --no-cache-dir
pip install 'llama-cpp-python[server]'

\# you should now have llama-cpp-python v0.1.62 or higher installed
llama-cpp-python         0.1.68


### 问题汇总


2023-12-17

1、跑不起来。

报错：

FileNotFoundError: Shared library with base name 'llama' not found

找了半天，也是无意中找到的的解决方案：

[FileNotFoundError: Shared library with base name 'llama' not found · Issue #568 · abetlen/llama-cpp-python](https://github.com/abetlen/llama-cpp-python/issues/568)

Thank you both - I had the same experience. Within the llama-cpp-python project directory, it wouldn't work, as soon as I cd .. and tried, it worked fine. Big thanks to @mapa17 for figuring this out

不能在 llama-cpp-python 项目文件夹下面跑，得出来。cd .. 到了 dalong.llm 文件夹下就能跑，哈哈。

### 参数汇总

[API Reference - llama-cpp-python](https://llama-cpp-python.readthedocs.io/en/latest/api-reference/?ref=localhost#llama_cpp.Llama)

Parameters: 参数：

model_path (str) – Path to the model.
model_path ( str ) – 模型的路径。
n_gpu_layers (int, default: 0 ) – Number of layers to offload to GPU (-ngl). If -1, all layers are offloaded.
n_gpu_layers ( int ，默认值： 0 ) – 要卸载到 GPU 的层数 (-ngl)。如果为 -1，则卸载所有层。
main_gpu (int, default: 0 ) – The GPU that is used for scratch and small tensors.
main_gpu ( int ，默认值： 0 ) – 用于暂存和小张量的 GPU。
tensor_split (Optional[List[float]], default: None ) – How split tensors should be distributed across GPUs. If None, the model is not split.
tensor_split （ Optional[List[float]] ，默认值： None ） – 分割张量应如何分布在 GPU 上。如果没有，则不分割模型。
vocab_only (bool, default: False ) – Only load the vocabulary no weights.
vocab_only ( bool ，默认值： False ) – 仅加载词汇表，不加载权重。
use_mmap (bool, default: True ) – Use mmap if possible.
use_mmap （ bool ，默认值： True ） – 如果可能，使用 mmap。
use_mlock (bool, default: False ) – Force the system to keep the model in RAM.
use_mlock ( bool ，默认值： False ) – 强制系统将模型保留在 RAM 中。
seed (int, default: LLAMA_DEFAULT_SEED ) – RNG seed, -1 for random
seed ( int ，默认值： LLAMA_DEFAULT_SEED ) – RNG 种子，-1 表示随机
n_ctx (int, default: 512 ) – Text context, 0 = from model
n_ctx ( int ，默认值： 512 ) – 文本上下文，0 = 来自模型
n_batch (int, default: 512 ) – Prompt processing maximum batch size
n_batch ( int ，默认值： 512 ) – 提示处理最大批量大小
n_threads (Optional[int], default: None ) – Number of threads to use for generation
n_threads ( Optional[int] ，默认值： None ) – 用于生成的线程数
n_threads_batch (Optional[int], default: None ) – Number of threads to use for batch processing
n_threads_batch ( Optional[int] ，默认值： None ) – 用于批处理的线程数
rope_scaling_type (Optional[int], default: LLAMA_ROPE_SCALING_UNSPECIFIED ) – RoPE scaling type, from enum llama_rope_scaling_type. ref: https://github.com/ggerganov/llama.cpp/pull/2054
rope_scaling_type ( Optional[int] ，默认值： LLAMA_ROPE_SCALING_UNSPECIFIED ) – RoPE 缩放类型，来自 enum llama_rope_scaling_type 。参考：https://github.com/ggerganov/llama.cpp/pull/2054
rope_freq_base (float, default: 0.0 ) – RoPE base frequency, 0 = from model
rope_freq_base ( float ，默认值： 0.0 ) – RoPE 基本频率，0 = 来自模型
rope_freq_scale (float, default: 0.0 ) – RoPE frequency scaling factor, 0 = from model
rope_freq_scale ( float ，默认值： 0.0 ) – RoPE 频率缩放因子，0 = 来自模型
yarn_ext_factor (float, default: -1.0 ) – YaRN extrapolation mix factor, negative = from model
yarn_ext_factor ( float ，默认值： -1.0 ) – YaRN 外推混合因子，负值 = 来自模型
yarn_attn_factor (float, default: 1.0 ) – YaRN magnitude scaling factor
yarn_attn_factor ( float ，默认值： 1.0 ) – YaRN 幅度缩放因子
yarn_beta_fast (float, default: 32.0 ) – YaRN low correction dim
yarn_beta_fast ( float ，默认值： 32.0 ) – YaRN 低校正暗淡
yarn_beta_slow (float, default: 1.0 ) – YaRN high correction dim
yarn_beta_slow ( float ，默认值： 1.0 ) – YaRN 高校正暗淡
yarn_orig_ctx (int, default: 0 ) – YaRN original context size
yarn_orig_ctx ( int ，默认值： 0 ) – YaRN 原始上下文大小
f16_kv (bool, default: True ) – Use fp16 for KV cache, fp32 otherwise
f16_kv ( bool ，默认值： True ) – 使用 fp16 作为 KV 缓存，否则使用 fp32
logits_all (bool, default: False ) – Return logits for all tokens, not just the last token. Must be True for completion to return logprobs.
logits_all （ bool ，默认值： False ） – 返回所有标记的 logits，而不仅仅是最后一个标记。必须为 True 才能完成以返回 logprobs。
embedding (bool, default: False ) – Embedding mode only.
embedding （ bool ，默认值： False ） – 仅嵌入模式。
last_n_tokens_size (int, default: 64 ) – Maximum number of tokens to keep in the last_n_tokens deque.
last_n_tokens_size ( int ，默认值： 64 ) – 在last_n_tokens 双端队列中保留的最大令牌数。
lora_base (Optional[str], default: None ) – Optional path to base model, useful if using a quantized base model and you want to apply LoRA to an f16 model.
lora_base ( Optional[str] ，默认值： None ) – 基础模型的可选路径，如果使用量化基础模型并且您想要将 LoRA 应用于 f16 模型，则非常有用。
lora_path (Optional[str], default: None ) – Path to a LoRA file to apply to the model.
lora_path （ Optional[str] ，默认值： None ） – 要应用于模型的 LoRA 文件的路径。
numa (bool, default: False ) – Enable NUMA support. (NOTE: The initial value of this parameter is used for the remainder of the program as this value is set in llama_backend_init)
numa ( bool ，默认值： False ) – 启用 NUMA 支持。 （注意：该参数的初始值用于程序的其余部分，因为该值是在 llama_backend_init 中设置的）
chat_format (str, default: 'llama-2' ) – String specifying the chat format to use when calling create_chat_completion.
chat_format （ str ，默认值： 'llama-2' ） – 指定调用 create_chat_completion 时使用的聊天格式的字符串。
chat_handler (Optional[LlamaChatCompletionHandler], default: None ) – Optional chat handler to use when calling create_chat_completion.
chat_handler （ Optional[LlamaChatCompletionHandler] ，默认值： None ） – 调用 create_chat_completion 时使用的可选聊天处理程序。
verbose (bool, default: True ) – Print verbose output to stderr.
verbose ( bool ，默认值： True ) – 将详细输出打印到 stderr。


Parameters:

model_path (str) – Path to the model.
n_gpu_layers (int, default: 0 ) – Number of layers to offload to GPU (-ngl). If -1, all layers are offloaded.
main_gpu (int, default: 0 ) – The GPU that is used for scratch and small tensors.
tensor_split (Optional[List[float]], default: None ) – How split tensors should be distributed across GPUs. If None, the model is not split.
vocab_only (bool, default: False ) – Only load the vocabulary no weights.
use_mmap (bool, default: True ) – Use mmap if possible.
use_mlock (bool, default: False ) – Force the system to keep the model in RAM.
seed (int, default: LLAMA_DEFAULT_SEED ) – RNG seed, -1 for random
n_ctx (int, default: 512 ) – Text context, 0 = from model
n_batch (int, default: 512 ) – Prompt processing maximum batch size
n_threads (Optional[int], default: None ) – Number of threads to use for generation
n_threads_batch (Optional[int], default: None ) – Number of threads to use for batch processing
rope_scaling_type (Optional[int], default: LLAMA_ROPE_SCALING_UNSPECIFIED ) – RoPE scaling type, from enum llama_rope_scaling_type. ref: https://github.com/ggerganov/llama.cpp/pull/2054
rope_freq_base (float, default: 0.0 ) – RoPE base frequency, 0 = from model
rope_freq_scale (float, default: 0.0 ) – RoPE frequency scaling factor, 0 = from model
yarn_ext_factor (float, default: -1.0 ) – YaRN extrapolation mix factor, negative = from model
yarn_attn_factor (float, default: 1.0 ) – YaRN magnitude scaling factor
yarn_beta_fast (float, default: 32.0 ) – YaRN low correction dim
yarn_beta_slow (float, default: 1.0 ) – YaRN high correction dim
yarn_orig_ctx (int, default: 0 ) – YaRN original context size
f16_kv (bool, default: True ) – Use fp16 for KV cache, fp32 otherwise
logits_all (bool, default: False ) – Return logits for all tokens, not just the last token. Must be True for completion to return logprobs.
embedding (bool, default: False ) – Embedding mode only.
last_n_tokens_size (int, default: 64 ) – Maximum number of tokens to keep in the last_n_tokens deque.
lora_base (Optional[str], default: None ) – Optional path to base model, useful if using a quantized base model and you want to apply LoRA to an f16 model.
lora_path (Optional[str], default: None ) – Path to a LoRA file to apply to the model.
numa (bool, default: False ) – Enable NUMA support. (NOTE: The initial value of this parameter is used for the remainder of the program as this value is set in llama_backend_init)
chat_format (str, default: 'llama-2' ) – String specifying the chat format to use when calling create_chat_completion.
chat_handler (Optional[LlamaChatCompletionHandler], default: None ) – Optional chat handler to use when calling create_chat_completion.
verbose (bool, default: True ) – Print verbose output to stderr.