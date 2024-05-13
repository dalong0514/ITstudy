## Rust安装相关

[rustup.rs - The Rust toolchain installer](https://rustup.rs/)

### 安装过程记录

➜  ~ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
info: downloading installer

Welcome to Rust!

This will download and install the official compiler for the Rust
programming language, and its package manager, Cargo.

Rustup metadata and toolchains will be installed into the Rustup
home directory, located at:

  /Users/Daglas/.rustup

This can be modified with the RUSTUP_HOME environment variable.

The Cargo home directory is located at:

  /Users/Daglas/.cargo

This can be modified with the CARGO_HOME environment variable.

The cargo, rustc, rustup and other commands will be added to
Cargo's bin directory, located at:

  /Users/Daglas/.cargo/bin

This path will then be added to your PATH environment variable by
modifying the profile files located at:

  /Users/Daglas/.profile
  /Users/Daglas/.bash_profile
  /Users/Daglas/.zshenv

You can uninstall at any time with rustup self uninstall and
these changes will be reverted.

Current installation options:


   default host triple: aarch64-apple-darwin
     default toolchain: stable (default)
               profile: default
  modify PATH variable: yes
1) Proceed with standard installation (default - just press enter)
2) Customize installation
3) Cancel installation

---


  stable-aarch64-apple-darwin installed - rustc 1.77.1 (7cf61ebde 2024-03-27)


Rust is installed now. Great!

To get started you may need to restart your current shell.
This would reload your PATH environment variable to include
Cargo's bin directory ($HOME/.cargo/bin).

To configure your current shell, you need to source
the corresponding env file under $HOME/.cargo.

This is usually done by running one of the following (note the leading DOT):
. "$HOME/.cargo/env"            # For sh/bash/zsh/ash/dash/pdksh
source "$HOME/.cargo/env.fish"  # For fish

补充：

shell 里直接输入如下命令激活：

. "$HOME/.cargo/env"

测试是否安装好了的话：

cargo --version

rustc --version

rustdoc --version