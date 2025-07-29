import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nova_chat/screens/home/home_page.dart';
import '../utils/app_colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //app logo
            Container(
                margin: EdgeInsets.only(right: 18),
                child: Lottie.asset('assets/icons/chatbot_splash.json',width: 310)),
            //app name
            Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Nova',style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryTextColor,
          ),
          ),
          SizedBox(width: 5,),
          AnimatedTextKit(
            repeatForever: true,
            isRepeatingAnimation: true,
            animatedTexts: [
              TyperAnimatedText(
                speed: Duration(milliseconds: 200),
                'Chat...',
                textStyle: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondaryColor,
                ),
              ),
            ],
          ),
        ],
      ),

    ],
        ),
      )
    );
  }
}
