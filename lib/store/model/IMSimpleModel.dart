import 'package:flutter/foundation.dart' show ChangeNotifier;

import 'package:flutter_blog/store/object/IMItemObject.dart';

class IMSimpleModel extends ChangeNotifier {
  int _sendIndex; // 当前发言人索引
  List<IMItemObject> IMItemList; // 对话列表

  IMSimpleModel() {
    init();
  }

  void init() {
    _sendIndex = 0;
    IMItemList = [];
  }

  int get sendIndex => _sendIndex;

  // 修改当前发言人索引
  void changeSendIndex(){
    _sendIndex = _sendIndex>=1 ? 0 : _sendIndex+1;
    notifyListeners();
  }

  // push一条IM记录
  void pushIMItemList(IMItemObject item) {
    IMItemList.insert(0, item);
    // computeTimeStr(IMItemList);
    notifyListeners();
    // scrollToBottom();
  }
}