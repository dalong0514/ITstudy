# 0605. 策略模式 1：如何避免冗长的 if-else/switch 分支判断代码？

王争 2020-03-20

上两节课中，我们学习了模板模式。模板模式主要起到代码复用和扩展的作用。除此之外，我们还讲到了回调，它跟模板模式的作用类似，但使用起来更加灵活。它们之间的主要区别在于代码实现，模板模式基于继承来实现，回调基于组合来实现。

今天，我们开始学习另外一种行为型模式，策略模式。在实际的项目开发中，这个模式也比较常用。最常见的应用场景是，利用它来避免冗长的 if-else 或 switch 分支判断。不过，它的作用还不止如此。它也可以像模板模式那样，提供框架的扩展点等等。

对于策略模式，我们分两节课来讲解。今天，我们讲解策略模式的原理和实现，以及如何用它来避免分支判断逻辑。下一节课，我会通过一个具体的例子，来详细讲解策略模式的应用场景以及真正的设计意图。

话不多说，让我们正式开始今天的学习吧！

策略模式的原理与实现

策略模式，英文全称是 Strategy Design Pattern。在 GoF 的《设计模式》一书中，它是这样定义的：

Define a family of algorithms, encapsulate each one, and make them interchangeable. Strategy lets the algorithm vary independently from clients that use it.


翻译成中文就是：定义一族算法类，将每个算法分别封装起来，让它们可以互相替换。策略模式可以使算法的变化独立于使用它们的客户端（这里的客户端代指使用算法的代码）。

我们知道，工厂模式是解耦对象的创建和使用，观察者模式是解耦观察者和被观察者。策略模式跟两者类似，也能起到解耦的作用，不过，它解耦的是策略的定义、创建、使用这三部分。接下来，我就详细讲讲一个完整的策略模式应该包含的这三个部分。

1. 策略的定义

策略类的定义比较简单，包含一个策略接口和一组实现这个接口的策略类。因为所有的策略类都实现相同的接口，所以，客户端代码基于接口而非实现编程，可以灵活地替换不同的策略。示例代码如下所示：

public interface Strategy {


  void algorithmInterface();


}


public class ConcreteStrategyA implements Strategy {


  @Override


  public void  algorithmInterface() {


// 具体的算法...

  }


}


public class ConcreteStrategyB implements Strategy {


  @Override


  public void  algorithmInterface() {


// 具体的算法...

  }


}


2. 策略的创建

因为策略模式会包含一组策略，在使用它们的时候，一般会通过类型（type）来判断创建哪个策略来使用。为了封装创建逻辑，我们需要对客户端代码屏蔽创建细节。我们可以把根据 type 创建策略的逻辑抽离出来，放到工厂类中。示例代码如下所示：

public class StrategyFactory {


  private static final Map<String, Strategy> strategies = new HashMap<>();


  static {


    strategies.put("A", new ConcreteStrategyA());


    strategies.put("B", new ConcreteStrategyB());


  }


  public static Strategy getStrategy(String type) {


    if (type == null || type.isEmpty()) {


      throw new IllegalArgumentException("type should not be empty.");


    }


    return strategies.get(type);


  }


}


一般来讲，如果策略类是无状态的，不包含成员变量，只是纯粹的算法实现，这样的策略对象是可以被共享使用的，不需要在每次调用 getStrategy () 的时候，都创建一个新的策略对象。针对这种情况，我们可以使用上面这种工厂类的实现方式，事先创建好每个策略对象，缓存到工厂类中，用的时候直接返回。

相反，如果策略类是有状态的，根据业务场景的需要，我们希望每次从工厂方法中，获得的都是新创建的策略对象，而不是缓存好可共享的策略对象，那我们就需要按照如下方式来实现策略工厂类。

public class StrategyFactory {


  public static Strategy getStrategy(String type) {


    if (type == null || type.isEmpty()) {


      throw new IllegalArgumentException("type should not be empty.");


    }


    if (type.equals("A")) {


      return new ConcreteStrategyA();


    } else if (type.equals("B")) {


      return new ConcreteStrategyB();


    }


    return null;


  }


}


