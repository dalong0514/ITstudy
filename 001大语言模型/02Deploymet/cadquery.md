### 01. 信息资源

[CadQuery/cadquery: A python parametric CAD scripting framework based on OCCT](https://github.com/CadQuery/cadquery?tab=readme-ov-file)

[CadQuery/CQ-editor: CadQuery GUI editor based on PyQT](https://github.com/CadQuery/CQ-editor)

[QuickStart — CadQuery Documentation](https://cadquery.readthedocs.io/en/latest/quickstart.html)

### 02. 运行跑的记录




### 03. 安装部署记录

CONDA_SUBDIR=osx-arm64 conda create --name cadquery python=3.10

pip install cadquery

### 03. 问题汇总

2024-09-04

1、不支持 mac 的 arm 芯片。

直接跑的时候发现缺少三方库 ocp，用 pip 安装 ocp 提示 m 芯片不支持。

然后想着在 win 电脑上直接安装 cadquery 客户端，GitHub 上建一个代码仓库，先自己的 mac 上写代码调试，再同步到 win 上显示看效果，这个工作流可以接受。

接着方向直接安装 mac 版客户端也可以运行，这样就更方便了。
