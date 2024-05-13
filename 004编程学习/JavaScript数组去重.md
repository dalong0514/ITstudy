## 01. Reduce 实现

信息源自「2021060Learning-React0301.md」

We can even transform arrays into completely different arrays using reduce. Consider reducing an array with multiple instances of the same value to an array of unique values. The reduce method can be used to accomplish this task:

```js
const colors = ["red", "red", "green", "blue", "green"]; 
const uniqueColors = colors.reduce((unique, color) =>
  unique.indexOf(color) !== -1 ? unique : [...unique, color],
  []
);

console.log(uniqueColors);
// ["red", "green", "blue"]
```

2『又获得了一个数组去重的实现，做一张任意卡片。（2021-05-01）』

In this example, the colors array is reduced to an array of distinct values. The second argument sent to the reduce function is an empty array. This will be the initial value for distinct. When the distinct array does not already contain a specific color, it will be added.

Otherwise, it will be skipped, and the current distinct array will be returned. map and reduce are the main weapons of any functional programmer, and JavaScript is no exception. If you want to be a proficient JavaScript engineer, then you must master these functions. The ability to create one dataset from another is a required skill and is useful for any type of programming paradigm.

## 02. Map 映射 => Set 去重 => Set 转数组

数组相关的函数，更详细的可以参考官方文档：[索引集合类 (Indexed collections) - JavaScript | MDN](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Guide/Indexed_collections#map%E6%95%B0%E7%BB%84)。

数据流开发时的几个应用场景。map() 根据单体号映射数组，然后通过 Set 去重，最后 Set 转数组。

```js
// 获取单项号，map 映射数组，并通过 Set 去重
getMonomer(data) {
  let temp = data.map(item => item.project_id);
  this.restaurants = new Set(temp);
  // Set 转数组
  this.restaurants = [...this.restaurants];
},
// 获取特定单项号的数据
getMonomerData() {
  this.confirmdata = this.roomdata.filter(item => item.project_id === this.searchvalue);
  console.log(this.confirmdata);
},
```