3. 策略的使用

刚刚讲了策略的定义和创建，现在，我们再来看一下，策略的使用。

我们知道，策略模式包含一组可选策略，客户端代码一般如何确定使用哪个策略呢？最常见的是运行时动态确定使用哪种策略，这也是策略模式最典型的应用场景。

这里的「运行时动态」指的是，我们事先并不知道会使用哪个策略，而是在程序运行期间，根据配置、用户输入、计算结果等这些不确定因素，动态决定使用哪种策略。接下来，我们通过一个例子来解释一下。

// 策略接口：EvictionStrategy

// 策略类：LruEvictionStrategy、FifoEvictionStrategy、LfuEvictionStrategy...

// 策略工厂：EvictionStrategyFactory

public class UserCache {


  private Map<String, User> cacheData = new HashMap<>();


  private EvictionStrategy eviction;


  public UserCache(EvictionStrategy eviction) {


    this.eviction = eviction;


  }


  //...


}


// 运行时动态确定，根据配置文件的配置决定使用哪种策略

public class Application {


  public static void main(String[] args) throws Exception {


    EvictionStrategy evictionStrategy = null;


    Properties props = new Properties();


    props.load(new FileInputStream("./config.properties"));


    String type = props.getProperty("eviction_type");


    evictionStrategy = EvictionStrategyFactory.getEvictionStrategy(type);


    UserCache userCache = new UserCache(evictionStrategy);


    //...


  }


}


// 非运行时动态确定，在代码中指定使用哪种策略

public class Application {


  public static void main(String[] args) {


    //...


    EvictionStrategy evictionStrategy = new LruEvictionStrategy();


    UserCache userCache = new UserCache(evictionStrategy);


    //...


  }


}


从上面的代码中，我们也可以看出，「非运行时动态确定」，也就是第二个 Application 中的使用方式，并不能发挥策略模式的优势。在这种应用场景下，策略模式实际上退化成了「面向对象的多态特性」或「基于接口而非实现编程原则」。

如何利用策略模式避免分支判断？

实际上，能够移除分支判断逻辑的模式不仅仅有策略模式，后面我们要讲的状态模式也可以。对于使用哪种模式，具体还要看应用场景来定。策略模式适用于根据不同类型的动态，决定使用哪种策略这样一种应用场景。

我们先通过一个例子来看下，if-else 或 switch-case 分支判断逻辑是如何产生的。具体的代码如下所示。在这个例子中，我们没有使用策略模式，而是将策略的定义、创建、使用直接耦合在一起。

public class OrderService {


  public double discount(Order order) {


    double discount = 0.0;


    OrderType type = order.getType();


if (type.equals (OrderType.NORMAL)) { // 普通订单

//... 省略折扣计算算法代码

} else if (type.equals (OrderType.GROUPON)) { // 团购订单

//... 省略折扣计算算法代码

} else if (type.equals (OrderType.PROMOTION)) { // 促销订单

//... 省略折扣计算算法代码

    }


    return discount;


  }


}


如何来移除掉分支判断逻辑呢？那策略模式就派上用场了。我们使用策略模式对上面的代码重构，将不同类型订单的打折策略设计成策略类，并由工厂类来负责创建策略对象。具体的代码如下所示：

// 策略的定义

public interface DiscountStrategy {


  double calDiscount(Order order);


}


// 省略 NormalDiscountStrategy、GrouponDiscountStrategy、PromotionDiscountStrategy 类代码...

// 策略的创建

public class DiscountStrategyFactory {


  private static final Map<OrderType, DiscountStrategy> strategies = new HashMap<>();


  static {


    strategies.put(OrderType.NORMAL, new NormalDiscountStrategy());


    strategies.put(OrderType.GROUPON, new GrouponDiscountStrategy());


    strategies.put(OrderType.PROMOTION, new PromotionDiscountStrategy());


  }


