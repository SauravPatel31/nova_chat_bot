import 'package:flutter/material.dart';
import 'package:nova_chat/data/remote/api_helper.dart';
import 'package:nova_chat/model/gemini_response_model.dart';
import 'package:nova_chat/model/message_model.dart';


class MessageProvider with ChangeNotifier {

  final List<MessageModel> _messageList = [];

  List<MessageModel> fetchAllMessages() {
    return _messageList;
  }

  void sendMessage({required String message}) async {
    // 1. Add user message immediately
    final userMessage = MessageModel(
      message: message,
      sendId: 0,
      sentTime: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    _messageList.insert(0, userMessage);
    notifyListeners();

    // 2. Add temporary empty bot message (shows loader)
    final loadingMessage = MessageModel(
      message: "",
      sendId: 1,
      sentTime: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    _messageList.insert(0, loadingMessage);
    notifyListeners();

    // 3. Call API and replace the empty message with actual response
    final response = await ApiHelper().sendMsgApi(userMsg: message);

    if (response != null) {
      try {
        final botReply = GeminiResponseModel.fromJson(response);

        final botMessage = MessageModel(
          message: botReply.candidates[0].content.parts[0].text,
          sendId: 1,
          sentTime: DateTime.now().millisecondsSinceEpoch.toString(),
        );

        // Replace the first bot message (which is loader) with actual message
        _messageList.removeAt(0);
        _messageList.insert(0, botMessage);
        notifyListeners();
      } catch (e) {
        print("Bot response parsing error: $e");
      }
    } else {
      print("Bot response is null");
    }
  }


  void clearMessages() {
    _messageList.clear();
    notifyListeners();
  }


  void updateMsgRead({required int index}){
    _messageList[index].isRead=true;
  }
}
