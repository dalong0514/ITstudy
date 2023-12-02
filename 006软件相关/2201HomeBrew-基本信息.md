### 01. 安装


#### 2021-11-30

问题：

Hugging Face Hub 下载模型文件，建议用 brew 先安装 git-lfs，报错。 

brew install git-lfs

报错：

Error: Cannot install in Homebrew on ARM processor in Intel default prefix (/usr/local)!
Please create a new installation in /opt/homebrew using one of the
"Alternative Installs" from:
  https://docs.brew.sh/Installation
You can migrate your previously installed formula list with:
  brew bundle dump


GPT：

根据您提供的错误信息，看起来您正在尝试在搭载M3芯片的Mac上使用Homebrew，而Homebrew尝试在其为Intel芯片默认的安装路径（/usr/local）进行安装，这是不兼容的。

Apple M1和M3芯片基于ARM架构，而Intel芯片则是x86架构。Homebrew对这两种架构有不同的安装路径要求。对于ARM架构的Mac，Homebrew应该安装在/opt/homebrew路径下。

按 GPT 的指示安装：

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

发现路径的包被墙了，然后找官网文档的链接，文档里发现可以直接下载了 mac 的 homebrew 安装包，可以装。

[Installation — Homebrew Documentation](https://docs.brew.sh/Installation)

[Release 4.1.22 · Homebrew/brew](https://github.com/Homebrew/brew/releases/tag/4.1.22)

发现还是没解决（其实根子在于环境变量没设置好，brew 的时候走的是老的路径）。因为包被墙，然后想起阳志平之前提及的清华镜像。

[homebrew | 镜像站使用帮助 | 清华大学开源软件镜像站 | Tsinghua Open Source Mirror](https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/)

按里面的内容先「替换现有仓库上游」，无法解决。

然后索性重新安装「首次安装 Homebrew」，还是无法解决。

以下是过程中的信息：

  homebrew-core is a shallow clone.
  homebrew-cask is a shallow clone.
To `brew update`, first run:
  git -C /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core fetch --unshallow
  git -C /usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask fetch --unshallow
These commands may take a few minutes to run due to the large size of the repositories.
This restriction has been made on GitHub's request because updating shallow
clones is an extremely expensive operation due to the tree layout and traffic of
Homebrew/homebrew-core and Homebrew/homebrew-cask. We don't do this for you
automatically to avoid repeatedly performing an expensive unshallow operation in
CI systems (which should instead be fixed to not use shallow clones). Sorry for
the inconvenience!


Warning: /opt/homebrew/bin is not in your PATH.
  Instructions on how to configure your shell for Homebrew
  can be found in the 'Next steps' section below.
==> Installation successful!

==> Homebrew has enabled anonymous aggregate formulae and cask analytics.
Read the analytics documentation (and how to opt-out) here:
  https://docs.brew.sh/Analytics
No analytics data has been sent yet (nor will any be during this install run).

==> Homebrew is run entirely by unpaid volunteers. Please consider donating:
  https://github.com/Homebrew/brew#donations

==> Next steps:
- Run these commands in your terminal to add the non-default Git remotes for Homebrew/brew and Homebrew/homebrew-core:
    echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /Users/Daglas/.zprofile
    echo 'export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"' >> /Users/Daglas/.zprofile
    echo 'export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"' >> /Users/Daglas/.zprofile
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
    export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
- Run brew help to get started
- Further documentation:
    https://docs.brew.sh


echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /Users/Daglas/.zprofile
echo 'export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"' >> /Users/Daglas/.zprofile
echo 'export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"' >> /Users/Daglas/.zprofile
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"

到了这里，反应过来，要设置环境变量，mac 直接快捷键「shift+command+.」可以直接显示出隐藏文件，找到 .zshrc 后直接在里面把环境变量加进去。

export PATH="/opt/homebrew/bin:$PATH"

还是无效。最后真是被自己弄服了，改了环境变量后要重新加载文件让其生效的。

source ~/.zshrc

解决。

另外：GPT 回答时，知道可以把老的 homebrew 包迁移到新位置的。

在没装新 homebrew 之前，跑：

brew bundle dump

当前路径下会生成一个 Brewfile 文件，然后跑：

brew bundle install

发现迁移安装很慢，而且卡在了某个包上，就索性先暂停了。将 Brewfile 放到了备份文件夹 dalong.backup 下，以后有需要的话再迁移。


#### 2021-01

1、安装 Xcode。

2、安装 homebrew，在终端输入命令：

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

中途安装失败的话，此时需要执行卸载操作，输入如下命令进行卸载：

```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
```

卸载完成后再次尝试安装。

3、安装 homebrew-cask，输入命令：

```
brew tap phinze/homebrew-cask && brew install brew-cask
```

命令` brew doctor` 检查 brew 是否有什么问题。

安装完后使用命令 `brew list` 可以看已经装的软件。

命令 `brew search` 软件名来查找是否可以用 brew 来装的软件。

命令 `brew install `软件名来安装软件。

命令 `brew update` 更新所有。

命令 `brew upgrade` 软件名来更新软件。

记住，可以用 brew 来装的软件一定要用 brew。

想要 brew 不自动更新的话，在 shell 里输入命令：

```
export HOMEBREW_NO_AUTO_UPDATE=true
```

想要始终执行的话，可以在用户主目录下的 shell 配置文件 .zshrc 中添加：

```
`#` brew 不自动更新
export HOMEBREW_NO_AUTO_UPDATE=true
```

### 02. 问题汇总

针对下载太慢的软件，解决方案：

可以自己先在官网里把安装文件下载后放到 brew 的缓存区里，brew 的缓存区一般是下面的路径，常规下载的时候会有显示的。

```
/Users/Daglas/Library/Caches/Homebrew/downloads
```

放进去后再 `brew install` 安装，当当与帮它省掉了下载的步骤。


