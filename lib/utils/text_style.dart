
import 'package:flutter/cupertino.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

//title
TextStyle myTextStyle22({FontWeight fontWeight=FontWeight.bold, Color color=AppColors.primaryTextColor}){
  return TextStyle(
    fontSize: 22,
    color: color,
    fontWeight: fontWeight,
    fontFamily: FontsStyle.poppinsFonts.fontFamily,
  );
}
TextStyle myTextStyle20({FontWeight fontWeight=FontWeight.normal}){
  return TextStyle(
    fontSize: 20,
    color: AppColors.primaryTextColor,
    fontWeight: fontWeight,
    fontFamily: FontsStyle.poppinsFonts.fontFamily,
  );
}

//text
TextStyle myTextStyle18({FontWeight fontWeight=FontWeight.normal}){
  return TextStyle(
    fontSize: 18,
    color: AppColors.primaryTextColor,
    fontWeight: fontWeight,
    fontFamily: FontsStyle.interFonts.fontFamily,
  );
}
TextStyle myTextStyle16({FontWeight fontWeight=FontWeight.normal}){
  return TextStyle(
    fontSize: 16,
    color: AppColors.primaryTextColor,
    fontWeight: fontWeight,
    fontFamily: FontsStyle.interFonts.fontFamily,
  );
}
TextStyle myTextStyle14({FontWeight fontWeight=FontWeight.normal,Color color=AppColors.primaryTextColor}){
  return TextStyle(
    fontSize: 14,
    color: color,
    fontWeight: fontWeight,
    fontFamily: FontsStyle.interFonts.fontFamily,
  );
}

//subtitle
TextStyle myTextStyle12({FontWeight fontWeight=FontWeight.normal}){
  return TextStyle(
    fontSize: 12,
    color: AppColors.secondaryTextColor,
    fontWeight: fontWeight,
    fontFamily: FontsStyle.interFonts.fontFamily,
  );
}
TextStyle myTextStyle11({FontWeight fontWeight=FontWeight.normal}){
  return TextStyle(
    fontSize: 11,
    color: AppColors.secondaryTextColor,
    fontWeight: fontWeight,
    fontFamily: FontsStyle.interFonts.fontFamily,
  );
}