  public static DiscountStrategy getDiscountStrategy(OrderType type) {


    return strategies.get(type);


  }


}


// 策略的使用

public class OrderService {


  public double discount(Order order) {


    OrderType type = order.getType();


    DiscountStrategy discountStrategy = DiscountStrategyFactory.getDiscountStrategy(type);


    return discountStrategy.calDiscount(order);


  }


}


重构之后的代码就没有了 if-else 分支判断语句了。实际上，这得益于策略工厂类。在工厂类中，我们用 Map 来缓存策略，根据 type 直接从 Map 中获取对应的策略，从而避免 if-else 分支判断逻辑。等后面讲到使用状态模式来避免分支判断逻辑的时候，你会发现，它们使用的是同样的套路。本质上都是借助「查表法」，根据 type 查表（代码中的 strategies 就是表）替代根据 type 分支判断。

但是，如果业务场景需要每次都创建不同的策略对象，我们就要用另外一种工厂类的实现方式了。具体的代码如下所示：

public class DiscountStrategyFactory {


  public static DiscountStrategy getDiscountStrategy(OrderType type) {


    if (type == null) {


      throw new IllegalArgumentException("Type should not be null.");


    }


    if (type.equals(OrderType.NORMAL)) {


      return new NormalDiscountStrategy();


    } else if (type.equals(OrderType.GROUPON)) {


      return new GrouponDiscountStrategy();


    } else if (type.equals(OrderType.PROMOTION)) {


      return new PromotionDiscountStrategy();


    }


    return null;


  }


}


这种实现方式相当于把原来的 if-else 分支逻辑，从 OrderService 类中转移到了工厂类中，实际上并没有真正将它移除。关于这个问题如何解决，我今天先暂时卖个关子。你可以在留言区说说你的想法，我在下一节课中再讲解。

重点回顾

好了，今天的内容到此就讲完了。我们一块来总结回顾一下，你需要重点掌握的内容。

策略模式定义一族算法类，将每个算法分别封装起来，让它们可以互相替换。策略模式可以使算法的变化独立于使用它们的客户端（这里的客户端代指使用算法的代码）。

策略模式用来解耦策略的定义、创建、使用。实际上，一个完整的策略模式就是由这三个部分组成的。

策略类的定义比较简单，包含一个策略接口和一组实现这个接口的策略类。

策略的创建由工厂类来完成，封装策略创建的细节。

策略模式包含一组策略可选，客户端代码如何选择使用哪个策略，有两种确定方法：编译时静态确定和运行时动态确定。其中，「运行时动态确定」才是策略模式最典型的应用场景。

除此之外，我们还可以通过策略模式来移除 if-else 分支判断。实际上，这得益于策略工厂类，更本质上点讲，是借助「查表法」，根据 type 查表替代根据 type 分支判断。

课堂讨论

今天我们讲到，在策略工厂类中，如果每次都要返回新的策略对象，我们还是需要在工厂类中编写 if-else 分支判断逻辑，那这个问题该如何解决呢？

欢迎留言和我分享你的想法。如果有收获，也欢迎你把这篇文章分享给你的朋友。

将学到的知识总结成笔记，方便日后快速查找及复习

unpreview


© 版权归极客邦科技所有，未经许可不得传播售卖。页面已增加防盗追踪，如有侵权极客邦将依法追究其法律责任。

大龙

由作者筛选后的优质留言将会公开显示，欢迎踊跃留言。

Command + Enter 发表

0/2000 字

提交留言

精选留言 (75)

宁锟

仍然可以用查表法，只不过存储的不再是实例，而是 class，使用时获取对应的 class，再通过反射创建实例

2020-03-20


下雨天

策略模式和工厂模式区别：

工厂模式

1. 目的是创建不同且相关的对象

2. 侧重于 "创建对象"

3. 实现方式上可以通过父类或者接口

4. 一般创建对象应该是现实世界中某种事物的映射，有它自己的属性与方法！

