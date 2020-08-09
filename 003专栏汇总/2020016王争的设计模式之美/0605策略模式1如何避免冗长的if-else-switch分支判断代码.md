# 0605. 策略模式1：如何避免冗长的 if-else/switch 分支判断代码？

王争 2020-03-20

上两节课中，我们学习了模板模式。模板模式主要起到代码复用和扩展的作用。除此之外，我们还讲到了回调，它跟模板模式的作用类似，但使用起来更加灵活。它们之间的主要区别在于代码实现，模板模式基于继承来实现，回调基于组合来实现。

今天，我们开始学习另外一种行为型模式，策略模式。在实际的项目开发中，这个模式也比较常用。最常见的应用场景是，利用它来避免冗长的 if-else 或 switch 分支判断。不过，它的作用还不止如此。它也可以像模板模式那样，提供框架的扩展点等等。对于策略模式，我们分两节课来讲解。今天，我们讲解策略模式的原理和实现，以及如何用它来避免分支判断逻辑。下一节课，我会通过一个具体的例子，来详细讲解策略模式的应用场景以及真正的设计意图。

## 5.1 策略模式的原理与实现

策略模式，英文全称是 Strategy Design Pattern。在 GoF 的《设计模式》一书中，它是这样定义的：

Define a family of algorithms, encapsulate each one, and make them interchangeable. Strategy lets the algorithm vary independently from clients that use it.

翻译成中文就是：定义一族算法类，将每个算法分别封装起来，让它们可以互相替换。策略模式可以使算法的变化独立于使用它们的客户端（这里的客户端代指使用算法的代码）。

我们知道，工厂模式是解耦对象的创建和使用，观察者模式是解耦观察者和被观察者。策略模式跟两者类似，也能起到解耦的作用，不过，它解耦的是策略的定义、创建、使用这三部分。接下来，我就详细讲讲一个完整的策略模式应该包含的这三个部分。

1、策略的定义。策略类的定义比较简单，包含一个策略接口和一组实现这个接口的策略类。因为所有的策略类都实现相同的接口，所以，客户端代码基于接口而非实现编程，可以灵活地替换不同的策略。示例代码如下所示：

```java
public interface Strategy {
  void algorithmInterface();
}

public class ConcreteStrategyA implements Strategy {
  @Override
  public void  algorithmInterface() {
    //具体的算法...
  }
}

public class ConcreteStrategyB implements Strategy {
  @Override
  public void  algorithmInterface() {
    //具体的算法...
  }
}
```

2、策略的创建。因为策略模式会包含一组策略，在使用它们的时候，一般会通过类型（type）来判断创建哪个策略来使用。为了封装创建逻辑，我们需要对客户端代码屏蔽创建细节。我们可以把根据 type 创建策略的逻辑抽离出来，放到工厂类中。示例代码如下所示：

```java
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
```

一般来讲，如果策略类是无状态的，不包含成员变量，只是纯粹的算法实现，这样的策略对象是可以被共享使用的，不需要在每次调用 getStrategy() 的时候，都创建一个新的策略对象。针对这种情况，我们可以使用上面这种工厂类的实现方式，事先创建好每个策略对象，缓存到工厂类中，用的时候直接返回。

相反，如果策略类是有状态的，根据业务场景的需要，我们希望每次从工厂方法中，获得的都是新创建的策略对象，而不是缓存好可共享的策略对象，那我们就需要按照如下方式来实现策略工厂类。

```java
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
```

3、策略的使用。刚刚讲了策略的定义和创建，现在，我们再来看一下，策略的使用。我们知道，策略模式包含一组可选策略，客户端代码一般如何确定使用哪个策略呢？最常见的是运行时动态确定使用哪种策略，这也是策略模式最典型的应用场景。

这里的「运行时动态」指的是，我们事先并不知道会使用哪个策略，而是在程序运行期间，根据配置、用户输入、计算结果等这些不确定因素，动态决定使用哪种策略。接下来，我们通过一个例子来解释一下。

```java
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
```

从上面的代码中，我们也可以看出，「非运行时动态确定」，也就是第二个 Application 中的使用方式，并不能发挥策略模式的优势。在这种应用场景下，策略模式实际上退化成了「面向对象的多态特性」或「基于接口而非实现编程原则」。

## 5.2 如何利用策略模式避免分支判断？

