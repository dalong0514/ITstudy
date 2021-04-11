## 01. Introduction to Vagrant

[Introduction - Vagrant by HashiCorp](https://www.vagrantup.com/intro/index.html)

Vagrant is a tool for building and managing virtual machine environments in a single workflow. With an easy-to-use workflow and focus on automation, Vagrant lowers development environment setup time, increases production parity, and makes the "works on my machine" excuse a relic of the past.

If you are already familiar with the basics of Vagrant, the documentation provides a better reference build for all available features and internals.

»Why Vagrant?

Vagrant provides easy to configure, reproducible, and portable work environments built on top of industry-standard technology and controlled by a single consistent workflow to help maximize the productivity and flexibility of you and your team.

To achieve its magic, Vagrant stands on the shoulders of giants. Machines are provisioned on top of VirtualBox, VMware, AWS, or any other provider. Then, industry-standard provisioning tools such as shell scripts, Chef, or Puppet, can automatically install and configure software on the virtual machine.

»For Developers

If you are a developer, Vagrant will isolate dependencies and their configuration within a single disposable, consistent environment, without sacrificing any of the tools you are used to working with (editors, browsers, debuggers, etc.). Once you or someone else creates a single Vagrantfile, you just need to vagrant up and everything is installed and configured for you to work. Other members of your team create their development environments from the same configuration, so whether you are working on Linux, Mac OS X, or Windows, all your team members are running code in the same environment, against the same dependencies, all configured the same way. Say goodbye to "works on my machine" bugs.

»For Operators

If you are an operations engineer or DevOps engineer, Vagrant gives you a disposable environment and consistent workflow for developing and testing infrastructure management scripts. You can quickly test things like shell scripts, Chef cookbooks, Puppet modules, and more using local virtualization such as VirtualBox or VMware. Then, with the same configuration, you can test these scripts on remote clouds such as AWS or RackSpace with the same workflow. Ditch your custom scripts to recycle EC2 instances, stop juggling SSH prompts to various machines, and start using Vagrant to bring sanity to your life.

»For Designers

If you are a designer, Vagrant will automatically set everything up that is required for that web app in order for you to focus on doing what you do best: design. Once a developer configures Vagrant, you do not need to worry about how to get that app running ever again. No more bothering other developers to help you fix your environment so you can test designs. Just check out the code, vagrant up, and start designing.

»For Everyone

Vagrant is designed for everyone as the easiest and fastest way to create a virtualized environment!

## 02. Vagrant vs. Other Software

Vagrant is not the only tool to manage virtual machines and development environments. This section compares Vagrant to these other software choices.

Due to the bias of the comparisons, we attempt to only use facts. If you find something that is invalid or out of date in the comparisons, please open an issue and we'll address it as soon as possible.

Use the navigation on the left to read comparisons of Vagrant versus similar software.

### Vagrant vs. CLI Tools

Virtualization software like VirtualBox and VMware come with command line utilities for managing the lifecycle of machines on their platform. Many people make use of these utilities to write their own automation. Vagrant actually uses many of these utilities internally.

The difference between these CLI tools and Vagrant is that Vagrant builds on top of these utilities in a number of ways while still providing a consistent workflow. Vagrant supports multiple synced folder types, multiple provisioners to setup the machine, automatic SSH setup, creating HTTP tunnels into your development environment, and more. All of these can be configured using a single simple configuration file.

Vagrant still has a number of improvements over manual scripting even if you ignore all the higher-level features Vagrant provides. The command-line utilities provided by virtualization software often change each version or have subtle bugs with workarounds. Vagrant automatically detects the version, uses the correct flags, and can work around known issues. So if you're using one version of VirtualBox and a co-worker is using a different version, Vagrant will still work consistently.

For highly-specific workflows that don't change often, it can still be beneficial to maintain custom scripts. Vagrant is targeted at building development environments but some advanced users still use the CLI tools underneath to do other manual things.

Vagrant vs. Docker

Vagrant is a tool focused on providing a consistent development environment workflow across multiple operating systems. Docker is a container management that can consistently run software as long as a containerization system exists.

Containers are generally more lightweight than virtual machines, so starting and stopping containers is extremely fast. Docker uses the native containerization functionality on macOS, Linux, and Windows.

Currently, Docker lacks support for certain operating systems (such as BSD). If your target deployment is one of these operating systems, Docker will not provide the same production parity as a tool like Vagrant. Vagrant will allow you to run a Windows development environment on Mac or Linux, as well.

For microservice heavy environments, Docker can be attractive because you can easily start a single Docker VM and start many containers above that very quickly. This is a good use case for Docker. Vagrant can do this as well with the Docker provider. A primary benefit for Vagrant is a consistent workflow but there are many cases where a pure-Docker workflow does make sense.

Both Vagrant and Docker have a vast library of community-contributed "images" or "boxes" to choose from.

Vagrant vs. Terraform

Vagrant and Terraform are both projects from HashiCorp. Vagrant is a tool focused for managing development environments and Terraform is a tool for building infrastructure.

Terraform can describe complex sets of infrastructure that exist locally or remotely. It is focused on building and changing that infrastructure over time. The minimal aspects of virtual machine lifecycle can be reproduced in Terraform, sometimes leading to confusion with Vagrant.

Vagrant provides a number of higher level features that Terraform doesn't. Synced folders, automatic networking, HTTP tunneling, and more are features provided by Vagrant to ease development environment usage. Because Terraform is focused on infrastructure management and not development environments, these features are out of scope for that project.

The primary usage of Terraform is for managing remote resources in cloud providers such as AWS. Terraform is designed to be able to manage extremely large infrastructures that span multiple cloud providers. Vagrant is designed primarily for local development environments that use only a handful of virtual machines at most.

Vagrant is for development environments. Terraform is for more general infrastructure management.