策略模式

1. 目的实现方便地替换不同的算法类

2. 侧重于算法 (行为) 实现

3. 实现主要通过接口

4. 创建对象对行为的抽象而非对对象的抽象，很可能没有属于自己的属性。

2020-03-20


攻城拔寨

策略模式通常跟工厂一起配合使用。

策略侧重如何灵活选择替换，

工厂侧重怎么创建实例

2020-03-20


Michael


一般而言 Java web 开发中我们均使用 spring 框架，可以使用运行时自定义注解给具体的策略类打上注解，将具体的策略类放于 spring 容器中，工厂中注入直接根据类型获取即可。不实用 spring 框架的话，也可以用 Java 的反射做到获取到具体的策略类

2020-03-20


Jasongrass


if else 不是必须要解决的问题，如果放在工厂类中，逻辑比较简单，未来的变动也不会很大，就是 OK 的。

2020-03-23


zhengyu.nie


查表策略还是挺常见的，搭配 java.util.function 各种接口挺好用的。

    private final Map<String, Function<String, String>> PHONE_FUN_FACTORY =


        ImmutableMap.of(


            MessageDestination.LEGAL_PERSON.name(), legalPersonPhoneFunc(),


            MessageDestination.ACTUAL_CONTROL.name(), actualPersonPhoneFunc()


        );


我比较喜欢建一个 StrategyContext 类，简单工厂 + 策略模式。

Context 类存在一个成员变量 xxx，new StrategyContext (xxx).apply ();

然后 StrategyContext 内部存放一个表，value 是一堆 function，通过成员变量查表找对应的 func.apply 即可

2020-05-06


Geek_3231cf


可以在策略接口中，再抽象出来一个 bool switch (T condition) 方法，将判断移至具体策略实现类

工厂中 getDiscountStrategy () 方法中拿到所有策略类，根据 condition 找到符合的策略

伪代码：

DiscountStrategy getDiscountStrategy(T condition)


{


allStartegys.foreach(


if(switch(condition)


return thisStartegy;


))}


使用起来就是 DiscountStrategyFactory.getDiscountStrategy (condition).discount (order);

2020-03-20


每天晒白牙

我们的项目就使用了这种动态的策略模式，减少 if-else

2020-03-20


Jxin


1. 业务代码少用反射。这个场景和原型模式的应用场景很贴合。依旧是 type 查表，只是每次使用的都是 type 对应策略实例的 copy 对象。详细请参照 spring 原型模式的实现。

2. 往往业务场景里面，往往不是选择策略这一场景，而是编排策略这一场景。即利用 type 查表拿出一堆要用到的策略，并按顺序去执行。对于这种场景，栏主怎么看？

2020-03-20


Ken 张云忠

实际上，今天举的例子不用访问者模式也可以搞定，你能够想到其他实现思路吗？

可以使用策略模式.

定义读取策略接口 ExtractorStrategy 并实现三个策略，再定义一个策略工厂类，以文件类型作为 key, 以对应策略实现作为 value, 使用时通过具体的 ResourceFile 类型获取对应的策略实现类型，然后再调用实现函数.

2020-04-08


test


用查表法缓存 clasa

2020-03-20


峰

就像老师说的，替换麻烦的 ifelse 本质上靠的是查表法，也就是 if 里的条件成立绑定对应的方法地址，所以其实感觉和策略模式本身没有半毛钱关系，只不过在策略模式这个上下文下，每个条件分支是可扩展的策略实现而不是差别很大的功能代码。

2020-03-20


Luke


想到的一个「策略模式」使用场景是：根据数据查看权限进行列表筛选。

比如，数据表中有三类数据:

- 分类 A

- 分类 B

- 分类 C

针对这三类数据，是提供给不同角色的人员查看:

- 角色 1

- 角色 2

- 角色 3

通过策略对数据进行筛选，分别是:

- 「角色 1」对应 「分类 A」数据

- 「角色 2」对应 「分类 B」数据

