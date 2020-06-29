# 1002. HTTP Tests

## 2.1 Introduction

Laravel provides a very fluent API for making HTTP requests to your application and examining the output. For example, take a look at the feature test defined below:

```php
<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithoutMiddleware;
use Tests\TestCase;

class ExampleTest extends TestCase
{
    /**
     * A basic test example.
     *
     * @return void
     */
    public function testBasicTest()
    {
        $response = $this->get('/');

        $response->assertStatus(200);
    }
}
```

The get method makes a GET request into the application, while the assertStatus method asserts that the returned response should have the given HTTP status code. In addition to this simple assertion, Laravel also contains a variety of assertions for inspecting the response headers, content, JSON structure, and more.

## 2.2 Customizing Request Headers

You may use the withHeaders method to customize the request's headers before it is sent to the application. This allows you to add any custom headers you would like to the request:

```php
<?php

class ExampleTest extends TestCase
{
    /**
     * A basic functional test example.
     *
     * @return void
     */
    public function testBasicExample()
    {
        $response = $this->withHeaders([
            'X-Header' => 'Value',
        ])->json('POST', '/user', ['name' => 'Sally']);

        $response
            ->assertStatus(201)
            ->assertJson([
                'created' => true,
            ]);
    }
}
```

The CSRF middleware is automatically disabled when running tests.

## 2.3 Cookies

You may use the withCookie or withCookies methods to set cookie values before making a request. The withCookie method accepts a cookie name and value as its two arguments, while the withCookies method accepts an array of name / value pairs:

```php
<?php

class ExampleTest extends TestCase
{
    public function testCookies()
    {
        $response = $this->withCookie('color', 'blue')->get('/');

        $response = $this->withCookies([
            'color' => 'blue',
            'name' => 'Taylor',
        ])->get('/');
    }
}
```

## 2.4 Debugging Responses

After making a test request to your application, the dump, dumpHeaders, and dumpSession methods may be used to examine and debug the response contents:

```php
<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithoutMiddleware;
use Tests\TestCase;

class ExampleTest extends TestCase
{
    /**
     * A basic test example.
     *
     * @return void
     */
    public function testBasicTest()
    {
        $response = $this->get('/');

        $response->dumpHeaders();

        $response->dumpSession();

        $response->dump();
    }
}
```

## 2.5 Session / Authentication

Laravel provides several helpers for working with the session during HTTP testing. First, you may set the session data to a given array using the withSession method. This is useful for loading the session with data before issuing a request to your application:

```php
<?php

class ExampleTest extends TestCase
{
    public function testApplication()
    {
        $response = $this->withSession(['foo' => 'bar'])
                         ->get('/');
    }
}
```

One common use of the session is for maintaining state for the authenticated user. The actingAs helper method provides a simple way to authenticate a given user as the current user. For example, we may use a model factory to generate and authenticate a user:

```php
<?php

use App\User;

class ExampleTest extends TestCase
{
    public function testApplication()
    {
        $user = factory(User::class)->create();

        $response = $this->actingAs($user)
                         ->withSession(['foo' => 'bar'])
                         ->get('/');
    }
}
```

You may also specify which guard should be used to authenticate the given user by passing the guard name as the second argument to the actingAs method:

```php
$this->actingAs($user, 'api')
```

## 2.6 Testing JSON APIs

Laravel also provides several helpers for testing JSON APIs and their responses. For example, the json, getJson, postJson, putJson, patchJson, deleteJson, and optionsJson methods may be used to issue JSON requests with various HTTP verbs. You may also easily pass data and headers to these methods. To get started, let's write a test to make a POST request to /user and assert that the expected data was returned:

```php
<?php

class ExampleTest extends TestCase
{
    /**
     * A basic functional test example.
     *
     * @return void
     */
    public function testBasicExample()
    {
        $response = $this->postJson('/user', ['name' => 'Sally']);

        $response
            ->assertStatus(201)
            ->assertJson([
                'created' => true,
            ]);
    }
}
```

The assertJson method converts the response to an array and utilizes PHPUnit::assertArraySubset to verify that the given array exists within the JSON response returned by the application. So, if there are other properties in the JSON response, this test will still pass as long as the given fragment is present.

In addition, JSON response data may be accessed as array variables on the response:

```php
$this->assertTrue($response['created']);
```

## 2.7 Verifying An Exact JSON Match

If you would like to verify that the given array is an exact match for the JSON returned by the application, you should use the assertExactJson method:

```php
<?php

class ExampleTest extends TestCase
{
    /**
     * A basic functional test example.
     *
     * @return void
     */
    public function testBasicExample()
    {
        $response = $this->json('POST', '/user', ['name' => 'Sally']);

        $response
            ->assertStatus(201)
            ->assertExactJson([
                'created' => true,
            ]);
    }
}
```

