### 2023-11-12

信息源：

[使用 Github Copilot 生成单元测试并执行 - Eric zhou - 博客园](https://www.cnblogs.com/tianqing/p/17810231.html)

生成单元测试代码

首先选择整个类，然后输入以下 Prompt：

@workspace /tests 请对选中的代码，使用 MSTest 单元测试框架，生成单元测试代码，请为每个方法都实现单元测试

每次仅生成了一个方法的单元测试，可以继续使用以下 Prompt

Repeat similar tests for other methods：ConvertToMile, ConvertToFoot, ConvertToCentimeter, ConvertToKilometer, ConvertToGram, ConvertToKilogram, ConvertToWatt, ConvertToAmpere, ConvertToVolt

最终生成的 UnitTest 代码

以上单元测试代码，直接在 VS Code 右键 Run Test 即可。
