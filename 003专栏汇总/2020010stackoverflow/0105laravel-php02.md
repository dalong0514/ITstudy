# 0104laravel-php

## 01. How Do I Get the Query Builder to Output Its Raw SQL Query as a String?

[php - How Do I Get the Query Builder to Output Its Raw SQL Query as a String? - Stack Overflow](https://stackoverflow.com/questions/18236294/how-do-i-get-the-query-builder-to-output-its-raw-sql-query-as-a-string)

Given the following code:

DB::table('users')->get();
I want to get the raw SQL query string that the database query builder above will generate. In this example, it would be SELECT * FROM users.

How do I do this?

php sql laravel laravel-4 laravel-query-builder
shareedit
edited Nov 17 '18 at 6:38

Karl Hill
5,26333 gold badges3232 silver badges5050 bronze badges
asked Aug 14 '13 at 15:43

meiryo
7,5331212 gold badges3939 silver badges4848 bronze badges
13
Laravel Eloquent ORM get raw query: echo User::where('status', 1)->toSql(); – Muhammad Shahzad Oct 8 '17 at 5:05
show 1 more comment
35 Answers
activeoldestvotes
1 2 next

614

To output to the screen the last queries ran you can use this:

DB::enableQueryLog(); // Enable query log

// Your Eloquent query executed by using get()

dd(DB::getQueryLog()); // Show results of log
I believe the most recent queries will be at the bottom of the array.

You will have something like that:

array(1) {
  [0]=>
  array(3) {
    ["query"]=>
    string(21) "select * from "users""
    ["bindings"]=>
    array(0) {
    }
    ["time"]=>
    string(4) "0.92"
  }
}
(Thanks to Joshua's comment below.)

shareedit
edited Dec 6 '19 at 9:17

Werner
2055 bronze badges
answered Aug 14 '13 at 15:59

jfortunato
7,26522 gold badges1515 silver badges1313 bronze badges
2
hmm im not sure but you may be able to accompish what you want with a composer package stackoverflow.com/a/17339752/813181 – jfortunato Aug 14 '13 at 16:22
9
Might even be better to output it to your application's log using the Log class: Log::debug(DB::getQueryLog()) – msturdy Aug 14 '13 at 16:51
34
You may need to enable this as it's turned off by default now. You can use this command to turn it on temporarily: DB::enableQueryLog(); – Joshua Fricke Jan 3 '16 at 20:51 
5
I tried your answer. What I tried is DB::enableQueryLog(); dd(DB::getQueryLog()); But it returns just [].... – I am the Most Stupid Person Aug 31 '17 at 4:51
5
If you have multiple databases, you may need to do DB::connection('database')->getQueryLog() – Damien Ó Ceallaigh Sep 27 '18 at 3:27
show 6 more comments

710

Use the toSql() method on a QueryBuilder instance.

DB::table('users')->toSql() would return:

select * from `users`

This is easier than wiring up an event listener, and also lets you check what the query will actually look like at any point while you're building it.

shareedit
edited Mar 3 '14 at 3:57
answered Dec 4 '13 at 18:24

Steven Mercatante
20.3k77 gold badges5757 silver badges9999 bronze badges
6
I think this is the easiest way when using Eloquent outside Laravel – Gab Feb 4 '14 at 3:29
8
@Stormsson That's not possible because PHP never has the query with the bindings replaced with their values. To get the queries in their entirety you need to log them from MySQL. There's more info here: stackoverflow.com/questions/1786322/… – Matthew Aug 31 '14 at 20:20
39
@Stormsson you can use getBindings method. This'll return the bindings in order that they'll be bound to the SQL statement. – danronmoon Oct 1 '15 at 18:26
2
Very helpful for debugging complicated queries that Eloquent refuses to run as those don't show up in the query log. – BobChao87 Mar 14 '16 at 19:53
27
To get query with bindinds $query = \DB::table('users')->where('id', 10); $sql = str_replace_array('?', $query->getBindings(), $query->toSql()); dd($sql); – Ennio Sousa Jul 13 '18 at 14:31 