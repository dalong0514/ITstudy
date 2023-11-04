## 01. 写业务逻辑

1、先定义接口，在接口文件里写代码。

```
dataflow-server/src/main/java/com/titan/server/service => IAdminService.java
```

```java
public interface IAdminService extends IService<Admin> {

    List<Admin> getAllAdmins(String keywords);
    int getTwoNumPlus(int a, int b);
    int getTwoNumMinus(int a, int b);
    int getTwoNumMulti(int a, int b);

}
```

2、实现接口。

接口文件里鼠标放在接口名上，直接快捷键「option + enter」键弹出选项，选择实现该方法。试了下，也可以用这个快捷键软删除已经实现的方法。

如果已经新建好了实现，在接口这里可以用「option + command + B」直接跳转到实现方法那边去。

## 02. 真实测试实例

1、创建实例。

实现的类文件里，鼠标放在要测试的实现类名上，「shift + command + T」弹出的选型里选择「Create Test」，用默认的命名，一般是一个实现类一个测试文件。

2、测试类前引入 SpringBootTest。

在测试类名前一行加上 `@SpringBootTest`。

3、实例化「容器」前引入 @Autowired。

```java
    @Autowired
    private IAdminService iAdminService;
```

4、直接写测试用例。

```java
@SpringBootTest
class AdminServiceImplTest {
    @Autowired
    private IAdminService iAdminService;

    @Test
    void getTwoNumMulti() {
        int res = iAdminService.getTwoNumMulti(2, 4);
        Assertions.assertEquals(8, res);
    }
}
```

@Autowired > @SpyBean > @MockBean

@Autowired 全部调用的真实值。@SpyBean 是真实值和模拟值之间。@MockBean 全部是模拟值。

用 @MockBean 的时候，定义了 `when` 就返回你模拟的值，不定义的话返回默认值，int 类型返回的是 0，字符串返回的是 null。

## 03. mock 测试用例

用 SpyBean 的话。

3、实例化「容器」前引入 @SpyBean。

```java
    @SpyBean
    private IAdminService iAdminService;
```

4、用模拟写测试用例。

先模拟一个值。

```java
when(iAdminService.getTwoNumMulti(2, 4)).thenReturn(6);
```

注意，开始打 `when` 的时候是红色的报错，要引入相关的依赖包，鼠标放在 when 上，直接「option + enter」即可。

```java
@SpringBootTest
class AdminServiceImplTest3 {
    @SpyBean
    private IAdminService iAdminService;

    @Test
    void getTwoNumMulti() {
        when(iAdminService.getTwoNumMulti(2, 4)).thenReturn(6);
        int res = iAdminService.getTwoNumMulti(2, 4);
        Assertions.assertEquals(8, res);
    }
}
```

汇总的代码：

```java
@SpringBootTest
class AdminServiceImplTest {
//    @Autowired
    @SpyBean
//    @MockBean
    private IAdminService iAdminService;

    @Test
    void getTwoNumMulti() {
        when(iAdminService.getTwoNumMulti(2, 4)).thenReturn(6);
        int res = iAdminService.getTwoNumMulti(2, 4);
        Assertions.assertEquals(6, res);
    }

    @Test
    void getTwoNumPlus() {
        when(iAdminService.getTwoNumPlus(1, 3)).thenReturn(5);
        int res = iAdminService.getTwoNumPlus(1, 3);
        Assertions.assertEquals(5, res);
    }

    @Test
    void getTwoNumMinus() {
        when(iAdminService.getTwoNumMinus(3, 1)).thenReturn(3);
        int res = iAdminService.getTwoNumMinus(3, 1);
        Assertions.assertEquals(3, res);
    }

}
```

## 04. 查看覆盖率

上面有个小盾牌，跑测试用例 with 覆盖率。