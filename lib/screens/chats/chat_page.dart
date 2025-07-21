import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:nova_chat/data/remote/api_helper.dart';
import 'package:nova_chat/screens/chats/message_provider.dart';
import 'package:provider/provider.dart';

import '../../model/message_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/text_style.dart';

class ChatPage extends StatelessWidget {
  final String query;
  const ChatPage({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    final TextEditingController questionController = TextEditingController();
    final DateFormat dateTimeFormat = DateFormat("hh:mm a");

    // Call once when page opens to show initial message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MessageProvider>(context, listen: false);
      if (provider.fetchAllMessages().isEmpty) {
        provider.sendMessage(message: query);
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            RichText(
              text: TextSpan(
                text: "Nova",
                children: [
                  TextSpan(
                    text: " Chat",
                    style: myTextStyle22(color: AppColors.secondaryColor),
                  ),
                ],
                style: myTextStyle22(),
              ),
            ),
            const Icon(Icons.align_vertical_bottom, color: Colors.green),
          ],
        ),
      ),
      body: Column(
        children: [
          /// Chat Messages
          Expanded(
            child: Consumer<MessageProvider>(
              builder: (_, provider, __) {
                final messageList = provider.fetchAllMessages();
                return ListView.builder(
                  reverse: true,
                  itemCount: messageList.length,
                  itemBuilder: (_, index) {
                    final message = messageList[index];
                    return message.sendId == 0
                        ? _userChatBox(context, message, dateTimeFormat)
                        : _botChatBox(context, message, dateTimeFormat,index);
                  },
                );
              },
            ),
          ),

          /// Ask a question
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: questionController,
              style: myTextStyle14(),
              cursorColor: AppColors.primaryTextColor,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    final value = questionController.text.trim();
                    if (value.isNotEmpty) {
                      Provider.of<MessageProvider>(context, listen: false)
                          .sendMessage(message: value);
                      questionController.clear();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.secondaryColor,
                    ),
                    child: const Icon(Icons.send, size: 15, color: AppColors.primaryTextColor),
                  ),
                ),
                filled: true,
                fillColor: AppColors.secondaryBgColor,
                hintText: "Chat with Nova",
                hintStyle: myTextStyle14(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// User Message Widget
  Widget _userChatBox(BuildContext context, MessageModel msgModel, DateFormat format) {
    final time = format.format(
      DateTime.fromMillisecondsSinceEpoch(int.parse(msgModel.sentTime!)),
    );

    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.2),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(11),
            margin: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: AppColors.chatBubbleUserColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
                bottomLeft: Radius.circular(22),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //message
                Flexible(child: Text(msgModel.message ?? '', style: myTextStyle14())),
                //time
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(time, style: myTextStyle10()),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Bot Message Widget
  Widget _botChatBox(BuildContext context, MessageModel msgModel, DateFormat format, int index) {
    final time = format.format(
      DateTime.fromMillisecondsSinceEpoch(int.parse(msgModel.sentTime!)),
    );

    final isLoading = context.watch<MessageProvider>().isLoading;

    return Row(
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(11),
            margin: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: AppColors.chatBubbleBotColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(22),
                topLeft: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                context.watch<MessageProvider>().isLoading
                    ? SpinKitThreeBounce(
                  color: Colors.red,
                  size: 50,
                ): Flexible(
                  child: msgModel.isRead! ? Text(msgModel.message ?? '', style: myTextStyle14(),) : AnimatedTextKit(isRepeatingAnimation: false,
                    repeatForever: false,
                    onFinished: () {
                      context.read<MessageProvider>().updateMsgRead(index: index);
                    },
                    //context.watch<MessageProvider>().isLoading?SpinKitThreeBounce(color: Colors.green,size: 25.0,):
                    animatedTexts:[TyperAnimatedText(msgModel.message ?? '',
                      textStyle: myTextStyle14(),
                      speed: const Duration(milliseconds: 100),
                    ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    time,
                    style: myTextStyle11(),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.2),
      ],
    );
  }

}
