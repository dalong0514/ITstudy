### 2023-12-02

看视频「20231126【官方教程】ChatGLM3-6B 部署和微调（Function Call、Code Interpreter、Agent）20231101」后的一些收获。

1、视频里的微调只是用对话（chat）的 prompt 来微调，不是我想要找的直接用数据的形式。

### 2023-12-03

1、IP 地址的卡点。

ifconfig

取 en0 里的 inet 192.168.28.58 

ifconfig
lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> mtu 16384
	options=1203<RXCSUM,TXCSUM,TXSTATUS,SW_TIMESTAMP>
	inet 127.0.0.1 netmask 0xff000000
	inet6 ::1 prefixlen 128
	inet6 fe80::1%lo0 prefixlen 64 scopeid 0x1
	nd6 options=201<PERFORMNUD,DAD>
gif0: flags=8010<POINTOPOINT,MULTICAST> mtu 1280
stf0: flags=0<> mtu 1280
anpi0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	options=400<CHANNEL_IO>
	ether c6:3f:6a:06:0c:48
	media: none
	status: inactive
anpi1: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	options=400<CHANNEL_IO>
	ether c6:3f:6a:06:0c:49
	media: none
	status: inactive
anpi2: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	options=400<CHANNEL_IO>
	ether c6:3f:6a:06:0c:4a
	media: none
	status: inactive
en4: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	options=400<CHANNEL_IO>
	ether c6:3f:6a:06:0c:28
	nd6 options=201<PERFORMNUD,DAD>
	media: none
	status: inactive
en5: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	options=400<CHANNEL_IO>
	ether c6:3f:6a:06:0c:29
	nd6 options=201<PERFORMNUD,DAD>
	media: none
	status: inactive
en6: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	options=400<CHANNEL_IO>
	ether c6:3f:6a:06:0c:2a
	nd6 options=201<PERFORMNUD,DAD>
	media: none
	status: inactive
en1: flags=8963<UP,BROADCAST,SMART,RUNNING,PROMISC,SIMPLEX,MULTICAST> mtu 1500
	options=460<TSO4,TSO6,CHANNEL_IO>
	ether 36:bb:c5:1d:9f:40
	media: autoselect <full-duplex>
	status: inactive
en2: flags=8963<UP,BROADCAST,SMART,RUNNING,PROMISC,SIMPLEX,MULTICAST> mtu 1500
	options=460<TSO4,TSO6,CHANNEL_IO>
	ether 36:bb:c5:1d:9f:44
	media: autoselect <full-duplex>
	status: inactive
en3: flags=8963<UP,BROADCAST,SMART,RUNNING,PROMISC,SIMPLEX,MULTICAST> mtu 1500
	options=460<TSO4,TSO6,CHANNEL_IO>
	ether 36:bb:c5:1d:9f:48
	media: autoselect <full-duplex>
	status: inactive
bridge0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	options=63<RXCSUM,TXCSUM,TSO4,TSO6>
	ether 36:bb:c5:1d:9f:40
	Configuration:
		id 0:0:0:0:0:0 priority 0 hellotime 0 fwddelay 0
		maxage 0 holdcnt 0 proto stp maxaddr 100 timeout 1200
		root id 0:0:0:0:0:0 priority 0 ifcost 0 port 0
		ipfilter disabled flags 0x0
	member: en1 flags=3<LEARNING,DISCOVER>
	        ifmaxaddr 0 port 10 priority 0 path cost 0
	member: en2 flags=3<LEARNING,DISCOVER>
	        ifmaxaddr 0 port 11 priority 0 path cost 0
	member: en3 flags=3<LEARNING,DISCOVER>
	        ifmaxaddr 0 port 12 priority 0 path cost 0
	nd6 options=201<PERFORMNUD,DAD>
	media: <unknown type>
	status: inactive
ap1: flags=8802<BROADCAST,SIMPLEX,MULTICAST> mtu 1500
	options=400<CHANNEL_IO>
	ether 62:3e:5f:41:b5:8b
	media: autoselect
en0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	options=6460<TSO4,TSO6,CHANNEL_IO,PARTIAL_CSUM,ZEROINVERT_CSUM>
	ether 60:3e:5f:41:b5:8b
	inet6 fe80::108b:3992:b70e:dcdf%en0 prefixlen 64 secured scopeid 0xf
	inet 192.168.28.58 netmask 0xfffffc00 broadcast 192.168.31.255
	nd6 options=201<PERFORMNUD,DAD>
	media: autoselect
	status: active
awdl0: flags=8843<UP,BROADCAST,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	options=6460<TSO4,TSO6,CHANNEL_IO,PARTIAL_CSUM,ZEROINVERT_CSUM>
	ether 46:4b:02:5e:98:27
	inet6 fe80::444b:2ff:fe5e:9827%awdl0 prefixlen 64 scopeid 0x10
	nd6 options=201<PERFORMNUD,DAD>
	media: autoselect
	status: active
