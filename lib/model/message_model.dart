class MessageModel {
  String? message;
  int? sendId;//0 for user 1 for bot
  String? sentTime;

  MessageModel({this.message, this.sendId, this.sentTime});
}