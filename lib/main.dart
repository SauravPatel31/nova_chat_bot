import 'package:flutter/material.dart';
import 'package:nova_chat/screens/home_page.dart';
import 'package:nova_chat/screens/home_provider.dart';
import 'package:nova_chat/utils/app_colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldColor,

      ),
      home: HomePage(),
    );
  }
}

