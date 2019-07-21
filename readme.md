## 背景
这是一篇关于在项目开发过程中遇到的flutter问题集及解决方法，还有flutter的一些布局组合，当然，也有一些遇到的问题然后还没解决的，我会在这里提出希望朋友们知道解决方法的可以提出来，共同学习，共同进步，本文持续更新。

## 未解决问题
### 1、ios键盘调起白屏问题
描述： 输入框在屏幕最底部，在ios端点击输入框调起键盘时，输入框被推起（正常想要的结果），但是键盘在滑动过程中在键盘出现位置会先出现白屏

## 已解决问题
### 1、Android手机在屏幕顶部出现半透明黑条问题
问题如图所示：
![android顶部手机半透明黑条问题.png](https://user-gold-cdn.xitu.io/2019/7/21/16c14bc49b911522?w=686&h=82&f=png&s=89120)
解决：
```
// 第一步导入包依赖
import 'package:flutter/services.dart' show SystemUiOverlayStyle, SystemChrome;
import 'dart:io' show Platform;

// 第二步在main文件中入口main函数中实现
void main() {
  runApp(MyApp());
  // ios默认透明不用加，自定义手机顶部黑条样式（Android沉浸式）
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
```

### 2、圆角无效问题
使用Container包裹Column，然后设置Container圆角后，Column覆盖在Container上面导致看不到效果
## 布局