实际上，能够移除分支判断逻辑的模式不仅仅有策略模式，后面我们要讲的状态模式也可以。对于使用哪种模式，具体还要看应用场景来定。策略模式适用于根据不同类型的动态，决定使用哪种策略这样一种应用场景。我们先通过一个例子来看下，if-else 或 switch-case 分支判断逻辑是如何产生的。具体的代码如下所示。在这个例子中，我们没有使用策略模式，而是将策略的定义、创建、使用直接耦合在一起。

```java
public class OrderService {
  public double discount(Order order) {
    double discount = 0.0;
    OrderType type = order.getType();
    if (type.equals(OrderType.NORMAL)) { // 普通订单
      //...省略折扣计算算法代码
    } else if (type.equals(OrderType.GROUPON)) { // 团购订单
      //...省略折扣计算算法代码
    } else if (type.equals(OrderType.PROMOTION)) { // 促销订单
      //...省略折扣计算算法代码
    }
    return discount;
  }
}
```

如何来移除掉分支判断逻辑呢？那策略模式就派上用场了。我们使用策略模式对上面的代码重构，将不同类型订单的打折策略设计成策略类，并由工厂类来负责创建策略对象。具体的代码如下所示：

```java
// 策略的定义
public interface DiscountStrategy {
  double calDiscount(Order order);
}
// 省略NormalDiscountStrategy、GrouponDiscountStrategy、PromotionDiscountStrategy类代码...

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
```

重构之后的代码就没有了 if-else 分支判断语句了。实际上，这得益于策略工厂类。在工厂类中，我们用 Map 来缓存策略，根据 type 直接从 Map 中获取对应的策略，从而避免 if-else 分支判断逻辑。等后面讲到使用状态模式来避免分支判断逻辑的时候，你会发现，它们使用的是同样的套路。本质上都是借助「查表法」，根据 type 查表（代码中的 strategies 就是表）替代根据 type 分支判断。

但是，如果业务场景需要每次都创建不同的策略对象，我们就要用另外一种工厂类的实现方式了。具体的代码如下所示：

```java
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
```

这种实现方式相当于把原来的 if-else 分支逻辑，从 OrderService 类中转移到了工厂类中，实际上并没有真正将它移除。关于这个问题如何解决，我今天先暂时卖个关子。你可以在留言区说说你的想法，我在下一节课中再讲解。

## 重点回顾

策略模式定义一族算法类，将每个算法分别封装起来，让它们可以互相替换。策略模式可以使算法的变化独立于使用它们的客户端（这里的客户端代指使用算法的代码）。策略模式用来解耦策略的定义、创建、使用。实际上，一个完整的策略模式就是由这三个部分组成的。1）策略类的定义比较简单，包含一个策略接口和一组实现这个接口的策略类。2）策略的创建由工厂类来完成，封装策略创建的细节。3）策略模式包含一组策略可选，客户端代码如何选择使用哪个策略，有两种确定方法：编译时静态确定和运行时动态确定。其中，「运行时动态确定」才是策略模式最典型的应用场景。除此之外，我们还可以通过策略模式来移除 if-else 分支判断。实际上，这得益于策略工厂类，更本质上点讲，是借助「查表法」，根据 type 查表替代根据 type 分支判断。

## 黑板墙

今天我们讲到，在策略工厂类中，如果每次都要返回新的策略对象，我们还是需要在工厂类中编写 if-else 分支判断逻辑，那这个问题该如何解决呢？

### 01

仍然可以用查表法，只不过存储的不再是实例，而是 class，使用时获取对应的 class，再通过反射创建实例。2020-03-20

### 02

策略模式和工厂模式区别。工厂模式：1）目的是创建不同且相关的对象。2）侧重于「创建对象」。3）实现方式上可以通过父类或者接口。4）一般创建对象应该是现实世界中某种事物的映射，有它自己的属性与方法！策略模式：目的实现方便地替换不同的算法类。2）侧重于算法（行为）实现。3）实现主要通过接口。4）创建对象对行为的抽象而非对对象的抽象，很可能没有属于自己的属性。2020-03-20

### 03

策略模式通常跟工厂一起配合使用。策略侧重如何灵活选择替换，工厂侧重怎么创建实例。2020-03-20

### 04

一般而言 Java web 开发中我们均使用 spring 框架，可以使用运行时自定义注解给具体的策略类打上注解，将具体的策略类放于 spring 容器中，工厂中注入直接根据类型获取即可。不实用 spring 框架的话，也可以用 Java 的反射做到获取到具体的策略类。2020-03-20

### 05

查表策略还是挺常见的，搭配 java.util.function 各种接口挺好用的。

