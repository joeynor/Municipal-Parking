import 'package:flutter/material.dart';
import 'package:municipal_parking/constants/app_theme.dart';

class Common{
  static Widget myAppBar(context){
    return AppBar(
      title: Text("Municipal Parking",style: TextStyle(color: Theme.of(context).colorScheme.onPrimary,),)
    );
  }
}
final Widget commonAppBar=AppBar(
  title: Text("Logo",
    style: TextStyle(color:themeData.colorScheme.onPrimary,),
  ),
  brightness: Brightness.dark,
  centerTitle: true,
);

class FeeDetails{
  String parkingNo;
  int hours;
  int minutes;
  String category;
  double perHourRate;
  double amountDue;
  FeeDetails({this.parkingNo,this.hours,this.minutes,this.category,this.perHourRate,this.amountDue,this.paymentId});
}