import 'package:flutter/material.dart';
import 'package:nova_chat/data/remote/api_helper.dart';
import 'package:nova_chat/model/gemini_response_model.dart';
import 'package:nova_chat/model/message_model.dart';


class MessageProvider with ChangeNotifier {

  final List<MessageModel> _messageList = [];
  bool isLoading = false;

  List<MessageModel> fetchAllMessages() {
    return _messageList;
  }

  void sendMessage({required String message}) async {
    // 1. Show user message immediately
    final userMessage = MessageModel(
      message: message,
      sendId: 0,
      sentTime: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    _messageList.insert(0, userMessage);
    notifyListeners();

    // 2. Get bot response from API
    final response = await ApiHelper().sendMsgApi(userMsg: message);

    if (response != null) {
      isLoading = true;
      notifyListeners();
      try {
        isLoading = true;
        notifyListeners();
        final botReply = GeminiResponseModel.fromJson(response);

        final botMessage = MessageModel(
          message: botReply.candidates[0].content.parts[0].text,
          sendId: 1,
          sentTime: DateTime.now().millisecondsSinceEpoch.toString(),
        );

        _messageList.insert(0, botMessage);
        isLoading = false;
        notifyListeners();
      } catch (e) {
        print("Bot response parsing error: $e");
      }
    } else {
      print("Bot response is null");
    }
  }

  void updateMsgRead({required int index}){
    _messageList[index].isRead=true;
  }
}
