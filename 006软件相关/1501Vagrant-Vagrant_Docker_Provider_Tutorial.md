# 0201. Vagrant Docker Provider Tutorial

[Vagrant Docker Provider Tutorial | HowToProgram](https://howtoprogram.xyz/2016/07/24/vagrant-docker-provider-tutorial/)

Vagrant, a great tool for managing lifecycle of virtual machines, is not the same with Docker, another great tool for building and  running software container. In this tutorial, I’d like to introduce about Vagrant Docker Provider which allow our development environment to be backed by Docker container rather than virtual machines.

## 01. Introduction to Vagrant Docker Provider

Let’s see an overview of an environment which Vagrant and Docker can work together as following:

![](./res/2020001.png)
 
We often use Vagrant as a tool to facilitate our development environment. We may want to quickly create and provision a virtual machine. We may want to provision an virtual machine which includes all necessary development environment for a specific project and share that image with the team for reuse. Or we may want to quickly define a full stack of virtual machines with different configuration specs including number of CPU, memory, network, etc for the whole environments like Dev, QA, UAT, and Production. Vagrant is a great tool to support us to do that.

However, Vagrant doesn’t do that alone. Basically, it needs other virtualization tools with it like VirtualBox, VMware, Hyper-V, Docker, etc. Vagrant requires us to define the configuration that we need in a file called Vagrantfile. In here, we can use the unique syntax, which provided by Vagrant, to define the operating system we need like CentOS 7, Ubuntu 16.04, etc with 8 GB of memory, 2 CPUs, IP address, etc. Base on that file, Vagrant will stand in the middle, translate that file into the languages that VirtualBox, VMware, Docker can understand and then execute those translated commands.

We can call the unique syntax Vagrant Domain Specific Language (DSL), and the translation engine is Vagrant Provider. By  default, Virtualbox is the default provider of the Vagrant. Besides, there are some other official providers such as: VMware provider, Hyper-V provider, and Docker provider.

1『Vagrant Provider 是 Vagrant 与各种虚拟机（VM/containers） 之间的转换机。』

So, generally speaking, if our environment has Vagrant and any proper above virtualization tools like VirtualBox, Docker, etc installed, and we know the Vagrant DSL, it will be easy for us to manage lifecycle of our VMs and containers.

Below is an example of Vagrantfile.

```
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 9092, host: 9092
  config.vm.network "private_network", ip: "192.168.33.10"
end
```

1『把代码放进名为 Vagrantfile 的文件里。』

This is a configuration for a Ubuntu trusty 64-bit. When the VM is started, its internal port 9092 will bound the port 9092 of the host OS so that network traffic can be sent back and forward, and it will be assigned an private IP address: 192.168.33.10 in the private network of VMs.

And here are some commands to work with Vagrant and that Vagrant file.

To start VM:

    vagrant up

To see the status of the VM:

    vagrant status

To shutdown the VM

    vagrant halt

They were very basic Vagrant commands. You can refer to my previous post for more  basic Vagrant commands. Note that those commands are the same for all providers which is the same type (VirtualBox, VMware, Hyper-V are VM providers while Docker is container provider).

## 02. Basic Usage of Vagrant Docker Provider

As you may know, Docker is a type of container virtualization technology that gains a lot of attraction in recent. Docker containers created by Docker and virtual machines created by VirtualBox, VMware, Hype-V are not the same thing, but Vagrant provides us an additional way so that if we want,  we can also manage lifecycle of software containers. That’s why Vagrant Docker Provider has arrival.

The following part of the tutorial requires Vagrant and Docker to be installed in your environment. If you haven’t gotten them installed,  you can follow my previous posts:

Install Vagrant on Ubuntu 16.04 LTS (Xenial Xerus)

Install Docker on CentOS 7.X

Install Docker on Ubuntu 14.04/15.10/16.04 Step By Step

### 2.1. Basic usage with Docker images

Let’s see how a Docker container is defined in Vagrantfile.

```
Vagrant.configure("2") do |config|
  config.vm.provider "docker" do |d|
    d.image = "helloworld"
  end
end
```

The Vagrant file defined for Docker container doesn’t require config.vm.box. Rather than that, we need to define the image which is “helloword” in this example. Note that the Docker image will be pulled from the Docker hub. So, if you want any other image, you can go to the Docker hub to search for it. For example, if I want another image like: debian which is an Debian Docker, the file will be changed as following:

```
Vagrant.configure("2") do |config|
  config.vm.provider "docker" do |d|
    d.image = "debian"
  end
end
```

### 2.2. Basic usage with Docker files

If you familiar with Dockerfile which is used to build Docker image, Vagrant can build and run images based on the local Dockerfile. Let’s see an example below:

```
Vagrant.configure("2") do |config|
  config.vm.provider "docker" do |d|
    d.build_dir = "./my-docker"
  end
end
```

When we execute: vagrant up –provider=docker, Vagrant will build the Docker image based on the file ./my-docker/Dockerfile and start the container automatically.

### 2.3. Some basic commands to work with Vagrant Docker provider

Assume that we have an Apache Docker defined by Vagrantfile as following:

```
Vagrant.configure("2") do |config|
  config.vm.provider "docker" do |apache|
    apache.image = "eboraas/apache"
  end
end
```

### 2.3.1. vagrant docker-exec

The vagrant docker-exec can be used to run a new command in a running container. If the container is paused or not stopped, the command will be error.  For example, below command will create a new file /tmp/helloword inside the above apache running container , in the background.

    vagrant docker-exec -d default  -- touch /tmp/hellworld

### 2.3.2 vagrant docker-logs

This vagrant-docker-logs command is used to see the logs of the running container. For example, below is the log of the apache container.

```
vagrant docker-logs
==> default: AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message<br>
```

### 2.3.1 vagrant docker-run

This vagrant docker-run command allows us to run the command on a container. If the container is not exist, it will be created and started using the specified command. For example, the below command will start our above apache container and print “hello world” string to the console:

    vagrant docker-run -- echo "hello world"

The output is similar to:

```
==> default: Creating the container...
    default:   Name: vagrant3_default_1469382071_1469382071
    default:  Image: eboraas/apache
    default:    Cmd: echo hello world
    default: Volume: /home/ubuntu/vagrant3:/vagrant
    default:
    default: Container is starting. Output will stream in below...
    default:
    default: hello world
```

If you would like to learn more about docker command, you can refer to the Vagrant website.

## 03. Conclusion

We have learned about Vagrant Docker Provider, in a circumstance that Vagrant and Docker can work together to benefit us in facilitating the automation of our environment. If you are familiar with Vagrant in managing virtual machine and now you may want to use Docker containers instead, you can make use of Vagrant with Vagrant Docker provider.

### 扩展

[myhro/vagrant-docker: Files needed to use Vagrant with its Docker provider](https://github.com/myhro/vagrant-docker)

[rcarmo/vagrant-docker: Docker provider for Vagrant 1.1](https://github.com/rcarmo/vagrant-docker) —— 重点看

[jdeathe/vagrant-docker: Use the Vagrant Docker Provider with jdeathe/centos-ssh CentOS-6 / CentOS-7 images](https://github.com/jdeathe/vagrant-docker)