- 「角色 3」对应 「分类 C」数据

不知道这种方式是否是符合「策略模式」的使用场景。是否还有更好的方式来解耦人员和数据的关系呢？

2020-04-20


东征

仍然使用查表法，表中存类型和 class，根据类型获取对象时，使用 class 动态创建。或者表中存类型和一个创建函数，根据类型获取对象时，获取到创建函数，调用创建函数创建新对象（java 里可以用 lambda 或者对象代替函数）

2020-04-03


kingcall


工厂模式和策略模式有类似的流程，就是对象的创建，但是使用场景是不同的，策略模式的场景是行为切换，而工厂模式是对象创建；或者说是策略模式中使用到了工厂模式

2020-04-02


岁月

课堂讨论

字典里保存好创建新对象的闭包代码块即可，或者说是回调函数，这样就可以创建出新的对象了，我们项目就是用的这个方法

2020-04-01


梦倚栏杆

课后问题回答：

在 springboot 框架下很容易实现。

private final List<DiscountStrategy> strategyList;


spring 的特性会自动将所有的 DiscountStrategy 实现类注入到 strategyList，

然后 strategyList.stream ().filter (DiscountStrategy::match).findFirst ().map (ApplicatonContext::getBean).orElseThrow (()->new Exception ("找不到合适的策略"));

将每一个 DiscountStrategy 的实现类的 scope 注解设置为原型模式。

不过这样两个缺点：

1. 每一个策略类都会先创建一个对象，作用仅仅是为了可以调用 match 方法。

2. 像这种每一个都需要一个新的 bean 场景，一般这种策略也依赖当时的场景参数，但是当时的场景参数却无法通过构造函数传达，只能作为方法的参数

2020-03-29


Michael


我觉得结合下 Spring 中的应用场景讲下，毕竟大家都是依赖 Spring 开发的

2020-03-22


Frank


打卡 今日学习策略模式，收获如下：

策略模式，理解有多种策略可供使用，怎么使用。文章中提到三部分：策略的定义，策略的创建，策略的使用。定义：需要定义策略接口和一组实现类，使用基于接口而非实现编程可灵活替换不同的类，各个实现类可独立变化。创建： 创建策略类时，为了封装创建细节，

使用简单工厂方法。根据策略类状态特性（可变类与不可变类）来判断是使用可缓存的，还是每次都返回新的。使用：基于两种方式：运行时动态确定和编译时静态确定，前者使用灵活，外界可灵活介入，后者硬编码，存在一定维护成本。

课堂讨论中的问题可通过工厂方法即将不同的折扣策略计算对象的创建在拆分出来形成一个个小工厂，在小工厂里创建折扣策略对象，然后再使用简单工厂模式里面的第二种方式缓存这些小工厂，使用的时候根据类型返回小工厂，进而通过小工厂拿到相应的折扣策略对象。

2020-03-21


守拙

课堂讨论：使用反射 + 静态工厂方式实现.

public class ReflectFactory {


    private static final String TAG = "ReflectFactory";


    private ReflectFactory(){


        throw new IllegalStateException("");


    }


    public static DiscountStrategy getStrategy(Class<?> clazz){


        try {


            Constructor<?> constructor = clazz.getDeclaredConstructor();


            constructor.setAccessible(true);


            return (DiscountStrategy) constructor.newInstance();


        } catch (NoSuchMethodException e) {


            e.printStackTrace();


        } catch (IllegalAccessException e) {


            e.printStackTrace();


        } catch (InstantiationException e) {


            e.printStackTrace();


        } catch (InvocationTargetException e) {


            e.printStackTrace();


        }


        throw new IllegalArgumentException(" class type error! ");


    }


}


public class Test {


    public static void main(String[] args) {


        double value = ReflectFactory.getStrategy(NormalStrategy.class).cal();


        System.out.println(" discount: " + value);


    }


}


2020-03-20


Michael