## 2.8 Verifying JSON Paths

If you would like to verify that the JSON response contains some given data at a specified path, you should use the assertJsonPath method:

```php
<?php

class ExampleTest extends TestCase
{
    /**
     * A basic functional test example.
     *
     * @return void
     */
    public function testBasicExample()
    {
        $response = $this->json('POST', '/user', ['name' => 'Sally']);

        $response
            ->assertStatus(201)
            ->assertJsonPath('team.owner.name', 'foo')
    }
}
```

## 2.9 Testing File Uploads

The Illuminate\Http\UploadedFile class provides a fake method which may be used to generate dummy files or images for testing. This, combined with the Storage facade's fake method greatly simplifies the testing of file uploads. For example, you may combine these two features to easily test an avatar upload form:

```php
<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;
use Tests\TestCase;

class ExampleTest extends TestCase
{
    public function testAvatarUpload()
    {
        Storage::fake('avatars');

        $file = UploadedFile::fake()->image('avatar.jpg');

        $response = $this->json('POST', '/avatar', [
            'avatar' => $file,
        ]);

        // Assert the file was stored...
        Storage::disk('avatars')->assertExists($file->hashName());

        // Assert a file does not exist...
        Storage::disk('avatars')->assertMissing('missing.jpg');
    }
}
```

### 2.9.1 Fake File Customization

When creating files using the fake method, you may specify the width, height, and size of the image in order to better test your validation rules:

```
UploadedFile::fake()->image('avatar.jpg', $width, $height)->size(100);
```

In addition to creating images, you may create files of any other type using the create method:

```php
UploadedFile::fake()->create('document.pdf', $sizeInKilobytes);
```

If needed, you may pass a \$mimeType argument to the method to explicitly define the MIME type that should be returned by the file:

```php
UploadedFile::fake()->create('document.pdf', $sizeInKilobytes, 'application/pdf');
```

## 2.10 Available Assertions

### 2.10.1 Response Assertions

Laravel provides a variety of custom assertion methods for your PHPUnit feature tests. These assertions may be accessed on the response that is returned from the json, get, post, put, and delete test methods:

```
assertCookie
assertCookieExpired
assertCookieNotExpired
assertCookieMissing
assertCreated
assertDontSee
assertDontSeeText
assertExactJson
assertForbidden
assertHeader
assertHeaderMissing
assertJson
assertJsonCount
assertJsonFragment
assertJsonMissing
assertJsonMissingExact
assertJsonMissingValidationErrors
assertJsonPath
assertJsonStructure
assertJsonValidationErrors
assertLocation
assertNoContent
assertNotFound
assertOk
assertPlainCookie
assertRedirect
assertSee
assertSeeInOrder
assertSeeText
assertSeeTextInOrder
assertSessionHas
assertSessionHasInput
assertSessionHasAll
assertSessionHasErrors
assertSessionHasErrorsIn
assertSessionHasNoErrors
assertSessionDoesntHaveErrors
assertSessionMissing
assertStatus
assertSuccessful
assertUnauthorized
assertViewHas
assertViewHasAll
assertViewIs
assertViewMissing
```

assertCookie

Assert that the response contains the given cookie:

```php
$response->assertCookie($cookieName, $value = null);
```

assertCookieExpired

Assert that the response contains the given cookie and it is expired:

```php
$response->assertCookieExpired($cookieName);
```

assertCookieNotExpired

Assert that the response contains the given cookie and it is not expired:

```php
$response->assertCookieNotExpired($cookieName);
```

assertCookieMissing

Assert that the response does not contains the given cookie:

```php
$response->assertCookieMissing($cookieName);
```

assertCreated

Assert that the response has a 201 status code:

```php
$response->assertCreated();
```

assertDontSee

Assert that the given string is not contained within the response. This assertion will automatically escape the given string unless you pass a second argument of false:

```php
$response->assertDontSee($value, $escaped = true);
```

assertDontSeeText

Assert that the given string is not contained within the response text. This assertion will automatically escape the given string unless you pass a second argument of false:

```php
$response->assertDontSeeText($value, $escaped = true);
```

assertExactJson

Assert that the response contains an exact match of the given JSON data:

```php
$response->assertExactJson(array $data);
```

assertForbidden

Assert that the response has a forbidden (403) status code:

```php
$response->assertForbidden();
```

assertHeader

Assert that the given header is present on the response:

```php
$response->assertHeader($headerName, $value = null);
```

assertHeaderMissing

Assert that the given header is not present on the response:

```php
$response->assertHeaderMissing($headerName);
```

assertJson

Assert that the response contains the given JSON data:

```php
$response->assertJson(array $data, $strict = false);
```

assertJsonCount

Assert that the response JSON has an array with the expected number of items at the given key:

```php
$response->assertJsonCount($count, $key = null);
```

