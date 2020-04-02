import 'package:flutter/material.dart';
import 'package:municipal_parking/constants/app_theme.dart';
import 'package:municipal_parking/routes.dart';
import 'package:municipal_parking/constants/strings.dart';
import 'package:flutter/services.dart';



void main(){
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: themeData.primaryColor, //top bar color
        statusBarIconBrightness: Brightness.light, //top bar icons
        systemNavigationBarColor: themeData.primaryColor, //bottom bar color
        systemNavigationBarIconBrightness: Brightness.light, //bottom bar icons
    )
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(themeData.primaryColor);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(true);


    return MaterialApp(
      title: Strings.appTitle,
      initialRoute: Routes.home,
      routes: Routes.routes,
      theme: themeData, 
      debugShowCheckedModeBanner: false
    );
  }
}







