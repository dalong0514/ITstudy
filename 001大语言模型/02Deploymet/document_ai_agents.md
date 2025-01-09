### 资源

[CVxTz/document\_ai\_agents: A set of re-usable AI agent for document processing](https://github.com/CVxTz/document_ai_agents?tab=readme-ov-file)

### 问题汇总

1、找不到项目中的其他模块。

根据错误信息和代码上下文，agent_test.py 无法运行的主要原因是 Python 找不到 document_ai_agents 模块。这个问题通常是由于模块路径没有被正确添加到 Python 的模块搜索路径中。

解决方案：

\# 在项目根目录下运行
export PYTHONPATH=$(pwd):$PYTHONPATH
python document_ai_agents/agent_test.py

2、缺少 poppler 依赖。

这个错误表明系统中缺少 poppler 依赖。poppler 是一个用于处理 PDF 文件的开源库，pdf2image 库依赖它来提取 PDF 中的图像。以下是修复步骤：

解决方案：

brew install poppler

安装完成后，验证 poppler 是否已正确安装：

pdfinfo --version

3、jupyter 中启动 conda 中的 document-agent 虚拟环境。

conda install ipykernel
python3.10 -m ipykernel install --user --name=document-agent --display-name="document-agent"
jupyter notebook

查看 Jupyter 内核中有哪些虚拟环境

jupyter kernelspec list

jupyter kernelspec uninstall chatglm3-demo