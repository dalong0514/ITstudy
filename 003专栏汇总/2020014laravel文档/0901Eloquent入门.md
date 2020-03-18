# 0901Eloquent-ORM

## 01. 简介

Laravel 的 Eloquent ORM 提供了一个漂亮、简洁的 ActiveRecord 实现来和数据库交互。每个数据库表都有一个对应的「模型」用来与该表交互。你可以通过模型查询数据表中的数据，以及在数据表中插入新记录。

在开始之前，请确保在 `config/database.php` 中配置数据库连接。更多关于数据库配置的信息，请查看 [文档](/docs/{{version}}/database#configuration)。

<a name="defining-models"></a>

## 模型定义

首先，创建一个 Eloquent 模型。 模型通常在 `app` 目录中，但你可以根据 `composer.json` 文件将他们放置在可以被自动加载的任意位置。所有的 Eloquent 模型都继承至 `Illuminate\Database\Eloquent\Model` 类。

创建模型最简单的方法就是使用 `make:model` [Artisan 命令](/docs/{{version}}/artisan):

    php artisan make:model Flight

如果要在生成模型的时候生成 [数据库迁移](/docs/{{version}}/migrations) ，可以使用 `--migration` 或 `-m` 选项：

    php artisan make:model Flight --migration

    php artisan make:model Flight -m

<a name="eloquent-model-conventions"></a>

### Eloquent 模型约定

现在，我们来看一个 `Flight` 模型的示例，我们将用它从 `flights` 数据库表中检索和存储数据信息：

    <?php

    namespace App;

    use Illuminate\Database\Eloquent\Model;

    class Flight extends Model
    {
        //
    }

#### 数据表名称

请注意，我们并没有告诉 Eloquent 我们的 `Flight` 模型使用哪个数据表。 除非明确地指定了其它名称，否则将使用类的复数形式「蛇形命名」来作为表名。因此，在这种情况下，Eloquent 将假设 `Flight` 模型存储的是 `flights` 数据表中的数据。你可以通过在模型上定义 `table` 属性来指定自定义数据表：

    <?php

    namespace App;

    use Illuminate\Database\Eloquent\Model;

    class Flight extends Model
    {
        /**
         * 与模型关联的表名
         *
         * @var string
         */
        protected $table = 'my_flights';
    }

#### 主键

Eloquent 也会假设每个数据表都有一个名为 `id` 的主键列。你可以定义一个受保护的 `$primaryKey` 属性来重写约定。

此外，Eloquent 假设主键是一个自增的整数值，这意味着默认情况下主键会自动转换为 `int` 类型。如果您希望使用非递增或非数字的主键则需要设置公共的  `$incrementing` 属性设置为 `false`。如果你的主键不是一个整数，你需要将模型上受保护的 `$keyType` 属性设置为 `string`。

#### 时间戳

默认情况下，Eloquent 预期你的数据表中存在 `created_at` 和 `updated_at` 。如果你不想让 Eloquent 自动管理这两个列， 请将模型中的 `$timestamps` 属性设置为 `false`：

    <?php

    namespace App;

    use Illuminate\Database\Eloquent\Model;

    class Flight extends Model
    {
        /**
         * 指示模型是否自动维护时间戳
         *
         * @var bool
         */
        public $timestamps = false;
    }

如果需要自定义时间戳的格式，在你的模型中设置 `$dateFormat` 属性。这个属性决定日期属性在数据库的存储方式，以及模型序列化为数组或者 JSON 的格式：

    <?php

    namespace App;

    use Illuminate\Database\Eloquent\Model;

    class Flight extends Model
    {
        /**
         * 模型日期列的存储格式。
         *
         * @var string
         */
        protected $dateFormat = 'U';
    }

如果你需要自定义存储时间戳的字段名，可以在模型中设置 `CREATED_AT` 和 `UPDATED_AT` 常量的值来实现：

    <?php

    class Flight extends Model
    {
        const CREATED_AT = 'creation_date';
        const UPDATED_AT = 'last_update';
    }


#### 数据库连接

默认情况下，Eloquent 模型将使用你的应用程序配置的默认数据库连接。如果你想为模型指定一个不同的连接，设置 `$connection` 属性：

    <?php

    namespace App;

    use Illuminate\Database\Eloquent\Model;

    class Flight extends Model
    {
        /**
         * 模型的连接名称
         *
         * @var string
         */
        protected $connection = 'connection-name';
    }

<a name="default-attribute-values"></a>
### 默认属性值

如果要为模型的某些属性定义默认值，可以在模型上定义 `$attributes` 属性：

    <?php

    namespace App;

    use Illuminate\Database\Eloquent\Model;

    class Flight extends Model
    {
        /**
         * 模型的默认属性值。
         *
         * @var array
         */
        protected $attributes = [
            'delayed' => false,
        ];
    }

<a name="retrieving-models"></a>
## 模型检索

创建模型和 [它关联的数据库表](/docs/{{version}}/migrations#writing-migrations)后，你就可以从数据库中查询数据了。将每个 Eloquent 模型想象成一个强大的查询构造器 [query builder](/docs/{{version}}/queries) ，你可以用它更快速的查询与其相关联的数据表。例如：

    <?php

    $flights = App\Flight::all();

    foreach ($flights as $flight) {
        echo $flight->name;
    }

#### 附加约束

Eloquent 的 `all` 方法会返回模型中所有的结果。由于每个 Eloquent 模型都充当一个[查询构造器](/docs/{{version}}/queries)，所以你也可以添加查询条件，然后使用 `get` 方法获取查询结果：

    $flights = App\Flight::where('active', 1)
                   ->orderBy('name', 'desc')
                   ->take(10)
                   ->get();

> {tip} 因为 Eloquent 模型也是查询构造器，所以你也应当阅读 [查询构造器](/docs/{{version}}/queries)可用的所有方法。你可以在 Eloquent 查询中使用这些方法。

#### 重新加载模型

你可以使用 `fresh` 和 `refresh` 方法重新加载模型。 `fresh` 方法会重新从数据库中检索模型。现有的模型实例不受影响：

    $flight = App\Flight::where('number', 'FR 900')->first();

    $freshFlight = $flight->fresh();

 `refresh` 方法使用数据库中的新数据重新赋值现有模型。此外，已经加载的关系会被重新加载：

    $flight = App\Flight::where('number', 'FR 900')->first();

    $flight->number = 'FR 456';

    $flight->refresh();

    $flight->number; // "FR 900"

<a name="collections"></a>
### 集合

对于 Eloquent 中的 `all` 和 `get` 方法可以查询多个结果，返回一个 `Illuminate\Database\Eloquent\Collection` 实例。  `Collection` 类提供了 [很多辅助函数](/docs/{{version}}/eloquent-collections#available-methods) 来处理 Eloquent 结果：

    $flights = $flights->reject(function ($flight) {
        return $flight->cancelled;
    });

你可以像数组一样遍历集合：

    foreach ($flights as $flight) {
        echo $flight->name;
    }



<a name="chunking-results"></a>
### 分块结果

如果你需要处理数以千计的 Eloquent 结果，使用 `chunk` 命令。 `chunk` 方法会检索 Eloquent 模型中的『分块』将他们提供给指定的 `Closure` 处理。在处理大型结果集时，使用  `chunk` 方法可以节省内存：

    Flight::chunk(200, function ($flights) {
        foreach ($flights as $flight) {
            //
        }
    });

传递到方法的第一个参数是希望每个『分块』接收的数据量。闭包作为第二个参数传递，它在每次从数据库中检索分块的时候调用。它将执行数据库查询把检索分块的结果传递给闭包方法。

#### 使用游标

 `cursor` 方法允许你使用游标遍历数据库，它只执行一次查询。处理大量的数据时， `cursor` 方法可以大大减少内存的使用量：

    foreach (Flight::where('foo', 'bar')->cursor() as $flight) {
        //
    }

<a name="retrieving-single-models"></a>
## 检索单个模型 / 集合

除了从指定的数据表检索所有记录外，你可以使用 `find` 或 `first` 方法来检索单条记录。这些方法返回单个模型实例，而不是返回模型集合：

    // 通过主键检索一个模型...
    $flight = App\Flight::find(1);

    // 检索符合查询限制的第一个模型...
    $flight = App\Flight::where('active', 1)->first();

你也可以使用主键数组作为参数调用 `find` 方法，它将返回匹配记录的集合：

    $flights = App\Flight::find([1, 2, 3]);

#### 『未找到』异常

有时你希望在未找到模型时抛出异常。这在控制器和路由中非常有用。 `findOrFail` 和 `firstOrFail` 方法会检索查询的第一个结果，如果未找到，将抛出 `Illuminate\Database\Eloquent\ModelNotFoundException` 异常：

    $model = App\Flight::findOrFail(1);

    $model = App\Flight::where('legs', '>', 100)->firstOrFail();

如果没有捕获异常，则会自动返回 `404` 响应给用户。也就是说，使用这些方法时，没有必要再写个检查来返回 `404` 响应：:

    Route::get('/api/flights/{id}', function ($id) {
        return App\Flight::findOrFail($id);
    });

<a name="retrieving-aggregates"></a>
### 检索集合

你还可以使用 [查询构造器](/docs/{{version}}/queries) 提供的 `count` ， `sum`， `max`, 和其他的[聚合函数](/docs/{{version}}/queries#aggregates)。这些方法只会返回适当的标量值而不是一个模型实例：

    $count = App\Flight::where('active', 1)->count();

    $max = App\Flight::where('active', 1)->max('price');

<a name="inserting-and-updating-models"></a>
## 插入 & 更新模型

<a name="inserts"></a>
### 插入

要往数据库新增一条记录，先创建新模型实例，给实例设置属性，然后调用 `save` 方法：

    <?php

    namespace App\Http\Controllers;

    use App\Flight;
    use Illuminate\Http\Request;
    use App\Http\Controllers\Controller;

    class FlightController extends Controller
    {
        /**
         * 创建一个新的航班实例
         *
         * @param  Request  $request
         * @return Response
         */
        public function store(Request $request)
        {
            // 校验请求...

            $flight = new Flight;

            $flight->name = $request->name;

            $flight->save();
        }
    }

在这个示例中，我们将 HTTP 请求参数 `name` 赋值给了 `App\Flight` 模型实例的 `name` 属性。当调用 `save` 方法时，将会插入一条新记录。 `created_at` 和 `updated_at` 时间戳将会自动设置，不需要手动赋值。

<a name="updates"></a>
### 更新

 `save` 方法也可以用来更新数据库已经存在的模型。更新模型，你需要先检索出来，设置要更新的属性，然后调用 `save` 方法。同样， `updated_at` 时间戳会自动更新，所以也不需要手动赋值：

    $flight = App\Flight::find(1);

    $flight->name = 'New Flight Name';

    $flight->save();

#### 批量更新

也可以更新匹配查询条件的多个模型。在这个示例中，所有的 `active` 和  `destination` 为 `San Diego` 的航班会标记为延误：

    App\Flight::where('active', 1)
              ->where('destination', 'San Diego')
              ->update(['delayed' => 1]);

 `update` 方法接受一个键为字段名称数据为值的数组。

> {note} 通过 Eloquent 批量更新时， 更新的模型不会触发 `saved` 和 `updated` 事件。因为在批量更新时，从不会去检索模型。



<a name="mass-assignment"></a>
### 批量赋值

你也可以使用 `create` 方法来保存新模型，此方法会返回模型实例。不过，在使用之前，你需要在模型上指定 `fillable` 或 `guarded` 属性，因为所有的 Eloquent 模型都默认不可进行批量赋值。

当用户通过HTTP请求传入一个意外的参数，并且该参数更改了数据库中你不需要更改的字段时。比如：恶意用户可能会通过HTTP请求传入 `is_admin`  参数，然后将其传给 `create` 方法，此操作能让用户将自己升级成管理员。

所以，在开始之前，你应该定义好模型上的哪些属性是可以被批量赋值的。你可以通过模型上的 `$fillable` 属性来实现。 例如：让 `Flight` 模型的 `name` 属性可以被批量赋值：

    <?php

    namespace App;

    use Illuminate\Database\Eloquent\Model;

    class Flight extends Model
    {
        /**
         * 可以被批量赋值的属性。
         *
         * @var array
         */
        protected $fillable = ['name'];
    }

一旦我们设置好了可以批量赋值的属性，就可以通过 `create` 方法插入新数据到数据库中了。 `create` 方法将返回保存的模型实例：

    $flight = App\Flight::create(['name' => 'Flight 10']);

如果你已经有一个模型实例，你可以传递一个数组给 `fill` 方法来赋值：

    $flight->fill(['name' => 'Flight 22']);

#### 保护属性

`$fillable` 可以看作批量赋值的「白名单」,你也可以使用 `$guarded` 属性来实现。 `$guarded` 属性包含的是不允许批量赋值的数组。也就是说， `$guarded` 从功能上将更像是一个「黑名单」。注意：你只能使用 `$fillable` 或 `$guarded` 二者中的一个，不可同时使用。下面这个例子中，**除了 `price`** 属性，其他的属性都可以批量赋值：

    <?php

    namespace App;

    use Illuminate\Database\Eloquent\Model;

    class Flight extends Model
    {
        /**
         * 不可批量赋值的属性。
         *
         * @var array
         */
        protected $guarded = ['price'];
    }

如果你想让所有属性都可以批量赋值， 你可以将 `$guarded` 定义成一个空数组：

    /**
     * 不可以批量赋值的属性。
     *
     * @var array
     */
    protected $guarded = [];

<a name="other-creation-methods"></a>
### 其他创建方法

#### `firstOrCreate`/ `firstOrNew`

这里有两个你可能用来批量赋值的方法： `firstOrCreate` 和 `firstOrNew`。`firstOrCreate` 方法会通过给定的 列 / 值 来匹配数据库中的数据。如果在数据库中找不到对应的模型， 则会从第一个参数的属性乃至第二个参数的属性中创建一条记录插入到数据库。

 `firstOrNew` 方法像 `firstOrCreate` 方法一样尝试通过给定的属性查找数据库中的记录。不同的是，如果`firstOrNew` 方法找不到对应的模型，会返回一个新的模型实例。注意 `firstOrNew` 返回的模型实例尚未保存到数据库中，你需要手动调用 `save` 方法来保存：

    // 通过 name 来查找航班，不存在则创建...
    $flight = App\Flight::firstOrCreate(['name' => 'Flight 10']);

    // 通过 name 查找航班，不存在则使用 name 和 delayed 属性创建...
    $flight = App\Flight::firstOrCreate(
        ['name' => 'Flight 10'], ['delayed' => 1]
    );

    //  通过 name 查找航班，不存在则创建一个实例...
    $flight = App\Flight::firstOrNew(['name' => 'Flight 10']);

    // 通过 name 查找航班，不存在则使用 name 和 delayed 属性创建一个实例...
    $flight = App\Flight::firstOrNew(
        ['name' => 'Flight 10'], ['delayed' => 1]
    );

#### `updateOrCreate`

你还可能遇到希望更新现有模型或在不存在的情况下则创建新的模型的情景。 Laravel 提供了 `updateOrCreate` 方法仅一个步骤就可以实现。跟 `firstOrCreate` 方法一样, `updateOrCreate` 匹配到对应模型，所以不需要调用 `save()`方法：

    // 如果有从奥克兰到圣地亚哥的航班，则价格定为99美元。
    // 如果没匹配到存在的模型，则创建一个。
    $flight = App\Flight::updateOrCreate(
        ['departure' => 'Oakland', 'destination' => 'San Diego'],
        ['price' => 99]
    );

<a name="deleting-models"></a>
## 删除模型

可以在模型实例上调用 `delete` 方法来删除实例：

    $flight = App\Flight::find(1);

    $flight->delete();

#### 通过主键删除模型

在上面的例子中，在调用 `delete` 之前需要先去数据库中查找对应的模型。事实上，如果你知道了模型的主键，你可以直接使用 `destroy` 方法来删除模型，而不用先去数据库中查找。 `destroy` 方法除了接受单个主键作为参数之外，还接受多个主键，或者使用数组，集合来保存多个主键：

    App\Flight::destroy(1);

    App\Flight::destroy(1, 2, 3);

    App\Flight::destroy([1, 2, 3]);

    App\Flight::destroy(collect([1, 2, 3]));

#### 通过查询删除模型

你也可以在模型上运行删除语句。在这个例子中，我们将删除所有标记为非活跃的航班。与批量更新一样，批量删除不会为删除的模型启动任何模型事件：

    $deletedRows = App\Flight::where('active', 0)->delete();

> {note} 通过 Eloquent 执行批量删除语句时，不会触发  `deleting` 和 `deleted` 模型事件。因此，在执行删除语句时，从不检索模型示例。



<a name="soft-deleting"></a>
### 软删除

除了真实删除数据库记录， Eloquent  也可以「软删除」模型。软删除的模型并不是真的从数据库中删除了。事实上，是在模型上设置了 `deleted_at` 属性并将其值写入数据库。如果 `deleted_at` 值非空，代表这个模型已被软删除。如果要开启模型软删除功能，你需要在模型上使用 `Illuminate\Database\Eloquent\SoftDeletes` trait：

    <?php

    namespace App;

    use Illuminate\Database\Eloquent\Model;
    use Illuminate\Database\Eloquent\SoftDeletes;

    class Flight extends Model
    {
        use SoftDeletes;
    }

> {tip}  `SoftDeletes` trait 会自动将 `deleted_at` 属性转换成  `DateTime` / `Carbon` 实例

当然，你需要把 `deleted_at` 字段添加到数据表中。 Laravel的 [数据库迁移](/docs/{{version}}/migrations) 有创建这个字段的方法：

    Schema::table('flights', function (Blueprint $table) {
        $table->softDeletes();
    });

那现在，当你在模型实例上使用 `delete` 方法， 当前日期时间会写入`deleted_at` 字段。同时，查询出来的结果也会自动排除已被软删除的记录。

你可以使用 `trashed` 方法来验证当前模型是否软删除：

    if ($flight->trashed()) {
        //
    }

<a name="querying-soft-deleted-models"></a>
### 查询软删除模型

#### 包括已软删除的模型

前面提到，查询结果会自动剔除已被软删除的结果。当然，你可以使用 `withTrashed` 方法来获取包括软删除模型在内的模型：

    $flights = App\Flight::withTrashed()
                    ->where('account_id', 1)
                    ->get();

 `withTrashed` 方法也可以用在 [关联](/docs/{{version}}/eloquent-relationships) 查询：

    $flight->history()->withTrashed()->get();

#### 检索软删除模型

`onlyTrashed` 方法  **只** 获取已软删除的模型：

    $flights = App\Flight::onlyTrashed()
                    ->where('airline_id', 1)
                    ->get();

#### 恢复软删除模型

有时会对软删除模型进行 「撤销」，在已软删除的数据上使用 `restore` 方法即可恢复到有效状态：

    $flight->restore();

你也可以在查询中使用 `restore` 方法，从而快速恢复多个模型。和其他批量」操作一样，这个操作不会触发模型的任何事件：

    App\Flight::withTrashed()
            ->where('airline_id', 1)
            ->restore();

类似 `withTrashed` 方法， `restore` 方法也用在 [关联](/docs/{{version}}/eloquent-relationships)上：

    $flight->history()->restore();

#### 永久删除

要真实删除数据时，使用`forceDelete` 方法即可:

    // 单个模型实例的永久删除...
    $flight->forceDelete();

    // 关联模型的永久删除...
    $flight->history()->forceDelete();

<a name="query-scopes"></a>
## 查询作用域

<a name="global-scopes"></a>
### 全局作用域

全局作用域可以给模型的查询都添加上约束。Laravel的  [软删除](#soft-deleting) 功能就是利用此特性从数据库中获取 「未删除」的模型。 你可以编写你自己的全局作用域，很简单、方便的为每个模型查询都加上约束条件：

#### 编写全局作用域

编写全局作用域很简单。定义一个实现 `Illuminate\Database\Eloquent\Scope` 接口的类，并实现 `apply` 这个方法。 根据你的需求，在`apply` 方法中加入查询的 `where` 条件：

    <?php

    namespace App\Scopes;

    use Illuminate\Database\Eloquent\Scope;
    use Illuminate\Database\Eloquent\Model;
    use Illuminate\Database\Eloquent\Builder;

    class AgeScope implements Scope
    {
        /**
         * 把约束加到 Eloquent 查询构造中。
         *
         * @param  \Illuminate\Database\Eloquent\Builder  $builder
         * @param  \Illuminate\Database\Eloquent\Model  $model
         * @return void
         */
        public function apply(Builder $builder, Model $model)
        {
            $builder->where('age', '>', 200);
        }
    }

> {tip}如果需要在 select 语句里添加字段，应使用 `addSelect` 方法，而不是 `select`方法。 这将有效防止无意中替换现有 select 语句的情况。



#### 应用全局作用域

要将全局作用域分配给模型，需要重写模型的 `boot` 方法并使用 `addGlobalScope` 方法：

    <?php

    namespace App;

    use App\Scopes\AgeScope;
    use Illuminate\Database\Eloquent\Model;

    class User extends Model
    {
        /**
         *  模型的 「启动」 方法.
         *
         * @return void
         */
        protected static function boot()
        {
            parent::boot();

            static::addGlobalScope(new AgeScope);
        }
    }

添加作用域后，对 `User::all()` 的查询会生成以下 SQL 查询语句：

    select * from `users` where `age` > 200

#### 匿名全局作用域

Eloquent 同样允许使用闭包定义全局作用域，这样就不需要为一个简单的作用域而编写一个单独的类：

    <?php

    namespace App;

    use Illuminate\Database\Eloquent\Model;
    use Illuminate\Database\Eloquent\Builder;

    class User extends Model
    {
        /**
         *模型的「启动」方法.
         *
         * @return void
         */
        protected static function boot()
        {
            parent::boot();

            static::addGlobalScope('age', function (Builder $builder) {
                $builder->where('age', '>', 200);
            });
        }
    }

#### 取消全局作用域

如果需要对当前查询取消全局作用域，需要使用 `withoutGlobalScope` 方法。 该方法仅接受全局作用域类名作为它唯一的参数：

    User::withoutGlobalScope(AgeScope::class)->get();

或者，如果使用闭包定义全局作用域的话：

    User::withoutGlobalScope('age')->get();

如果你需要取消部分或者全部的全局作用域的话，需要使用  `withoutGlobalScopes` 方法：

    // 取消所有的全局作用域...
    User::withoutGlobalScopes()->get();

    // 取消部分全局作用域...
    User::withoutGlobalScopes([
        FirstScope::class, SecondScope::class
    ])->get();

<a name="local-scopes"></a>
### 本地作用域

本地作用域允许定义通用的约束集合以便在应用程序中重复使用。例如，你可能经常需要获取所有 「流行」的用户。 要定义这样一个范围，只需要在对应的 Eloquent 模型方法前添加 `scope` 前缀：

作用域总是返回一个查询构造器实例：

    <?php

    namespace App;

    use Illuminate\Database\Eloquent\Model;

    class User extends Model
    {
        /**
         * 只查询受欢迎的用户的作用域.
         *
         * @param \Illuminate\Database\Eloquent\Builder $query
         * @return \Illuminate\Database\Eloquent\Builder
         */
        public function scopePopular($query)
        {
            return $query->where('votes', '>', 100);
        }

        /**
         * 只查询 active 用户的作用域.
         *
         * @param \Illuminate\Database\Eloquent\Builder $query
         * @return \Illuminate\Database\Eloquent\Builder
         */
        public function scopeActive($query)
        {
            return $query->where('active', 1);
        }
    }



#### 使用本地作用域

一旦定义了作用域，就可以在查询该模型时调用作用域方法。不过，在调用这些方法时不必包含 `scope` 前缀。甚至可以链式调用多个作用域，例如：

    $users = App\User::popular()->active()->orderBy('created_at')->get();

借助 `or` 查询运行符整合多个 Eloquent 模型，可能需要使用闭包回调：

    $users = App\User::popular()->orWhere(function (Builder $query) {
        $query->active();
    })->get();

因为这样可能会有点麻烦，Laravel 提供了「高阶的」 `orWhere` 方法，它允许你在链式调用作用域时不使用闭包：

    $users = App\User::popular()->orWhere->active()->get();

#### 动态作用域

有时可能地希望定义一个可以接受参数的作用域。把额外参数传递给作用域就可以达到此目的。作用域参数要放在 `$query` 参数之后：

    <?php

    namespace App;

    use Illuminate\Database\Eloquent\Model;

    class User extends Model
    {
        /**
         * 将查询作用域限制为仅包含给定类型的用户。
         *
         * @param  \Illuminate\Database\Eloquent\Builder $query
         * @param  mixed $type
         * @return \Illuminate\Database\Eloquent\Builder
         */
        public function scopeOfType($query, $type)
        {
            return $query->where('type', $type);
        }
    }

这样就可以在调用作用域时传递参数了：

    $users = App\User::ofType('admin')->get();

<a name="comparing-models"></a>
## 模型比较

有时可能需要判断两个模型是否「相同」。 `is` 方法可以用来快速校验两个模型是否拥有相同的主键、表和数据库连接：

    if ($post->is($anotherPost)) {
        //
    }

<a name="events"></a>
## 事件

Eloquent 模型触发几个事件，允许你挂接到模型生命周期的如下节点： `retrieved`、 `creating`、 `created`、 `updating`、 `updated`、 `saving`、 `saved`、 `deleting`、 `deleted`、 `restoring` 和 `restored`。事件允许你每当特定模型保存或更新数据库时执行代码。每个事件通过其构造器接受模型实例。

 `retrieved` 事件在现有模型从数据库中查找数据时触发。当新模型每一次保存时， `creating` 和 `created` 事件被触发。如果数据库中已经存在模型并且调用了 `save` 方法， `updating` / `updated` 事件被触发。这些情况下， `saving` / `saved` 事件也被触发。

> {note} 通过 Eloquent 进行批量更新时，被更新模型的 `saved` 和 `updated` 事件不会被触发。这是因为批量更新时，并没有真的获取模型。

首先，在 Eloquent 模型上定义一个 `$dispatchesEvents` 属性，将 Eloquent 模型生命周期的几个节点映射到你自己的 [event 类](/docs/{{version}}/events) ：

    <?php

    namespace App;

    use App\Events\UserSaved;
    use App\Events\UserDeleted;
    use Illuminate\Notifications\Notifiable;
    use Illuminate\Foundation\Auth\User as Authenticatable;

    class User extends Authenticatable
    {
        use Notifiable;

        /**
         * 为模型事件。
         *
         * @var array
         */
        protected $dispatchesEvents = [
            'saved' => UserSaved::class,
            'deleted' => UserDeleted::class,
        ];
    }

定义并且映射了 Eloquent 事件，就可以使用 [event 监听器listeners](/docs/{{version}}/events#defining-listeners) 处理这些事件了。



<a name="observers"></a>
### 观察者

#### 定义观察者

如果在一个模型上监听了多个事件，可以使用观察者来将这些监听器组织到一个单独的类中。观察者类的方法名映射到你希望监听的 Eloquent 事件。 这些方法都以模型作为其唯一参数。 `make:observer` Artisan 命令可以快速建立新的观察者类：

    php artisan make:observer UserObserver --model=User

此命令将在 `App/Observers` 文件夹放置新的观察者类。如果这个目录不存在，Artisan 将替你创建。使用如下方式开启观察者：

    <?php

    namespace App\Observers;

    use App\User;

    class UserObserver
    {
        /**
         * 处理 User 「新建」事件。
         *
         * @param  \App\User  $user
         * @return void
         */
        public function created(User $user)
        {
            //
        }

        /**
         * 处理 User 「更新」 事件。
         *
         * @param  \App\User  $user
         * @return void
         */
        public function updated(User $user)
        {
            //
        }

        /**
         * 处理 User 「删除」 事件。
         *
         * @param  \App\User  $user
         * @return void
         */
        public function deleted(User $user)
        {
            //
        }
    }

在你希望观察的模型上使用 `observe` 方法注册观察者。也可以在服务提供者的 `boot` 方法注册观察者。下面是在 `AppServiceProvider` 中注册观察者的示例：

    <?php

    namespace App\Providers;

    use App\User;
    use App\Observers\UserObserver;
    use Illuminate\Support\ServiceProvider;

    class AppServiceProvider extends ServiceProvider
    {
        /**
         * 启动应用服务。
         *
         * @return void
         */
        public function boot()
        {
            User::observe(UserObserver::class);
        }

        /**
         * 注册服务提供者。
         *
         * @return void
         */
        public function register()
        {
            //
        }
    }