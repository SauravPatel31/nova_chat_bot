class MessageModel {
  String? message;
  int? sendId;//0 for user 1 for bot
  String? sentTime;
  bool? isRead;

  MessageModel({this.message, this.sendId, this.sentTime,this.isRead=false  });
}