王老师，若是决定具体策略类的条件不是一个简单的 type，而是多个条件决定一个具体的策略，如何处理？比如 A 和 B 有四种组合的这种

2020-03-20


echoogai


1. 可以用类前缀方式，用反射加载实例：例如 AtypeStrategy、BtypeStrategy，使用时出入 Atype 或 Btype，分别对应 AtypeStrategy 和 BtypeStrategy

2. 用 map 做映射，key 是 Atype、Btype，对应的是 AtypeStrategy、BtypeStrategy 的类，反射加载创建对象。

2020-08-05


Geek_jackli


有点类似 C 语言的函数指针数组，索引即是类型

2020-08-03


改名不换人

请问各位一个问题：如果在 spring 应用中，Map 策略表中的对象应该是 new 创建的，还是用 autowired 注入？

作者回复：要是自己 new 的，spring 容器是不管理的，也就是你在其他地方无法自动注入

2020-07-30


aoe


原来策略模式的精髓就是：用 Map 代替冗长的 if-else/switch 分支判断！

哇！

2020-07-28


Geek3340


我一般是在启动的时候，获取 interface 下所有的实现类，缓冲在 map 中，key 为可以处理的策略类型，value 为实现类对象

2020-07-28


lengrongfu


问题的一些思考：

如果是 spring 项目的话会比较简单，对于注入对象是指点对象的生命周期为 prototype 类型即可。

2020-07-18


我很皮信不信

通过配置文件配置映射关系加载到内存

2020-07-08


面向百度编程

今天我们讲到，在策略工厂类中，如果每次都要返回新的策略对象，我们还是需要在工厂类中编写 if-else 分支判断逻辑，那这个问题该如何解决呢？

那就将依赖工厂改为依赖接口，维护一个上下文对象，通过传入特定的算法对象处理业务

2020-05-04


丁丁历险记

用好反射。

2020-05-04


卖火柴的托儿索

这个策略和多态有什么区别？感觉用法差不多

作者回复：完全两个东西 一个是模式 一个是技术 一个侧重应用场景 一个侧重代码实现

2020-04-26


ttxser


工厂模式里的 if-else 没有必要考虑如何去掉，已经上层封装了；

查表，或者也可以考虑 type 使用枚举，实现 abstract getInstance () 方法

2020-04-15


传说中的成大大

关于思考题 还是可以用 map 缓存类型和创建过程之间的映射关系啊

2020-04-07


星期八

每次创建的新的实例，还是查表法，表里可以放（类型，class）获取时根据类型找 class，反射创建实例

2020-04-02


酱油党

既然策略模式可以搞定，创建工厂再策略一次就可以了，有点绕

2020-03-29


李小四

设计模式_61:

# 作业

1. 用过，就是为了解决 if-else 的问题，记得当时是刚看完 * HeadFirst 设计模式 * 的策略模式，可能有点过度设计了，毕竟拿着锤子看什么都像钉子。。。

2. 什么时候有必要去掉 if-else/switch-case，可以从信息量的角度来理解，如果这个信息有重复 (好多地方都硬编码地使用 if-else 来表示映射表信息)，这个时候就有必要去掉 if-else/switch-case 了。如果整个项目只有当前方法保存了这个映射表，而且变化可能不大，也可以保留。

# 感想

策略模式其实是对某一可变行为的抽象。

2020-03-29


李小四

设计模式_60:

# 作业

如果是 Java，可以在表中存储 type 与 class 的映射关系。

# 感想

今天的内容有一个感受，我们为什么想要避免 if-else/switch？

从信息量的角度分析一下：

一个业务函数中如果涉及多个 if-else/switch，那么该函数包含了两个信息：

(1) 业务的运行逻辑

(2) 每一个 type 与 implement 的映射关系

这一点已经违反了单一职责原则，业务函数最好只包含业务逻辑。另外，type 与 implement 的映射关系这个信息 (查表法的 "表") 通常不会只在这里出现，如果多个地方出现又会导致更新遗漏的问题，所以避免 if-else/switch 除了可以让代码看起来舒服，也可以减少不必要的信息量 (所谓解耦)，让代码易读且可扩展。

