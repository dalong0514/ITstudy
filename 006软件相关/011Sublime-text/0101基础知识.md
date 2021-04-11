# 0101基本信息

[Documentation - Sublime Text](http://www.sublimetext.com/docs/3/)



## 常规操作

1、窗口间的切换，option + command + 左右键。

2、整块整块注释代码。选中代码后直接快捷键「command+/」，取消注释的话再用一下这个快捷键。

## 基本设置

```
// Settings in here override those in "Default/Preferences.sublime-settings",
// and are overridden in turn by syntax-specific settings.
{
    // set vertical rulers in specified columns.
    // Use "rulers": [80] for just one ruler
    // default value is []
    "rulers": [80, 100, 120],

    // turn on word wrap for source and text
    // default value is "auto", which means off for source and on for text
    "word_wrap": true,

    // set word wrapping at this column
    // default value is 0, meaning wrapping occurs at window width
    "wrap_width": 80,

	"tab_size": 4,
	"translate_tabs_to_spaces": true,
	"expand_tabs_on_save": true
}

```

上面的设置顺序很重要，rulers 的设置一定要在最前面。


[formatting - 80-characters / right margin line in Sublime Text 3 - Stack Overflow](https://stackoverflow.com/questions/25900954/80-characters-right-margin-line-in-sublime-text-3)