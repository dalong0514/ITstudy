## 01. 解析 html

用的第三方包：

[wrakky/react-html-parser: Converts HTML strings directly into React components and provide a simple way to modify and replace the content.](https://github.com/wrakky/react-html-parser)

[javascript - How to parse html to React component? - Stack Overflow](https://stackoverflow.com/questions/44643424/how-to-parse-html-to-react-component)

目前已经实现的源码（2021-04-26）。

```js
export default observer(() => {
  const store = useLocalStore(() => new Store())

  const getExplainData = async (key) => {
    await store.getDocumentExplain(key)
  }

  return (
    <div className={styles.homeContainer}>
      <Tabs defaultActiveKey="1" onChange={getExplainData}>
        <TabPane tab="流程相关说明" key="1">
          <div>{ReactHtmlParser(store.tab_content)}</div>
        </TabPane>
        <TabPane tab="布置相关说明" key="2">
          <div>{ReactHtmlParser(store.tab_content)}</div>
        </TabPane>
        <TabPane tab="技巧汇总" key="3">
          <div>{ReactHtmlParser(store.tab_content)}</div>
        </TabPane>
      </Tabs>
    </div>

  )
})
```
