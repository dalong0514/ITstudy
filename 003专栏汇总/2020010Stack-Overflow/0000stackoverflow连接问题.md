# Stack Overflow

[Thomas Rientjes / decentraleyes · GitLab](https://git.synz.io/Synzvato/decentraleyes)

由于众所周知的原因，只需替换一个域名就可以继续使用Google提供的前端公共库了，

很多网站，尤其是国外网站，为了加快网站的速度，都是用了 Google 的 CDN。 但是在天朝，由于某些原因，导致全球最快的 CDN 变成了全球最慢的。

它将页面上Google公共库中的资源重定向到国内的源，可以解决Stack Overflow的这个问题。

[gooreplacer/guides.md at master · jiacai2050/gooreplacer](https://github.com/jiacai2050/gooreplacer/blob/master/doc/guides.md#%E8%BF%81%E7%A7%BB%E6%8C%87%E5%8D%97v10--v20)

[无需FQ，自建本地CDN，秒上StackOverFlow！ - 我是一只C++小小鸟 - 博客园](https://www.cnblogs.com/ittinybird/p/4857066.html)

[告别等待，秒开网站 | Kevin Wang](https://wkevin.gitee.io/it/speed.net/)

突然间网站又一下子可以打开了。但爬取不了。显示报错：Telnet console listening on 127.0.0.1:6023。查了说是代理的原因，才发现 StackOverFlow 可以不用翻墙上的。接着关闭代理，还是爬取不了。

多试了几次，突然又可以爬取了，到现在不清楚原因。但爬出的数据不对，不是按 votes 数量来的。接着有尝试 settings.py 里把 telnet console 关掉，又能正常爬取了，但怀疑是运气，因为之前有关过但哈长丝爬不了。（2020-03-11）

```
# disable the telnet console
TELNETCONSOLE_ENABLED = Fals
```