```java
private final Map<String, Function<String, String>> PHONE_FUN_FACTORY =
    ImmutableMap.of(
        MessageDestination.LEGAL_PERSON.name(), legalPersonPhoneFunc(),
        MessageDestination.ACTUAL_CONTROL.name(), actualPersonPhoneFunc()
    );
```

我比较喜欢建一个 StrategyContext 类，简单工厂 + 策略模式。Context 类存在一个成员变量 xxx，new StrategyContext(xxx).apply ()；然后 StrategyContext 内部存放一个表，value 是一堆 function，通过成员变量查表找对应的 func.apply 即可。2020-05-06

### 06

汇总：1）业务代码少用反射。这个场景和原型模式的应用场景很贴合。依旧是 type 查表，只是每次使用的都是 type 对应策略实例的 copy 对象。详细请参照 spring 原型模式的实现。2）往往业务场景里面，往往不是选择策略这一场景，而是编排策略这一场景。即利用 type 查表拿出一堆要用到的策略，并按顺序去执行。对于这种场景，栏主怎么看？2020-03-20

### 07

就像老师说的，替换麻烦的 ifelse 本质上靠的是查表法，也就是 if 里的条件成立绑定对应的方法地址，所以其实感觉和策略模式本身没有半毛钱关系，只不过在策略模式这个上下文下，每个条件分支是可扩展的策略实现而不是差别很大的功能代码。2020-03-20

### 08

策略模式，理解有多种策略可供使用，怎么使用。文章中提到三部分：策略的定义，策略的创建，策略的使用。定义：需要定义策略接口和一组实现类，使用基于接口而非实现编程可灵活替换不同的类，各个实现类可独立变化。创建： 创建策略类时，为了封装创建细节，使用简单工厂方法。根据策略类状态特性（可变类与不可变类）来判断是使用可缓存的，还是每次都返回新的。使用：基于两种方式：运行时动态确定和编译时静态确定，前者使用灵活，外界可灵活介入，后者硬编码，存在一定维护成本。课堂讨论中的问题可通过工厂方法即将不同的折扣策略计算对象的创建在拆分出来形成一个个小工厂，在小工厂里创建折扣策略对象，然后再使用简单工厂模式里面的第二种方式缓存这些小工厂，使用的时候根据类型返回小工厂，进而通过小工厂拿到相应的折扣策略对象。2020-03-21

### 09

汇总：1）可以用类前缀方式，用反射加载实例：例如 AtypeStrategy、BtypeStrategy，使用时出入 Atype 或 Btype，分别对应 AtypeStrategy 和 BtypeStrategy。2）用 map 做映射，key 是 Atype、Btype，对应的是 AtypeStrategy、BtypeStrategy 的类，反射加载创建对象。2020-08-05

### 10

请问各位一个问题：如果在 spring 应用中，Map 策略表中的对象应该是 new 创建的，还是用 autowired 注入？作者回复：要是自己 new 的，spring 容器是不管理的，也就是你在其他地方无法自动注入。2020-07-30

### 11

感觉从代码层面来看，工厂模式和策略模式没有什么区别，只是人在解释的时候或者人的着眼点在对象 or 一种行为能力的问题。真正到实际开发时，估计不好区分使用的是策略模式还是工厂模式。如果按照从业务需求角度来说，可能是策略模式吧。另外我难道是学习偏了，没有人觉得策略模式和前面讲的装饰器模式有点像吗？不同策略的一个是自己定义的统一接口，一个需要转换包装一下不同的第三方为统一接口。然后根据场景的不同做不同的选择。2020-03-29

### 12

对于课后思考题，可以使用反射实现。对于各个策略类，可以是用表记录。也在思考一个问题，对于争哥举的购物的例子，如果现实情况并非单一策略，而是不同策略的组合呢？例如我既满足满减同时也能使用优惠券呢？这种情况简单的解决方法就是再定一个新策略。至于策略组合爆炸的问题，显然不是所有策略的组合现实中都是合理的。2020-03-24

### 13

每次都要返回新的策略对象时，工厂类中避免写 if-else 的解决方法想到两个：1）用个 hash 表做 type 到类的映射。工厂函数传入 type 作为哈希表的 key，返回对应的策略类，然后创建对象即可。（不清楚 Java 中类能不能作为值进行传递。如果不可以的话，可以利用建造者模式模式做 type 到具体策略建造类的映射，这种方案要多写几个建造类）2）将缓存的策略对象进行克隆。2020-03-21