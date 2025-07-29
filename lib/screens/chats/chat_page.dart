import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:nova_chat/screens/chats/message_provider.dart';
import 'package:provider/provider.dart';

import '../../model/message_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/text_style.dart';

class ChatPage extends StatefulWidget {
  final String? query;


  const ChatPage({super.key, this.query});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool hasSentQuery = false;
  @override
  void initState() {
    super.initState();
    if (!hasSentQuery && widget.query != null && widget.query!.isNotEmpty) {
      Provider.of<MessageProvider>(context, listen: false).sendMessage(message: widget.query!);
      hasSentQuery = true;
    }

  }
  @override
  Widget build(BuildContext context) {
    final TextEditingController questionController = TextEditingController();
    final DateFormat dateTimeFormat = DateFormat("hh:mm a");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MessageProvider>(context, listen: false);
      if (provider.fetchAllMessages().isEmpty && widget.query != null && widget.query!.isNotEmpty) {
        // Insert user message
        provider.sendMessage(message: widget.query!);
      }
    });


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: RichText(
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
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.primaryTextColor),
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
                        : _botChatBox(context, message, dateTimeFormat, index);
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
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  Provider.of<MessageProvider>(context, listen: false)
                      .sendMessage(message: value);
                  questionController.clear();
                }
              },
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
                    width: 35,
                    height: 35,
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
                hintStyle: myTextStyle14(color: Colors.grey),
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
                Flexible(child: Text(msgModel.message ?? '', style: myTextStyle14())),
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

  /// Bot Message Widget (with loading)
  Widget _botChatBox(BuildContext context, MessageModel msgModel, DateFormat format, int index) {
    final time = format.format(
      DateTime.fromMillisecondsSinceEpoch(int.parse(msgModel.sentTime!)),
    );

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
                Flexible(
                  child: msgModel.message!.isEmpty
                      ? Row(
                    children: const [
                      SizedBox(width: 6),
                      Text("Nova is typing", style: TextStyle(color: Colors.white)),
                      SizedBox(width: 5),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: SpinKitThreeBounce(
                          color: Colors.white,
                          size: 10.0,
                        ),
                      ),
                    ],
                  )
                      : msgModel.isRead!
                      ? Text(msgModel.message ?? '', style: myTextStyle14())
                      : AnimatedTextKit(
                    isRepeatingAnimation: false,
                    repeatForever: false,
                    onFinished: () {
                      context.read<MessageProvider>().updateMsgRead(index: index);
                    },
                    animatedTexts: [
                      TyperAnimatedText(
                        msgModel.message ?? '',
                        textStyle: myTextStyle14(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(time, style: myTextStyle11()),
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
