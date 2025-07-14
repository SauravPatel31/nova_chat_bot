import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/message_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/text_style.dart';

class ChatPage extends StatefulWidget {
  String query;
   ChatPage({required this.query});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController questionController=TextEditingController();
  List<MessageModel> messageList = [];

  DateFormat dateTimeFormat = DateFormat("hh:mm a");

  @override
  void initState() {
    super.initState();
    messageList.add(MessageModel(message: widget.query,sendId: 0,sentTime: DateTime.now().millisecondsSinceEpoch.toString()));
    messageList.add(MessageModel(message: "This is a sample message from bot side of the chat app please ignore it.",sendId: 1,sentTime: DateTime.now().millisecondsSinceEpoch.toString()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title:Row(
          children: [
            RichText(
              text: TextSpan(
                  text: "Nova",
                  children: [
                    TextSpan(
                        text: " Chat",
                        style: myTextStyle22(color: AppColors.secondaryColor)
                    ),
                  ],
                  style: myTextStyle22()
              ),

            ),
            Icon(Icons.align_vertical_bottom,color: Colors.green,)
          ],
        ),
      ),
      body: Column(
        children: [
          ///chat messages
          Expanded(
            child:ListView.builder(
              reverse: true,
              itemCount: messageList.length,
              itemBuilder: (_, index) {
              return messageList[index].sendId==0?userChatBox(messageList[index]):botChatBox(messageList[index]);
            },),
          ),
          //aks question
          TextField(
            controller: questionController,
            onSubmitted: (value) {
             // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(query: value),));
            },
            style: myTextStyle14(),
            cursorColor: AppColors.primaryTextColor,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(20), // <-- Inner padding
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none
              ),
              suffixIcon: InkWell(
                onTap: () {
                  final value =questionController.text.trim();
                  if(value.isNotEmpty){

                  }
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.secondaryColor,
                      ),
                    child: Icon(Icons.send,size: 15,color: AppColors.primaryTextColor,)),
              ),
              filled: true,
              fillColor:AppColors.secondaryBgColor,
              hintText: "Chat with Nova ",
              hintStyle: myTextStyle14(),
            ),
          ),
        ],
      ),
    );
  }
  Widget userChatBox(MessageModel msgModel){
    var time  =dateTimeFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(msgModel.sentTime!)));
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width*0.2,),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(11),
            margin: EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: AppColors.chatBubbleUserColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(22),topRight: Radius.circular(22),bottomLeft: Radius.circular(22),)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Flexible(child: Text(msgModel.message!,style: myTextStyle14(),)),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(time,style: myTextStyle10(),)),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget botChatBox(MessageModel msgModel){
    var time = dateTimeFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(msgModel.sentTime!)));
    return Row(
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(11),
            margin: EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: AppColors.chatBubbleBotColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(22),topLeft: Radius.circular(22),bottomRight: Radius.circular(22))
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(msgModel.message!,style: myTextStyle14(),)),
                SizedBox(width: 5,),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(time,style: myTextStyle11(),)),
              ],
            ),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width*0.2,),
      ],
    );
  }
}