llw0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
	options=400<CHANNEL_IO>
	ether 46:4b:02:5e:98:27
	inet6 fe80::444b:2ff:fe5e:9827%llw0 prefixlen 64 scopeid 0x11
	nd6 options=201<PERFORMNUD,DAD>


2、切片大小的理解。

切片大小即可以关联的上下问。切片缺大能关联的上下文就越大。

3、知识库本质是靠 prompt。

举例：


Human
你的背景知识:
"""
\### 3 火灾危险性分类
3.0.1 根据现行国家标准《建筑设计防火规范》GB 50016 的规定，生产的火灾危险性应根据生产中使用或产生的物质性质及其数量等因素划分，可分为甲、乙、丙、丁、戊类，并应符合表 3 的规定。

表 3 生产火灾危险性分类

1『

这里的表数据是参考建规里的，一模一样。（2023-10-12）

物质所属的火灾类别可以分为：甲1、甲2、甲3、甲4、乙1、乙2、乙3、丙1、丙2、丁1、丁2、戊1，等等，共计 19 个类别。以下内容是对所有类的定义。请根据定义内容判断{乙酸乙酯（CAS 号：141-78-6）}属于哪一类，并说明理由，必要时进行搜索，请一步一步来。如果匹配不出所属类别的话请回答不知道。

{
甲1：闪点小于 28℃ 的液体；

甲2：爆炸下限小于 10%（体积）的气体；

甲3：常温下能自行分解或在空气中氧化能导致迅速自燃或爆炸的物质；

甲4：常温下受到水或空气中水蒸气的作用，能产生可燃气体并引起燃烧或爆炸的物质；

甲5：遇酸、受热、撞击、摩擦、催化以及遇有机物或硫黄等易燃的无机物，极易引起燃烧或爆炸的强氧化剂；

甲6：受撞击、摩擦或与氧化剂、有机物接触时能引起燃烧或爆炸的物质；

根据上述情况，将甲类火灾危险性的液体闪点标准确定为小于 28℃；乙类，为大于或等于 28℃ 至小于 60℃；丙类，为大于或等于 60℃。

（3）火灾危险性分类中可燃气体爆炸下限的确定基准。由于绝大多数可燃气体的爆炸下限均小于 10％，一旦设备泄漏，在空气中很容易达到爆炸浓度，所以将爆炸下限小于 10％ 的气体划为甲类；少数气体的爆炸下限大于 10％，在空气中较难达到爆炸浓度，所以将爆炸下限大于或等于 10％ 的气体划为乙类。但任何一种可燃气体的火灾危险性，不仅与其爆炸下限有关，而且与其爆炸极限范围值、点火能量、混合气体的相对湿度等有关，在实际设计时要加注意。

（4）火灾危险性分类中应注意的几个问题。

1）生产的火灾危险性分类，一般要分析整个生产过程中的每个环节是否有引起火灾的可能性。生产的火灾危险性分类一般要按其中最危险的物质确定，通常可根据生产中使用的全部原材料的性质、生产中操作条件的变化是否会改变物质的性质、生产中产生的全部中间产物的性质、生产的最终产品及其副产品的性质和生产过程中的自然通风、气温、湿度等环境条件等因素分析确定。当然，要同时兼顾生产的实际使用量或产出量。

在实际中，一些产品可能有若干种不同工艺的生产方法，其中使用的原材料和生产条件也可能不尽相同，因而不同生产方法所具有的火灾危险性也可能有所差异，分类时要注意区别对待。

\### 3 火灾危险性分类
3.0.1 生产及储存物品的火灾危险性分类应符合现行国家标准《建筑设计防火规范》GB 50016 的规定。液化烃、可燃液体的火灾危险性分级应符合现行国家标准《石油化工企业设计防火标准》 GB 50160 的规定。

3.O.2 厂房或仓库内有不同火灾危险性生产或储存时，厂房或仓库的火灾危险性类别应按现行国家标准《建筑设计防火规范》GB 50016 执行。

\### 6 仓储设施
6.1 一般规定

6.1.1 可燃气体、助燃气体、液化烃和可燃液体储罐的选型、基础、罐体外保温层的设计，应符合现行国家标准《化学工业建（构） 筑物抗震设防分类标准》GB50914 和《石油化工企业设计防火标准》GB50160 的规定。

6.1.2 可燃液体、液化烃储罐（组）防火堤或隔堤的构造设计，应符合现行国家标准《储罐区防火堤设计规范》GB50351 的规定。

6.2 可燃液体储罐

6.2.1 储存沸点低于 45℃ 或在 37.8℃ 时饱和蒸气压大于 88kPa（绝压）的甲类液体，宜采用压力储罐、低压储罐或降温储存的常压储罐，储罐选型应符合现行行业标准《石油化工储运系统罐区设计规范》SH/T3007 的规定。

\### 3 厂房和仓库
\#### 3.1 火灾危险性分类
本规范根据物质的火灾危险特性，定性或定量地规定了生产和储存建筑的火灾危险性分类原则，石油化工、石油天然气、医药等有关行业还可根据实际情况进一步细化。

3.1.1 本条规定了生产的火灾危险性分类原则。

（1）表 3.1.1 中生产中使用的物质主要指所用物质为生产的主要组成部分或原材料，用量相对较多或需对其进行加工等。

（2）划分甲、乙、丙类液体闪点的基准。

为了比较切合实际地确定划分液体物质的闪点标准，本规范 1987 年版编制组曾对 596 种易燃、可燃液体的闪点进行了统计和分析，情况如下：

1）常见易燃液体的闪点多数小于 28℃；

2）国产煤油的闪点在 28~40℃ 之间；

3）国产 16 种规格的柴油闪点大多数为 60~90℃（其中仅「-35＃」柴油为 50℃）；

4）闪点在 60~120℃ 的 73 个品种的可燃液体，绝大多数火灾危险性不大；

5）常见的煤焦油闪点为 65~100℃。

据此认为：凡是在常温环境下遇火源能引起闪燃的液体属于易燃液体，可列入甲类火灾危险性范围。我国南方城市的最热月平均气温在 28℃ 左右，而厂房的设计温度在冬季一般采用 12~25℃。

3.4.5 丙、丁、戊类厂房与民用建筑的耐火等级均为一、二级时，丙、丁、戊类厂房与民用建筑的防火间距可适当减小，但应符合下列规定：

1 当较高一面外墙为无门、窗、洞口的防火墙，或比相邻较低一座建筑屋面高 15m 及以下范围内的外墙为无门、窗、洞口的防火墙时，其防火间距不限；

2 相邻较低一面外墙为防火墙，且屋顶无天窗或洞口、屋顶的耐火极限不低于 1.00h，或相邻较高一面外墙为防火墙，且墙上开口部位采取了防火措施，其防火间距可适当减小，但不应小于 4m。

3.4.6 厂房外附设化学易燃物品的设备，其外壁与相邻厂房室外附设设备的外壁或相邻厂房外墙的防火间距，不应小于本规范第 3.4.1 条的规定。用不燃材料制作的室外设备，可按一、二级耐火等级建筑确定。

总容量不大于 15m3 的丙类液体储罐，当直埋于厂房外墙外，且面向储罐一面 4.0m 范围内的外墙为防火墙时，其防火间距不限。

3.4.7 同一座「U」形或「山」形厂房中相邻两翼之间的防火间距，不宜小于本规范第 3.4.1 条的规定，但当厂房的占地面积小于本规范第 3.3.1 条规定的每个防火分区最大允许建筑面积时，其防火间距可为 6m。

"""
对话要求：
1. 背景知识是最新的实时的信息，使用背景知识回答问题。
2. 优先使用背景知识的内容回答我的问题，答案应与背景知识严格一致。
3. 背景知识无法回答我的问题时，可以忽略背景知识，根据你的知识来自由回答。
4. 使用对话的风格，自然的回答问题。包含markdown内容，需按markdown格式返回。
我的问题是:"你是一位中国国内著名化工工程师专家，在工程设计行业中拥有丰富的设计经验。我想让你担任指导老师，指导我在工程设计过程中遇到的一系列问题。我的第一个问题是：甲类厂房设计中防火分区怎么划分"


### 2023-12-11

1、pytorch 包是有 cpu 版和 gpu 版的。mac 还有独有的 night 版本，之前自己部署时的一个注意点。

来自 ChatGLM 交流群里的信息：

FLocK 2023/12/11 22:24

nvidia-smi 看显存有没有占用。有利用那就是用 gpu 了

剑月琴心 2023/12/11 22:25

你的 pytorch CPU 版本

剑月琴心 2023/12/11 22:25

你看看

FLocK 2023/12/11 22:29

torch.cuda.is_available()

北冥有鱼 2023/12/11 22:31

你这 torch 装的好像不对

北冥有鱼 2023/12/11 22:31

你应该装 cuda 的

北冥有鱼 2023/12/11 22:32

torch.cuda.is_available()

输入这个

看看是不是 false

陈泽营 2023/12/11 22:32

是的

FLocK 2023/12/11 22:32

卸了重装吧

北冥有鱼 2023/12/11 22:32

重装 torch 叭

下载个 cuda 版本的

陈泽营 2023/12/11 22:46

这次应该装对了

再次启动！！！