assertJsonFragment

Assert that the response contains the given JSON fragment:

```php
$response->assertJsonFragment(array $data);
```

assertJsonMissing

Assert that the response does not contain the given JSON fragment:

```php
$response->assertJsonMissing(array $data);
```

assertJsonMissingExact

Assert that the response does not contain the exact JSON fragment:

```php
$response->assertJsonMissingExact(array $data);
```

assertJsonMissingValidationErrors

Assert that the response has no JSON validation errors for the given keys:

```php
$response->assertJsonMissingValidationErrors($keys);
```

assertJsonPath

Assert that the response contains the given data at the specified path:

```php
$response->assertJsonPath($path, array $data, $strict = false);
```

assertJsonStructure

Assert that the response has a given JSON structure:

```php
$response->assertJsonStructure(array $structure);
```

assertJsonValidationErrors

Assert that the response has the given JSON validation errors:

```php
$response->assertJsonValidationErrors(array $data);
```

assertLocation

Assert that the response has the given URI value in the Location header:

```php
$response->assertLocation($uri);
```

assertNoContent

Assert that the response has the given status code and no content.

```php
$response->assertNoContent($status = 204);
```

assertNotFound

Assert that the response has a not found status code:

```php
$response->assertNotFound();
```

assertOk

Assert that the response has a 200 status code:

```php
$response->assertOk();
```

assertPlainCookie

Assert that the response contains the given cookie (unencrypted):

```php
$response->assertPlainCookie($cookieName, $value = null);
```

assertRedirect

Assert that the response is a redirect to a given URI:

```php
$response->assertRedirect($uri);
```

assertSee

Assert that the given string is contained within the response. This assertion will automatically escape the given string unless you pass a second argument of false:

```php
$response->assertSee($value, $escaped = true);
```

assertSeeInOrder

Assert that the given strings are contained in order within the response. This assertion will automatically escape the given strings unless you pass a second argument of false:

```php
$response->assertSeeInOrder(array $values, $escaped = true);
```

assertSeeText

Assert that the given string is contained within the response text. This assertion will automatically escape the given string unless you pass a second argument of false:

```php
$response->assertSeeText($value, $escaped = true);
```

assertSeeTextInOrder

Assert that the given strings are contained in order within the response text. This assertion will automatically escape the given strings unless you pass a second argument of false:

```php
$response->assertSeeTextInOrder(array $values, $escaped = true);
```

assertSessionHas

Assert that the session contains the given piece of data:

```php
$response->assertSessionHas($key, $value = null);
```

assertSessionHasInput

Assert that the session has a given value in the flashed input array:

```php
$response->assertSessionHasInput($key, $value = null);
```

assertSessionHasAll

Assert that the session has a given list of values:

```php
$response->assertSessionHasAll(array $data);
```

assertSessionHasErrors

Assert that the session contains an error for the given \$keys. If \$keys is an associative array, assert that the session contains a specific error message (value) for each field (key):

```php
$response->assertSessionHasErrors(array $keys, $format = null, $errorBag = 'default');
```

assertSessionHasErrorsIn

Assert that the session contains an error for the given \$keys, within a specific error bag. If \$keys is an associative array, assert that the session contains a specific error message (value) for each field (key), within the error bag:

```php
$response->assertSessionHasErrorsIn($errorBag, $keys = [], $format = null);
```

assertSessionHasNoErrors

Assert that the session has no errors:

```php
$response->assertSessionHasNoErrors();
```

assertSessionDoesntHaveErrors

Assert that the session has no errors for the given keys:

```php
$response->assertSessionDoesntHaveErrors($keys = [], $format = null, $errorBag = 'default');
```

assertSessionMissing

Assert that the session does not contain the given key:

```php
$response->assertSessionMissing($key);
```

assertStatus

Assert that the response has a given code:

```php
$response->assertStatus($code);
```

assertSuccessful

Assert that the response has a successful (>= 200 and < 300) status code:

```php
$response->assertSuccessful();
```

assertUnauthorized

Assert that the response has an unauthorized (401) status code:

```php
$response->assertUnauthorized();
```

assertViewHas

Assert that the response view was given a piece of data:

```php
$response->assertViewHas($key, $value = null);
```

In addition, view data may be accessed as array variables on the response:

```php
$this->assertEquals('Taylor', $response['name']);
```

assertViewHasAll

Assert that the response view has a given list of data:

```php
$response->assertViewHasAll(array $data);
```

assertViewIs

Assert that the given view was returned by the route:

```php
$response->assertViewIs($value);
```

assertViewMissing

Assert that the response view is missing a piece of bound data:

```php
$response->assertViewMissing($key);
```

## 2.11 Authentication Assertions

Laravel also provides a variety of authentication related assertions for your PHPUnit feature tests:

1『此处有张表，有需求的时候可以看看。』