2020-03-29


弹簧人

这种情况还比较常见。比如某一个业务场景有多种情况，有时候就会 if/else 多个。每种情况包一个方法。这样看起来简洁，但是有时候会出现很多类似的代码逻辑，并且整个 service 类会很长。

使用策略方法的话，可以申明成不同的策略类，然后调用。减少代码量。但是如果，分情况的代码范围不长，分成多个类又过于臃肿了。个人感觉视情况而定。

2020-03-29


FIGNT


将每个策略类的创建放到单独的工厂里，Map 的 value 保存的是工厂，而不是对象。这样使用同一个对象还是不同的对象，只需要修改工厂。

2020-03-29


梦倚栏杆

感觉从代码层面来看，工厂模式和策略模式没有什么区别，只是人在解释的时候或者人的着眼点在对象 or 一种行为能力的问题。真正到实际开发时，估计不好区分使用的是策略模式还是工厂模式。如果按照从业务需求角度来说，可能是策略模式吧。

另外我难道是学习偏了，没有人觉得策略模式和前面讲的装饰器模式有点像吗？不同策略的一个是自己定义的统一接口，一个需要转换包装一下不同的第三方为统一接口。然后根据场景的不同做不同的选择

2020-03-29


悠游

老师，我在实际开发中遇到一个问题，就是每一个策略的 type 有很多，或者说满足一定规则的 type 使用一个策略，这种除了为每个 type 创建一个 Entry，还有没有更好的办法呢

2020-03-28


悠游

还是用 Map 来缓存策略，只不过缓存的是类对象而不是类实例，根据 type 拿到类对象，再根据反射创建类对象实例

2020-03-28


石头

简单却很实用的模式

2020-03-28


mghio


项目最近重构也使用策略模式的动态绑定方式，去除了大部分冗长的 if else 代码

2020-03-27


嘻哈

工厂的工厂可以解决

2020-03-26


Geek_54edc1


思考题，「工厂的工厂」，对每个策略类都建立相应的工厂类，根据 type 查表得到工厂类，通过工厂类来创建新的策略对象。

2020-03-24


Bern


可以使用枚举

2020-03-24


辣么大

对于课后思考题，可以使用反射实现。对于各个策略类，可以是用表记录。

也在思考一个问题，对于争哥举的购物的例子，如果现实情况并非单一策略，而是不同策略的组合呢？例如我既满足满减同时也能使用优惠券呢？这种情况简单的解决方法就是再定一个新策略。至于策略组合爆炸的问题，显然不是所有策略的组合现实中都是合理的。

2020-03-24


葛强强

使用动态工厂模式，即通过反射创建。

2020-03-23


hetiu


课后题：用工厂的工厂可以解决。不过，查表的方式，不见得就比 switch/case 优雅多少！

2020-03-22


韵呀

查表法，value 值存 class，用反射创建。

策略类也可以继承一个抽象类吧，不一定是接口。策略类的一些公共处理可以放在抽象类里

2020-03-22


大张伟

可用 Spring 的 applicationContext.getBeansOfType (Interface.class);

2020-03-22


L🚲🐱


策略模式可以有效的解决 if else 过多的问题，用 map 存放 具体的策略，运行时生成对应的策略

2020-03-22


相逢是缘

一、定义（理解）：

定义一族算法类，将每个算法分别封装起来，让它们可以互相替换。策略模式可以使算法的变化独立于使用它们的客户端（这里的客户端代指使用算法的代码）。

二、使用场景：

需要根据情况使用不同的算法类。

三、实现方式：

1、策略类的定义比较简单，包含一个策略接口和一组实现这个接口的策略类。

2、策略的创建由工厂类来完成，封装策略创建的细节。

3、策略模式包含一组策略可选，客户端代码如何选择使用哪个策略，有两种确定方法：编译时静态确定和运行时动态确定。其中，「运行时动态确定」才是策略模式最典型的应用场景。

