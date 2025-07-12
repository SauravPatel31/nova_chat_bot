import 'package:flutter/material.dart';
import 'package:nova_chat/screens/home_provider.dart';
import 'package:nova_chat/utils/app_colors.dart';
import 'package:nova_chat/utils/app_const.dart';
import 'package:nova_chat/utils/text_style.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
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
        backgroundColor: Colors.transparent,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
            ///new chat and History
              Row(
                children: [
                  //new chat
                  InkWell(
                    onTap: (){},
                    child: Row(
                      children: [
                        Icon(Icons.chat_outlined,size: 19,color: AppColors.primaryTextColor,),
                        SizedBox(width: 5,),
                        Text("New Chat",style: myTextStyle14(),)
                      ],
                    ),
                  ),
                  Spacer(),
                  ///history
                  InkWell(
                    onTap: (){},
                    child: Row(
                      children: [
                        Icon(Icons.history,size: 19,color: AppColors.secondaryTextColor,),
                        SizedBox(width: 5,),
                        Text("History",style: myTextStyle14(color: AppColors.secondaryTextColor),)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              ///search bar
              TextField(
                style: myTextStyle14(),
                maxLines: 6,
                cursorColor: AppColors.primaryTextColor,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none
                  ),
                  filled: true,
                  fillColor:AppColors.secondaryBgColor,
                  hintText: "Chat with Nova ",
                  hintStyle: myTextStyle14(),
                ),
              ),
              //List of Questions..
              SizedBox(height: 15,),
              Consumer<HomeProvider>(builder: (context, provider, child) {
                return Column(
                  children: [
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
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 02,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12
                      ),
                      itemCount: AppConst.defaultQuestion[provider.selectedIndex]['questionInfo'].length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> eachQuestion = AppConst.defaultQuestion[provider.selectedIndex]['questionInfo'][index];
                        return Container(
                          padding:EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: AppColors.secondaryBgColor,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: eachQuestion['color'],
                                radius: 22,
                                child: Center(child: Icon(eachQuestion['icons'],color: Colors.white,size: 30,)),
                              ),
                              SizedBox(height: 10,),
                              Text(eachQuestion['question'],style: myTextStyle16(fontWeight: FontWeight.w900),)
                            ],
                          ),
                        );
                      },)
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
