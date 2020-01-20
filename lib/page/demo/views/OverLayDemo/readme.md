# Flutter 实战系列: 实现顶级视图可拖动悬浮窗

## 前言
本文是转自【作者：YY Live-曹庭君】，原文[Flutter 实战系列: 实现顶级视图可拖动悬浮窗](https://km.yy.com/blogs/3217),

仅做学习作用！！！
## 需求描述
这个需求有两个关键点：
* 顶级视图
* 可拖动

## 涉及 Widget 知识点
* Overlay，顶级视图解决方案
* Draggable，可拖动解决方案

## Overlay
Overlay 之于 Flutter , 有点相当于 KeyWindow 之于 iOS 一样，可以将子 widget 置于其他 widget 的顶层，带来 悬浮的效果，具体可见注释：
```dart
    /// A [Stack] of entries that can be managed independently.
    ///
    /// Overlays let independent child widgets "float" visual elements on top of
    /// other widgets by inserting them into the overlay's [Stack]. The overlay lets
    /// each of these widgets manage their participation in the overlay using
    /// [OverlayEntry] objects.
    /// Rather than creating an overlay, consider using the overlay that is
    /// created by the [WidgetsApp] or the [MaterialApp] for the application.
```
文档不建议我们重新初始化一个 overlay 对象 , 最好还是通过 Overlay.of(context)，这样的方式去获取已经存在的 Overlay 对象。

这里就又引出了另外一个新概念 OverlayEntry

## OverlayEntry
OverlayEntry 之于 Overlay，对于 iOS 开发而言，又有点 subView 之于 KeyWindow 的味道了。 OverlayEntry 是视图的实际的容器， 把其往 Overlay 那儿添加了，就可以成像了。
```dart
    /// Creates an overlay entry.
    ///
    /// To insert the entry into an [Overlay], first find the overlay using
    /// [Overlay.of] and then call [OverlayState.insert]. To remove the entry,
    /// call [remove] on the overlay entry itself.
    OverlayEntry({
        @required this.builder,         // builder 模式返回一个 widget
        bool opaque = false,            // 是否不透明
        bool maintainState = false, // 这个属性与 opaque 有关系，如果某个 entry A的 opaque 被设成 true 了， 那么 overlay 就不去 build 其他在层级在 entry A 以下的 entry 了， 除非 maintainState 设成 true
      }) : assert(builder != null),
           assert(opaque != null),
           assert(maintainState != null),
           _opaque = opaque,
           _maintainState = maintainState;
```
## Draggable
```dart
     const Draggable({
      Key key,
      @required this.child,             // 初始化显示的 widget
      @required this.feedback,      // 拖拽过程中（活动中）显示的 widget
      this.data,                                    // widget 携带的数据，放手时可以将这个 data 数据传递出去
      this.axis,                                    // 限制 draggable 的移动范围
      this.childWhenDragging,           // 拖住动作发生过程中，初始化位置显示的 widget
      this.feedbackOffset = Offset.zero, // 当 feedback 与 child 相比，有 transform 的时候，需要用到这个属性来调整 hittest 范围
      this.dragAnchor = DragAnchor.child, //锚点
      this.affinity,                            // 单词的意思是亲和力，当 Draggable 位于 另外一个 Scrollable 控件內时，来控制到底这个这个拖拽事件到底由 Draggable 响应，还是由 Scrollable 控件来响应
      this.maxSimultaneousDrags,    // 限制有多少个 Draggable 同时发生 拖拽动作
      this.onDragStarted,                   // 拖拽动作开始回调
      this.onDraggableCanceled,     // 拖拽动作取消回调
      this.onDragEnd,                           //拖拽动作结束回调
      this.onDragCompleted,             // 拖拽动作完成回调, 并被一个 DragTarget 接收
      this.ignoringFeedbackSemantics = true, // 也是看了文档才知道，这个属性还是有点用的，当 feedback 跟 child 是同一个 widget A 对象时，就应该把这个属性设成 false, 配合赋值一个 GlobalKey，这样，这个 widget A 就不会在 feedback 跟 child 切换时，重新销毁后又创建了。这个在 widget A 带有播放动画是比较容易看出区别，每次手指拖放都伴随着动画的重新开始
     }) 
```
一开始只留意到 feedback， childWhenDragging， onDragEnd 几个参数，实际上 ignoringFeedbackSemantics 也是挺重要的，这个放在后面再说。

把我们想要实现拖拽功能的 widget 传到 child 参数位置的时候，跑一下，可以发现，我们已经实现了拖拽功能了，但这个时候，当我们手指离开屏幕的话，child 又自动回到了初始化的位置了，并没有停留在我们想要他停留的位置，为了实现这个功能，我们又得用到另外一个 widget : DragTarget

## DragTarget
```dart
      const DragTarget({
        Key key,
        @required this.builder,  //根据 Draggable 传过来的 data ,来显示想要的 widget
        this.onWillAccept,          // 根据传过来的 data ,选择是否接收这个 Draggable， 返回 true 则激活 onAccept
        this.onAccept,                  // Draggable 被丢进了这个 DragTarget 区域后回调
        this.onLeave,                       // Draggable 离开 DragTarget 区域后的回调
      }) : super(key: key);
```
DragTarget 是用来作为 Draggable 被拖拽结束后接收他的区域, 当然 他可以通过 onWillAccept 的 data ,来选择 接不接收这个 Draggable 。

好了，前面搬文档说了一大堆废话，下面，我们来将这个几个 widget 组合运用起来，实现文章一开始的需求。

## 组合起来
关键代码：
```dart
    static void show({@required BuildContext context, @required Widget view}) {
      TestOverLay.view = view;

        //避免重复 show
      remove();

      //创建一个OverlayEntry对象
      OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
        //通过 Positioned 控制 位置
        return new Positioned(
            top: MediaQuery.of(context).size.height * 0.7,
            child: _buildDraggable(context));
        });

      //往当前 Overlay 中插入 OverlayEntry
      Overlay.of(context).insert(overlayEntry);

      _holder = overlayEntry;
    }
```
show 方法无非做了 2 件事：

* _buildDraggable
* 创建 OverlayEntry， 并插入到当前上下文的 Overlay

再看下 _buildDraggable
```dart
    static _buildDraggable(context) {
      return new Draggable(
        child: view,                                        //  child 跟 feedback 用传入同一个 view，这样初始化跟拖拽过程都显示这个 view
        feedback: view,                                 //
        onDragStarted: () {
        print('onDragStarted:');
      },
        onDragEnd: (detail) {
          print('onDragEnd:${detail.offset}');
          createDragTarget(offset: detail.offset, context: context); // 放手的时候创建一个DragTarget
        },
        childWhenDragging: Container(), //  这里传个 Container，原来位置啥都不显示
        );
    }
```
放手的时候创建一个 DragTarget对象，用来接收 Draggable
```dart
    static void createDragTarget({Offset offset, BuildContext context}) {
      if (_holder != null) {
        _holder.remove();
      }

      _holder = new OverlayEntry(builder: (context) {
        bool isLeft = true;
        if (offset.dx + 100 > MediaQuery.of(context).size.width / 2) {
          isLeft = false;
        }

        double maxY = MediaQuery.of(context).size.height - 100;

        return new Positioned(
            top: offset.dy < 50 ? 50 : offset.dy < maxY ? offset.dy : maxY,
            left: isLeft ? 0 : null,
            right: isLeft ? null : 0,
            child: DragTarget(
              onWillAccept: (data) {
                print('onWillAccept: $data');
                return true;
              },
              onAccept: (data) {
                holded = true;
                print('onAccept: $data');
                // refresh();
              },
              onLeave: (data) {
                print('onLeave');
              },
              builder: (BuildContext context, List incoming, List rejected) {
                return _buildDraggable(context);
              },
            ));
      });
      Overlay.of(context).insert(_holder);
    }
```
这里也是通过 Positioned 来给 DragTarget 指定位置的，需求对 Draggable 携带的 data 不关心，来者不拒，所以 onWillAccept 那儿直接 return true了；

当接收了 Draggable 后，在 builder 返回想要显示的内容，这里，我们直接返回之前那个 Draggable 对象好了，为下次的拖拽做好准备。

到此为止，整个流程就结束了。

这里看下初步实现效果：

![初步效果](https://user-gold-cdn.xitu.io/2019/8/6/16c670622a8b6ccd?w=360&h=240&f=gif&s=559713)

## 优化
细心的同学可以很容易会发现，每次拖拽动作的开始，结束的时候，view 的旋转动画都会被重置，体验并不友好。看了下日志就知道，在这两个时刻, 都会触发 view 的重建和销毁：
![](https://user-gold-cdn.xitu.io/2019/8/6/16c670622ab87860?w=1472&h=626&f=png&s=114566)


## ignoringFeedbackSemantics
文档提示我们，当 Draggable 的 child跟feedback相同时， ignoringFeedbackSemantics = false ，与 GlobalKey 配合使用，可以让 feedback 在 child 切换时，所对应 widget 不被 销毁 和 重新创建，这样设置后，再看下日志
![](https://user-gold-cdn.xitu.io/2019/8/6/16c6705c866ab618?w=1278&h=554&f=png&s=89610)

onDragStated,onDragEnd,虽然也触发了 MiniRoomFloatingWidget 的 build 方法，但并没有销毁及重创建。

在来看下优化后的效果：
![](https://user-gold-cdn.xitu.io/2019/8/6/16c6706d2cdac90d?w=360&h=240&f=gif&s=767938)


## 最后附上代码
```dart
    import 'package:flutter/material.dart';

    class TestOverLay {
      static OverlayEntry _holder;

      static Widget view;

      static void remove() {
        if (_holder != null) {
          _holder.remove();
          _holder = null;
        }
      }

      static void show({@required BuildContext context, @required Widget view}) {
        TestOverLay.view = view;

        remove();
        //创建一个OverlayEntry对象
        OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
          return new Positioned(
              top: MediaQuery.of(context).size.height * 0.7,
              child: _buildDraggable(context));
        });

        //往Overlay中插入插入OverlayEntry
        Overlay.of(context).insert(overlayEntry);

        _holder = overlayEntry;
      }

      static _buildDraggable(context) {
        return new Draggable(
          child: view,
          feedback: view,
          onDragStarted: (){
            print('onDragStarted:');
          },
          onDragEnd: (detail) {
            print('onDragEnd:${detail.offset}');
            createDragTarget(offset: detail.offset, context: context);
          },
          childWhenDragging: Container(),
        );
      }

      static void refresh() {
        _holder.markNeedsBuild();
      }

      static void createDragTarget({Offset offset, BuildContext context}) {
        if (_holder != null) {
          _holder.remove();
        }

        _holder = new OverlayEntry(builder: (context) {
          bool isLeft = true;
          if (offset.dx + 100 > MediaQuery.of(context).size.width / 2) {
            isLeft = false;
          }

          double maxY = MediaQuery.of(context).size.height - 100;

          return new Positioned(
              top: offset.dy < 50 ? 50 : offset.dy < maxY ? offset.dy : maxY,
              left: isLeft ? 0 : null,
              right: isLeft ? null : 0,
              child: DragTarget(
                onWillAccept: (data) {
                  print('onWillAccept: $data');
                  return true;
                },
                onAccept: (data) {
                  print('onAccept: $data');
                  // refresh();
                },
                onLeave: (data) {
                  print('onLeave');
                },
                builder: (BuildContext context, List incoming, List rejected) {
                  return _buildDraggable(context);
                },
              ));
        });
        Overlay.of(context).insert(_holder);
      }
    }
```