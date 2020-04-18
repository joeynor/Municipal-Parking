import 'package:flutter/material.dart';
import 'package:municipal_parking/constants/app_theme.dart';
import 'package:municipal_parking/routes.dart';
import 'package:municipal_parking/constants/strings.dart';
import 'package:flutter/services.dart';
import 'package:municipal_parking/screens/splash/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:municipal_parking/screens/home/home.dart';
import 'package:municipal_parking/screens/login/login.dart';

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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);


    return MaterialApp(
      title: Strings.appTitle,
      routes: Routes.routes,
      theme: themeData, 
      home: SplashScreen(),
      debugShowCheckedModeBanner: false
    );
  }
}



class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;
  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token != null){
      setState(() {
        isAuth = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = HomeScreen();
    } else {
      child = LoginScreen();
    }
    return Scaffold(
      body: child,
    );
  }
}




