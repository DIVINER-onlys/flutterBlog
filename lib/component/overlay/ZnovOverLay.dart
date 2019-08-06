import 'package:flutter/material.dart';

class ZnovOverLay {
  static OverlayEntry _holder;

  static Widget view;

  static void remove() {
    if (_holder != null) {
      _holder.remove();
      _holder = null;
    }
  }

  static void show({@required BuildContext context, @required Widget view}) {
    ZnovOverLay.view = view;

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

  // 创建可拖动组件
  static _buildDraggable(context) {
    return new Draggable(
      child: view,
      feedback: view,
      onDragEnd: (detail) {
        print('onDragEnd:${detail.offset}');
        createDragTarget(offset: detail.offset, context: context);
      },
      childWhenDragging: Container(),
      ignoringFeedbackSemantics: false,
    );
  }

  static void refresh() {
    _holder.markNeedsBuild();
  }

  // 拖动结束，移除原本的Overlay创建一个新的Overlay
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