四、工厂模式和策略模式的区别

工厂模式

1. 目的是创建不同且相关的对象

2. 侧重于 "创建对象"

3. 实现方式上可以通过父类或者接口

策略模式

1. 目的实现方便地替换不同的算法类

2. 侧重于算法 (行为) 实现

3. 实现主要通过接口

2020-03-22


Geek_3b1096


学习查表法

2020-03-22


jinjunzhu


讲解清晰简洁，期待下一节

2020-03-21


howdyli


老师结合 spring 和应用场景讲解一下，这样更适用。

2020-03-21


小刀

策略：侧重不同算法实现，通过接口实现，方便动态替换不同的算法实现

2020-03-21


孙自友

用 type 枚举类有创建策略类方法

2020-03-21


whistleman


这个设计模式场景，刚好可以在目前着手的项目试一下～打卡

2020-03-21


Fstar


每次都要返回新的策略对象时，工厂类中避免写 if-else 的解决方法想到两个：

1. 用个 hash 表做 type 到类的映射。工厂函数传入 type 作为哈希表的 key，返回对应的策略类，然后创建对象即可。（不清楚 Java 中类能不能作为值进行传递。如果不可以的话，可以利用建造者模式模式做 type 到具体策略建造类的映射，这种方案要多写几个建造类）

2. 将缓存的策略对象进行克隆。

2020-03-21


tt


使用工厂方法工厂模式么？

2020-03-20


南山

期待下一节！！！

2020-03-20


刘大明

可以通过注解来觉得取哪个策略。工厂类里面通过注解的类来动态生成。

2020-03-20


梦寻解语花

策略类过多膨胀的问题，有什么解决办法吗

2020-03-20


Heaven


这个简单，Map 中维护对应的 class, 使用反射创建，甚至可以指定 init 的方法，去给设备注入组装对象

2020-03-20


大头

工厂模式和策略模式通常是组合使用的，既然用到了工厂模式，返回的必然是继承或实现同一父类的实例，也就是其中的一个策略。但是从不同的角度来看，工厂模式侧重于创建，策略模式侧重于实现。

2020-03-20


右耳听海

通过工厂缓存 class，再通过动态代理实例化

2020-03-20


www.xnsms.com 小鸟接码

为何感觉很多模式看起来都是一样的套路

2020-03-20


小晏子

课后思考：

在工厂类中做如下操作

1. 将策略类对应的类名和对应的 Order 类型保存在 map 中，对应的 key 是 order 类型，value 是类名

2. 根据输入的 order 类型获取类名，然后用反射生成实际的类对象，

示意代码如下：

public class DiscountStrategyFactory {


    private static final map<OrderType, String> typeClassPair = new HashMap<>();


    static {


        typeClassPair.put(OrderType.NORMAL, "NormalDiscountStrategy");


        typeClassPair.put(OrderType.GROUPON,"GrouponDiscountStrategy");


        typeClassPair.put(OrderType.PROMOTION, "PromotionDiscountStrategy")


    }


    public static DiscountStrategy getDiscountStrategy(OrderType type) {


        if (type == null) {


            throw new IllegalArgumentException("Type should not be null.");


        }


        String className = typeClassPair.get(type);


        return (DiscountStrategy)Class.forName(className).NewInstance();


    }


}


2020-03-20


Jackey


没看太明白策略模式和工厂模式有啥区别😂

2020-03-20


肥 low

策略模式平时用的太多了，而且确实随着策略越来越多，if else 还是避免不了的，我觉得这个是可以接受的，因为我平时就是这么干的，。

2020-03-20


墨雨

怎么感觉就是工厂模式呢？策略模式和工厂模式有什么不同吗？我感觉平时用工厂模式的时候就是这样的……

2020-03-20


Ken 张云忠

通过输入不同参数用反射的方式来创建新对象

2020-03-20


木头

怎么看都是工厂模式！

2020-03-20


