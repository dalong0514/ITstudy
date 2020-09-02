# PHPUnit测试私有属性和方法功能示例

[PHPUnit测试私有属性和方法功能示例_php技巧_脚本之家](https://www.jb51.net/article/141906.htm)

[PHP: ReflectionMethod - Manual](https://www.php.net/manual/en/class.reflectionmethod.php)

## 01. 测试类中的私有方法：

```php
class Sample
{
  private $a = 0;
  private function run()
  {
    echo $a;
  }
}
```

上面只是简单的写了一个类包含，一个私有变量和一个私有方法。对于 protected 和 private 方法，由于无法像是用 public 方法一样直接调用，所以在使用 phpunit 进行单测的时候，多有不便，特别是当一个类中，对外只提供少量接口，内部使用了大量 private 方法的情况。

对于 protected 方法，建议使用继承的方式进行测试，在此就不再赘述。而对于 private 方法的测试，建议使用 php 的反射机制来进行。话不多说，上代码：

1『专门写一个用户测试的继承类，在继承里写公共的方法调用父类里的私有方法，然后再测试类里实例化这个继承类用于测试。』

```php
class testSample()
{
    $method = new ReflectionMethod('Sample', 'run');
    $method->setAccessible(true); //将 run 方法从 private 变成类似于 public 的权限
    $method->invoke(new Sample()); //调用 run 方法
}
```

如果 run 方法是静态的，如：

```php
private static function run()
{
  echo 'run is a private static function';
}
```

那么 invoke 函数还可以这么写：

```php
$method->invoke(null); //只有静态方法可以不必传类的实例化
```

如果 run 还需要传参，比如：

```php
private function run($x, $y)
{
  return $x + $y;
}
```

那么，测试代码可以改为：

```php
$method->invokeArgs(new Sample(), array(1, 2));
//array 中依次写入要传的参数。执行结果返回 3
```

【注意】：利用反射的方法测试私有方法虽好，但 setAccessible 函数是 php5.3.2 版本以后才支持的（>=5.3.2）。

## 02. 私有属性的 get/set

说完了私有方法，再来看看私有属性，依旧拿 Sample 类作为例子，想要获取或设置 Sample 类中的私有属性 \$a 的值可以用如下方法：

```php
public function testPrivateProperty()
{
  $reflectedClass = new ReflectionClass('Sample');
  $reflectedProperty = $reflectedClass->getProperty('a');
  $reflectedProperty->setAccessible(true);
  $reflectedProperty->getValue(); //获取$a的值
  $reflectedProperty->setValue(123); //给$a赋值:$a = 123;
}
```

上述方法对静态属性依然有效。到此，是不是瞬间感觉测试私有方法或属性变得很容易了。

附：PHPunit 测试私有方法（英文原文）

This article is part of a series on testing untestable code: 1) Testing private methods. 2) Testing code that uses singletons. 3) Stubbing static methods. 4) Stubbing hard-coded dependencies.

No, not those privates. If you need help with those, this book might help.

One question I get over and over again when talking about Unit Testing is this:

"How do I test the private attributes and methods of my objects?"

Lets assume we have a class Foo:

```php
<?php
class Foo
{
  private $bar = 'baz';
  public function doSomething()
  {
    return $this->bar = $this->doSomethingPrivate();
  }
  private function doSomethingPrivate()
  {
    return 'blah';
  }
}
?>
```

Before we explore how protected and private attributes and methods can be tested directly, lets have a look at how they can be tested indirectly. The following test calls the testDoSomething() method which in turn calls thedoSomethingPrivate() method:

```php
<?php
class FooTest extends PHPUnit_Framework_TestCase
{
  /**
   * @covers Foo::doSomething
   * @covers Foo::doSomethingPrivate
   */
  public function testDoSomething()
  {
    $foo = new Foo;
    $this->assertEquals('blah', $foo->doSomething());
  }
}
?>
```

The test above assumes that testDoSomething() only works correctly whentestDoSomethingPrivate() works correctly. This means that we have indirectly testedtestDoSomethingPrivate(). The problem with this approach is that when the test fails we do not know directly where the root cause for the failure is. It could be in eithertestDoSomething() or testDoSomethingPrivate(). This makes the test less valuable.

PHPUnit supports reading protected and private attributes through thePHPUnit_Framework_Assert::readAttribute() method. Convenience wrappers such asPHPUnit_Framework_TestCase::assertAttributeEquals() exist to express assertions onprotected and private attributes:

```php
<?php
class FooTest extends PHPUnit_Framework_TestCase
{
  public function testPrivateAttribute()
  {
    $this->assertAttributeEquals(
     'baz', /* expected value */
     'bar', /* attribute name */
     new Foo /* object     */
    );
  }
}
?>
```

PHP 5.3.2 introduces the ReflectionMethod::setAccessible() method to allow the invocation of protected and private methods through the Reflection API:

```php
<?php
class FooTest extends PHPUnit_Framework_TestCase
{
  /**
   * @covers Foo::doSomethingPrivate
   */
  public function testPrivateMethod()
  {
    $method = new ReflectionMethod(
     'Foo', 'doSomethingPrivate'
    );
    $method->setAccessible(TRUE);
    $this->assertEquals(
     'blah', $method->invoke(new Foo)
    );
  }
}
?>
```

In the test above we directly test testDoSomethingPrivate(). When it fails we immediately know where to look for the root cause.

I agree with Dave Thomas and Andy Hunt, who write in their book "Pragmatic Unit Testing":

"In general, you don't want to break any encapsulation for the sake of testing (or as Mom used to say, "don't expose your privates!"). Most of the time, you should be able to test a class by exercising its public methods. If there is significant functionality that is hidden behind private or protected access, that might be a warning sign that there's another class in there struggling to get out."
So: Just because the testing of protected and private attributes and methods is possible does not mean that this is a "good thing".