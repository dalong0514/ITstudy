# 0102. Getting Started

[Getting Started - Vagrant by HashiCorp](https://www.vagrantup.com/intro/getting-started/index.html)

The Vagrant getting started guide will walk you through your first Vagrant project, and show off the basics of the major features Vagrant has to offer.

If you are curious what benefits Vagrant has to offer, you should also read the "Why Vagrant?" page.

The getting started guide will use Vagrant with VirtualBox, since it is free, available on every major platform, and built-in to Vagrant. After reading the guide though, do not forget that Vagrant can work with many other providers.

Before diving into your first project, please install the latest version of Vagrant. And because we will be using VirtualBox as our provider for the getting started guide, please install that as well.

More of a book person? If you prefer to read a physical book, you may be interested in Vagrant: Up and Running, written by the author of Vagrant and published by O'Reilly.

»Up and Running

$ vagrant init hashicorp/bionic64

$ vagrant up

After running the above two commands, you will have a fully running virtual machine in VirtualBox running Ubuntu 18.04 LTS 64-bit. You can SSH into this machine with vagrant ssh, and when you are done playing around, you can terminate the virtual machine with vagrant destroy.

Now imagine every project you've ever worked on being this easy to set up! With Vagrant, vagrant up is all you need to work on any project, to install every dependency that project needs, and to set up any networking or synced folders, so you can continue working from the comfort of your own machine.

The rest of this guide will walk you through setting up a more complete project, covering more features of Vagrant.

»Next Steps

You have just created your first virtual environment with Vagrant. Read on to learn more about project setup.

## 01. Install Vagrant

Vagrant must first be installed on the machine you want to run it on. To make installation easy, Vagrant is distributed as a binary package for all supported platforms and architectures. This page will not cover how to compile Vagrant from source, as that is covered in the README and is only recommended for advanced users.

»Installing Vagrant

To install Vagrant, first find the appropriate package for your system and download it. Vagrant is packaged as an operating-specific package. Run the installer for your system. The installer will automatically add vagrant to your system path so that it is available in terminals. If it is not found, please try logging out and logging back in to your system (this is particularly necessary sometimes for Windows).

»Verifying the Installation

After installing Vagrant, verify the installation worked by opening a new command prompt or console, and checking that vagrant is available:

$ vagrant

Usage: vagrant [options] <command> [<args>]

    -v, --version                    Print the version and exit.

    -h, --help                       Print this help.

# ...

»Caveats

Beware of system package managers! Some operating system distributions include a vagrant package in their upstream package repos. Please do not install Vagrant in this manner. Typically these packages are missing dependencies or include very outdated versions of Vagrant. If you install via your system's package manager, it is very likely that you will experience issues. Please use the official installers on the downloads page.

## Project Setup

The first step in configuring any Vagrant project is to create a Vagrantfile. The purpose of the Vagrantfile is twofold:

Mark the root directory of your project. Many of the configuration options in Vagrant are relative to this root directory.

Describe the kind of machine and resources you need to run your project, as well as what software to install and how you want to access it.

Vagrant has a built-in command for initializing a directory for usage with Vagrant: vagrant init. For the purpose of this getting started guide, please follow along in your terminal:

$ mkdir vagrant_getting_started

$ cd vagrant_getting_started

$ vagrant init hashicorp/bionic64

This will place a Vagrantfile in your current directory. You can take a look at the Vagrantfile if you want, it is filled with comments and examples. Do not be afraid if it looks intimidating, we will modify it soon enough.

You can also run vagrant init in a pre-existing directory to set up Vagrant for an existing project.

The Vagrantfile is meant to be committed to version control with your project, if you use version control. This way, every person working with that project can benefit from Vagrant without any upfront work.

## 03. Boxes

Instead of building a virtual machine from scratch, which would be a slow and tedious process, Vagrant uses a base image to quickly clone a virtual machine. These base images are known as "boxes" in Vagrant, and specifying the box to use for your Vagrant environment is always the first step after creating a new Vagrantfile.

»Installing a Box

If you ran the commands on the getting started overview page, then you've already installed a box before, and you do not need to run the commands below again. However, it is still worth reading this section to learn more about how boxes are managed.

Boxes are added to Vagrant with vagrant box add. This stores the box under a specific name so that multiple Vagrant environments can re-use it. If you have not added a box yet, you can do so now:

$ vagrant box add hashicorp/bionic64

This will download the box named "hashicorp/bionic64" from HashiCorp's Vagrant Cloud box catalog, a place where you can find and host boxes. While it is easiest to download boxes from HashiCorp's Vagrant Cloud you can also add boxes from a local file, custom URL, etc.

Boxes are globally stored for the current user. Each project uses a box as an initial image to clone from, and never modifies the actual base image. This means that if you have two projects both using the hashicorp/bionic64 box we just added, adding files in one guest machine will have no effect on the other machine.

In the above command, you will notice that boxes are namespaced. Boxes are broken down into two parts - the username and the box name - separated by a slash. In the example above, the username is "hashicorp", and the box is "bionic64". You can also specify boxes via URLs or local file paths, but that will not be covered in the getting started guide.

Namespaces do not guarantee canonical boxes! A common misconception is that a namespace like "ubuntu" represents the canonical space for Ubuntu boxes. This is untrue. Namespaces on Vagrant Cloud behave very similarly to namespaces on GitHub, for example. Just as GitHub's support team is unable to assist with issues in someone's repository, HashiCorp's support team is unable to assist with third-party published boxes.

»Using a Box

Now that the box has been added to Vagrant, we need to configure our project to use it as a base. Open the Vagrantfile and change the contents to the following:

Vagrant.configure("2") do |config|

  config.vm.box = "hashicorp/bionic64"

end

The "hashicorp/bionic64" in this case must match the name you used to add the box above. This is how Vagrant knows what box to use. If the box was not added before, Vagrant will automatically download and add the box when it is run.

You may specify an explicit version of a box by specifying config.vm.box_version for example:

Vagrant.configure("2") do |config|

  config.vm.box = "hashicorp/bionic64"

  config.vm.box_version = "1.1.0"

end

You may also specify the URL to a box directly using config.vm.box_url:

Vagrant.configure("2") do |config|

  config.vm.box = "hashicorp/bionic64"

  config.vm.box_url = "https://vagrantcloud.com/hashicorp/bionic64"

end

In the next section, we will bring up the Vagrant environment and interact with it a little bit.

»Finding More Boxes

For the remainder of this getting started guide, we will only use the "hashicorp/bionic64" box we added previously. But soon after finishing this getting started guide, the first question you will probably have is "where do I find more boxes?"

The best place to find more boxes is HashiCorp's Vagrant Cloud box catalog. HashiCorp's Vagrant Cloud has a public directory of freely available boxes that run various platforms and technologies. HashiCorp's Vagrant Cloud also has a great search feature to allow you to find the box you care about.

In addition to finding free boxes, HashiCorp's Vagrant Cloud lets you host your own boxes, as well as private boxes if you intend on creating boxes for your own organization.

## Up And SSH

It is time to boot your first Vagrant environment. Run the following from your terminal:

$ vagrant up

In less than a minute, this command will finish and you will have a virtual machine running Ubuntu. You will not actually see anything though, since Vagrant runs the virtual machine without a UI. To prove that it is running, you can SSH into the machine:

$ vagrant ssh

This command will drop you into a full-fledged SSH session. Go ahead and interact with the machine and do whatever you want. Although it may be tempting, be careful about rm -rf /, since Vagrant shares a directory at /vagrant with the directory on the host containing your Vagrantfile, and this can delete all those files. Shared folders will be covered in the next section.

Take a moment to think what just happened: With just one line of configuration and one command in your terminal, we brought up a fully functional, SSH accessible virtual machine. Cool. The SSH session can be terminated with CTRL+D.

vagrant@bionic64:~$ logout

Connection to 127.0.0.1 closed.

When you are done fiddling around with the machine, run vagrant destroy back on your host machine, and Vagrant will terminate the use of any resources by the virtual machine.

The vagrant destroy command does not actually remove the downloaded box file. To completely remove the box file, you can use the vagrant box remove command.

