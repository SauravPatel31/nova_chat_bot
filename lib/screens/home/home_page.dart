import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:nova_chat/screens/chats/chat_page.dart';
import 'package:nova_chat/screens/home/home_provider.dart';
import 'package:nova_chat/utils/app_colors.dart';
import 'package:nova_chat/utils/app_const.dart';
import 'package:nova_chat/utils/text_style.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  TextEditingController questionController = TextEditingController();
  HomePage({super.key});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
              text: "Nova",
              children: [
                TextSpan(
                    text: " Chat",
                    style: myTextStyle22(color: AppColors.secondaryColor)
                )
              ],
              style: myTextStyle22()
          ),

        ),
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(),));
            },
            child: Container(
                margin: EdgeInsets.only(right: 16),
                child: Image.asset("assets/icons/chatbot.png",width: 33,)),
          )
        ],
        backgroundColor: Colors.transparent,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            ///new chat
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(),));
                },
                child: Text("Easy Chat",style: myTextStyle14(),),
              ),
              SizedBox(height: 15,),
              ///search bar
              TextField(
                controller: questionController,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  if(value.isNotEmpty) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ChatPage(query: value),));
                  }
                  },
                style: myTextStyle14(),
                maxLines: 6,
                cursorColor: AppColors.primaryTextColor,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none
                  ),
                  filled: true,
                  suffixIcon: Padding(
                    padding:  EdgeInsets.only(top: 110 ),
                    child: InkWell(

                      onTap: () {
                        final value =questionController.text.trim();
                        if(value.isNotEmpty){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(query: value),));
                          questionController.clear();
                        }
                      },
                      child: Container(
                          margin: EdgeInsets.all(10),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.secondaryColor,
                          ),
                          child: Icon(Icons.send,size: 15,color: AppColors.primaryTextColor,)),
                    ),
                  ),
                  fillColor:AppColors.secondaryBgColor,
                  hintText: "Chat with Nova ",
                  hintStyle: myTextStyle14(),
                ),
              ),
              //List of Questions..
              SizedBox(height: 15,),
              Consumer<HomeProvider>(builder: (context, provider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //pre chat categories
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        itemCount: AppConst.defaultQuestion.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              provider.changeIndex(index);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 11),
                              padding: EdgeInsets.symmetric(horizontal: 11),
                              decoration: BoxDecoration(
                                border: Border.all(color: provider.selectedIndex == index ? AppColors.secondaryColor:Colors.transparent,width: 1),
                                color:provider.selectedIndex == index ? AppColors.secondaryBgColor:AppColors.secondaryBgColor.withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(07),
                              ),
                              child: Center(child: Text(AppConst.defaultQuestion[index]['title'],style: myTextStyle14(fontWeight: FontWeight.w500,color:provider.selectedIndex == index ? AppColors.secondaryColor:AppColors.primaryTextColor),)),
                            ),
                          );
                        },),
                    ),
                    SizedBox(height: 15,),
                    ///pre chat Questions
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: AppConst.defaultQuestion[provider.selectedIndex]['questionInfo'].length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> eachQuestion = AppConst.defaultQuestion[provider.selectedIndex]['questionInfo'][index];

                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 600),
                          columnCount: 2,
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatPage(query: eachQuestion['question']),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryBgColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: CircleAvatar(
                                          backgroundColor: eachQuestion['color'],
                                          radius: 22,
                                          child: Center(
                                            child: Icon(
                                              eachQuestion['icons'],
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Expanded(
                                        child: Text(
                                          eachQuestion['question'],
                                          style: myTextStyle16(fontWeight: FontWeight.w900),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )

                  ],
                );
              },)
            ],
          ),
        ),
      ) ,
    );
  }
}


