enum IMItemType { speak, system }
enum MsgStatus { pending, success, failed, blocked}

class IMItemObject {
  String id;
  int uid;
  String nickname;
  String avatar;
  String text;
  IMItemType type;
  String timeStr;
  MsgStatus status;
  int time;

  IMItemObject(
      {this.id,
      this.uid,
      this.nickname,
      this.avatar,
      this.text,
      this.type,
      this.timeStr,
      this.status,
      this.time});
}
