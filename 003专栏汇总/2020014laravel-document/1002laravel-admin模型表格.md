# 0201模型表格

3『

[laravel-admin 后台框架基本使用 - 简书](https://www.jianshu.com/p/8c54354d8913)

### 1. 建立控制器

在 app/Admin/Controllers 新建对应的控制器来管理某个数据表。

下面的是系统自带的源码：
```
<?php

namespace App\Admin\Controllers;

use Encore\Admin\Controllers\AdminController;
use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Show;

class ExampleController extends AdminController
{
    /**
     * Title for current resource.
     *
     * @var string
     */
    protected $title = 'Example controller';

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        $grid = new Grid(new ExampleModel);

        $grid->column('id', __('ID'))->sortable();
        $grid->column('created_at', __('Created at'));
        $grid->column('updated_at', __('Updated at'));

        return $grid;
    }

    /**
     * Make a show builder.
     *
     * @param mixed   $id
     * @return Show
     */
    protected function detail($id)
    {
        $show = new Show(ExampleModel::findOrFail($id));

        $show->field('id', __('ID'));
        $show->field('created_at', __('Created at'));
        $show->field('updated_at', __('Updated at'));

        return $show;
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        $form = new Form(new ExampleModel);

        $form->display('id', __('ID'));
        $form->display('created_at', __('Created At'));
        $form->display('updated_at', __('Updated At'));

        return $form;
    }
}

```

控制器例子（文章作者的）：

```
<?php

namespace App\Admin\Controllers;

use Encore\Admin\Form;
use Encore\Admin\Grid;
use Encore\Admin\Facades\Admin;
use Encore\Admin\Layout\Content;
use App\Http\Controllers\Controller;
use Encore\Admin\Controllers\ModelForm;

class ExampleController extends Controller
{
    use ModelForm;

    /**
     * Index interface.
     *
     * @return Content
     */
    public function index()
    {
        return Admin::content(function (Content $content) {

            $content->header('header');
            $content->description('description');

            $content->body($this->grid());
        });
    }

    /**
     * Edit interface.
     *
     * @param $id
     * @return Content
     */
    public function edit($id)
    {
        return Admin::content(function (Content $content) use ($id) {

            $content->header('header');
            $content->description('description');

            $content->body($this->form()->edit($id));
        });
    }

    /**
     * Create interface.
     *
     * @return Content
     */
    public function create()
    {
        return Admin::content(function (Content $content) {

            $content->header('header');
            $content->description('description');

            $content->body($this->form());
        });
    }

    /**
     * Make a grid builder.
     *
     * @return Grid
     */
    protected function grid()
    {
        return Admin::grid(YourModel::class, function (Grid $grid) {

            $grid->id('ID')->sortable();

            $grid->created_at();
            $grid->updated_at();
        });
    }

    /**
     * Make a form builder.
     *
     * @return Form
     */
    protected function form()
    {
        return Admin::form(YourModel::class, function (Form $form) {

            $form->display('id', 'ID');

            $form->display('created_at', 'Created At');
            $form->display('updated_at', 'Updated At');
        });
    }
}
```

其中最重要的方法是 grid() 和 form() ，分别对应数据列表（表格）和数据表单的内容。建立控制器后，在 app\Admin\routes.php 加上相应的资源路由：

### 2. 生成模型表格

1、由于 laravel-admin 模型表格基于 laravel 的数据模型，所以首先需要建立数据表的对应数据模型。如：

php artisan make:model Models\Example -m

2、在控制器中 index() 是模型表格页面的入口，Admin::content 则可以在方法内设置本页面的内容。header 和 description 是页面的主、副标题，可按需设置。另外可看到本页面 body 的内容由 \$this->grid() 提供。

```
public function index()
    {
        return Admin::content(function (Content $content) {

            $content->header('页面主标题');
            $content->description('页面副标题');

            $content->body($this->grid());
        });
    }
```

3、grid() 方法用于构建基于数据模型的数据表格。首先要将 YourModel 改为真实的数据模型，然后就可以使用 \$grid 构建表单。每个 \$grid 代表一列数据，指向的是数据表字段名，括号内的是本列的标题名称。若括号内不填标题名称，则自动使用数据表字段名的字符串代替。

```
protected function grid()
    {
        return Admin::grid(YourModel::class, function (Grid $grid) {

            // 直接通过字段名`username`添加列
            $grid->username('用户名');
            // 效果和上面一样
            $grid->column('username', '用户名');
            //若需要经过复杂逻辑，可使用display方法修改输出
            $grid->gender('性别')->display(function($data){
                $result = '';
                $result = YourModel::$genderGroup[$data];
                return $result;
            });
            $grid->mobile_phone('手机');
            $grid->address('通讯地址');
        });
    }
```

4、数据表格最后一列默认是操作列，包含编辑按钮与删除按钮。如果需要自定义操作列，则可以把默认的操作列禁用，再进行自定义。

    $grid->disableActions();

### 3. 生成模型表单

控制器内的 created() 和 edit() 分别对应着模型表单的新增与编辑操作。并且新增、编辑表单共用控制器内的 form() 进行表单构建。

修改 form() 来构建表单内容：

\$form 指向的是表单控件类型（text 是文本域，radio 是单选框等），方法内第一个参数是数据表字段名，第二个参数是字段显示名称。

```
protected function form()
    {
        return Admin::form(Investor::class, function (Form $form) {
            //display仅作显示对应内容
            $form->display('id', 'ID');
            //文本域
            $form->text('name','姓名');
            //单选框，options方法是单选框内容，格式为key=>value的数组形式。
            $form->radio('gender','性别')->options(Investor::$genderGroup);
            //......
        });
    }
```

』

## 01. 基于数据模型的表格

Encore\Admin\Grid 类用于生成基于数据模型的表格，先来个例子，数据库中有 movies 表。

```
CREATE TABLE `movies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `director` int(10) unsigned NOT NULL,
  `describe` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rate` tinyint unsigned NOT NULL,
  `released` enum(0, 1),
  `release_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
```

对应的数据模型为 App\Models\Movie，下面的代码可以生成表 movies 的数据表格：

```
use App\Models\Movie;
use Encore\Admin\Grid;
use Encore\Admin\Facades\Admin;

$grid = new Grid(new Movie);

// 第一列显示id字段，并将这一列设置为可排序列
$grid->column('id', 'ID')->sortable();

// 第二列显示title字段，由于title字段名和Grid对象的title方法冲突，所以用Grid的column()方法代替
$grid->column('title');

// 第三列显示director字段，通过display($callback)方法设置这一列的显示内容为users表中对应的用户名
$grid->column('director')->display(function($userId) {
    return User::find($userId)->name;
});

// 第四列显示为describe字段
$grid->column('describe');

// 第五列显示为rate字段
$grid->column('rate');

// 第六列显示released字段，通过display($callback)方法来格式化显示输出
$grid->column('released', '上映?')->display(function ($released) {
    return $released ? '是' : '否';
});

// 下面为三个时间字段的列显示
$grid->column('release_at');
$grid->column('created_at');
$grid->column('updated_at');

// filter($callback)方法用来设置表格的简单搜索框
$grid->filter(function ($filter) {

    // 设置created_at字段的范围查询
    $filter->between('created_at', 'Created Time')->datetime();
});
```

### 1. 基本使用方法










添加列

// 直接通过字段名`username`添加列
$grid->username('用户名');

// 效果和上面一样
$grid->column('username', '用户名');

// 显示JSON内嵌字段
$grid->column('profile->mobile', '手机号');

// 添加多列
$grid->columns('email', 'username' ...);
添加数据查询条件
默认情况下，表格的数据没有任何查询条件，可以使用model()方法来给当前表格数据添加查询条件：

$grid->model()->where('id', '>', 100);

$grid->model()->whereIn('id', [1, 2, 3]);

$grid->model()->whereBetween('votes', [1, 100]);

$grid->model()->whereColumn('updated_at', '>', 'created_at');

$grid->model()->orderBy('id', 'desc');

$grid->model()->take(100);

...
$grid->model()后面可以直接调用Eloquent的查询方法来给表格数据添加查询条件，更多查询方法参考文档.

设置每页显示行数
// 默认为每页20条
$grid->paginate(15);
修改显示输出
$grid->column('text')->display(function($text) {
    return str_limit($text, 30, '...');
});

$grid->column('name')->display(function ($name) {
    return "<span class='label'>$name</span>";
});

$grid->column('email')->display(function ($email) {
    return "mailto:$email";
});

// 添加不存在的字段
$grid->column('column_not_in_table')->display(function () {
    return 'blablabla....';
});
display()方法接收的匿名函数绑定了当前行的数据对象，可以在里面调用当前行的其它字段数据

$grid->column('first_name');
$grid->column('last_name');

// 不存的字段列
$grid->column('full_name')->display(function () {
    return $this->first_name.' '.$this->last_name;
});
禁用创建按钮
$grid->disableCreateButton();
禁用分页条
$grid->disablePagination();
禁用查询过滤器
$grid->disableFilter();
禁用导出数据按钮
$grid->disableExport();
禁用行选择checkbox
$grid->disableRowSelector();
禁用行操作列
$grid->disableActions();
禁用行选择器
$grid->disableColumnSelector();
设置分页选择器选项
$grid->perPages([10, 20, 30, 40, 50]);
关联模型
一对一
users表和profiles表通过profiles.user_id字段生成一对一关联


CREATE TABLE `users` (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
`name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
`email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
`created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
`updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `profiles` (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
`user_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
`age` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
`gender` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
`created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
`updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
对应的数据模分别为:


class User extends Model
{
    public function profile()
    {
        return $this->hasOne(Profile::class);
    }
}

class Profile extends Model
{
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
通过下面的代码可以关联在一个grid里面:


$grid = new Grid(new User);

$grid->column('id', 'ID')->sortable();

$grid->column('name');
$grid->column('email');

$grid->column('profile.age');
$grid->column('profile.gender');

//or
$grid->profile()->age();
$grid->profile()->gender();

$grid->column('created_at');
$grid->column('updated_at');
一对多
posts表和comments表通过comments.post_id字段生成一对多关联


CREATE TABLE `posts` (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
`title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
`content` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
`created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
`updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `comments` (
`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
`post_id` int(10) unsigned NOT NULL,
`content` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
`created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
`updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
对应的数据模分别为:


class Post extends Model
{
    public function comments()
    {
        return $this->hasMany(Comment::class);
    }
}

class Comment extends Model
{
    public function post()
    {
        return $this->belongsTo(Post::class);
    }
}
通过下面的代码可以让两个模型在grid里面互相关联:


$grid = new Grid(new Post);

$grid->column('id', 'id')->sortable();
$grid->column('title');
$grid->column('content');

$grid->column('comments', '评论数')->display(function ($comments) {
    $count = count($comments);
    return "<span class='label label-warning'>{$count}</span>";
});

$grid->column('created_at');
$grid->column('updated_at');

return $grid;

$grid = new Grid(new Comment);
$grid->column('id');
$grid->column('post.title');
$grid->column('content');

$grid->column('created_at')->sortable();
$grid->column('updated_at');

return $grid;
多对多
users和roles表通过中间表role_users产生多对多关系


CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(190) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci

CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci

CREATE TABLE `role_users` (
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  KEY `role_users_role_id_user_id_index` (`role_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
对应的数据模分别为:


class User extends Model
{
    public function roles()
    {
        return $this->belongsToMany(Role::class);
    }
}

class Role extends Model
{
    public function users()
    {
        return $this->belongsToMany(User::class);
    }
}
通过下面的代码可以让两个模型在grid里面互相关联:


$grid = new Grid(new User);

$grid->column('id', 'ID')->sortable();
$grid->column('username');
$grid->column('name');

$grid->column('roles')->display(function ($roles) {

    $roles = array_map(function ($role) {
        return "<span class='label label-success'>{$role['name']}</span>";
    }, $roles);

    return join('&nbsp;', $roles);
});

$grid->column('created_at');
$grid->column('updated_at');