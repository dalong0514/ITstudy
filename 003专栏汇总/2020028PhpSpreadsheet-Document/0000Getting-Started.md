# Getting started

## 01. Software requirements

PHP version 7.2 or newer to develop using PhpSpreadsheet. Other requirements, such as PHP extensions, are enforced by composer. See the require section of the composer.json file for details.

## 02. PHP version support

Support for PHP versions will only be maintained for a period of six months beyond the end of life of that PHP version.

## 03. Installation

Use composer to install PhpSpreadsheet into your project:

```
composer require phpoffice/phpspreadsheet
```

Or also download the documentation and samples if you plan to use them:

```
composer require phpoffice/phpspreadsheet --prefer-source
```

## 04. Hello World

This would be the simplest way to write a spreadsheet:

```
<?php

require 'vendor/autoload.php';

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

$spreadsheet = new Spreadsheet();
$sheet = $spreadsheet->getActiveSheet();
$sheet->setCellValue('A1', 'Hello World !');

$writer = new Xlsx($spreadsheet);
$writer->save('hello world.xlsx');
```

1『

laravel 的入口文件（public/index.php）里设置自动加载。

```
/*
|--------------------------------------------------------------------------
| Register The Auto Loader
|--------------------------------------------------------------------------
|
| Composer provides a convenient, automatically generated class loader for
| our application. We just need to utilize it! We'll simply require it
| into the script here so that we don't have to worry about manual
| loading any of our classes later on. It feels great to relax.
|
*/

require __DIR__.'/../vendor/autoload.php';
```

接着直接在控制器里写：

```php
    public function test()
    {
        $spreadsheet = new Spreadsheet();
        $sheet = $spreadsheet->getActiveSheet();
        $sheet->setCellValue('A1', 'Hello World !');
        
        $writer = new Xlsx($spreadsheet);
        dd($writer);
        $writer->save('hello.xlsx');
    }
```

public 文件夹下会自动生成 hello.xlsx 文件。

』

## 05. Learn by example

A good way to get started is to run some of the samples. Don't forget to download them via --prefer-source composer flag. And then serve them via PHP built-in webserver:

```
php -S localhost:8000 -t vendor/phpoffice/phpspreadsheet/samples
```

Then point your browser to:

http://localhost:8000/

The samples may also be run directly from the command line, for example:

```
php vendor/phpoffice/phpspreadsheet/samples/Basic/01_Simple.php
```

## 06. Learn by documentation

For more in-depth documentation, you may read about an overview of the architecture, creating a spreadsheet, worksheets, accessing cells and reading and writing to files. Or browse the API documentation.