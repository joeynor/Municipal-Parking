import 'package:flutter/material.dart';
import 'package:municipal_parking/screens/home/home.dart';
import 'package:municipal_parking/screens/login/login.dart';
import 'package:municipal_parking/screens/payment/paymentDetails.dart';

class Routes {
  Routes._();

  //static variables
  // static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String paymentDetails = '/paymentDetails';

  static final routes = <String, WidgetBuilder>{
    // splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    paymentDetails: (BuildContext context) => PaymentDetails(),
  };
}



