import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'dart:math';
import 'package:municipal_parking/utils/api.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:municipal_parking/routes.dart';



class AccountWindow extends StatelessWidget{
  double width;
  BuildContext context;
  bool processing;

  AccountWindow(){
    processing=false;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme=Theme.of(context).colorScheme;
    this.context=context;
    return LayoutBuilder(
      builder: (context,constraints){
        this.width=constraints.maxWidth;
        return Center(
          child:NiceButton(
            width: min(this.width * 0.50, 200),
            padding: EdgeInsets.all(5.0),
            elevation: 2.0,
            radius: 40.0,
            text: "Logout",
            textColor: colorScheme.onPrimary,
            background: colorScheme.primary,
            onPressed: _logout
          ) 
        );
      },
    );
  }
  
  void _logout() async{
    if(!processing)
      processing=true;
    else
      return;
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.pushNamedAndRemoveUntil(context,Routes.login,(r)=>false);

    }
    processing=false;
  }

}