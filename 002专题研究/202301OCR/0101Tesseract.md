## 01. Tesseract 汇总

2023-09-26

目前的识别效果不好，应该是因为没有进行专项训练。需要找训练数据集相关的资料实践。

tesseract images/eurotext.png - -l eng+chi_sim

tesseract /Users/Daglas/Desktop//eurotext.png stdout -l eng+chi_sim

### 资源

GitHub 仓库地址：

[tesseract-ocr/tesseract: Tesseract Open Source OCR Engine (main repository)](https://github.com/tesseract-ocr/tesseract)

安装的说明：

[Compilation guide for various platforms | tessdoc](https://tesseract-ocr.github.io/tessdoc/Compiling.html#macos)

支持语言汇总：

[Languages/Scripts supported in different versions of Tesseract | tessdoc](https://tesseract-ocr.github.io/tessdoc/Data-Files-in-different-versions.html)

常用操作：

[Command Line Usage | tessdoc](https://tesseract-ocr.github.io/tessdoc/Command-Line-Usage.html#simplest-invocation-to-ocr-an-image)

训练数据：

[tesseract-ocr/tessdata: Trained models with fast variant of the "best" LSTM models + legacy models](https://github.com/tesseract-ocr/tessdata)

训练相关：

[tesseract-ocr使用以及训练方法\_python\_脚本之家](https://www.jb51.net/article/281575.htm)

### 问题汇总

1、安装依赖包时不少装不上。

基本上是靠 GPT 解决的。

2、安装训练数据。

eng.traineddata/chi_sim.traineddata

把训练的数据手动下载下来，放到路径：

/usr/local/share/tessdata/ 目录下。

3、设置 TESSDATA_PREFIX。

你需要确保 Tesseract 知道去哪里查找训练数据。你可以设置一个环境变量来实现这一点：

export TESSDATA_PREFIX=/usr/local/share/tessdata/

如果这解决了问题，并且你希望永久保留此设置，可以将上述命令添加到 ~/.zshrc 文件（如果你使用的是 zsh，这是 macOS 默认的 shell）或 ~/.bash_profile （如果你使用的是 bash）。

