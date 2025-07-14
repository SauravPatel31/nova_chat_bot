import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier{
  int selectedIndex = 0;

  void changeIndex(int index){
    selectedIndex = index;
    notifyListeners();
  }
}