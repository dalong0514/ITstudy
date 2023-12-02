### 部署

1、新建一个干净的虚拟环境。

conda create --name modelscope python=3.10

2、为 M3 的 Mac 单独安装 PyTorch。

pip install --pre torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/nightly/cpu

3、安装其他包。

pip install --pre torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/nightly/cpu

pip install modelscope

pip install funasr

pip install -U rotary_embedding_torch
pip install h5py