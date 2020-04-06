import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:municipal_parking/widgets/Common.dart';
import 'dart:math';

class LoginScreen extends StatelessWidget{
  ColorScheme colorScheme;
  BuildContext context;
  double width;
  @override
  Widget build(BuildContext context) {
    this.context=context;
    colorScheme=Theme.of(context).colorScheme;
    return Scaffold(
      body: _getBody(),
    );
  }

  Widget _getBody(){
    return LayoutBuilder(
      builder: (context,constraints){
        this.width=constraints.maxWidth;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin:Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [colorScheme.primaryVariant,colorScheme.primary]
            )
          ), 
          child: Column(
            children:[
              _getLogo(),
              _getLoginBox(),
              _getBottomNote(),
            ]
          )
        );

      },
    );
  }
  Widget _getLogo(){
    return Expanded(
      child:FittedBox(
        fit:BoxFit.fitWidth,
        child:Icon(Icons.child_care,semanticLabel: "Name",size: this.width*.50)
        ),
      flex:2
    );
  }
  Widget _getLoginBox(){
    return Expanded(
      child: Container(
        width: min(width*0.80,500),
        decoration: BoxDecoration(
          gradient:LinearGradient(
            colors:[Colors.white70,Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
          backgroundBlendMode: BlendMode.hardLight,
          boxShadow: kElevationToShadow[16]
        ),

      ),
      flex: 4,
    );
  }
  Widget _getBottomNote(){
    return Expanded(
      child: Center(
        child: RichText(
          text: TextSpan(
            text: "Dont't have an account? ",
            style:TextStyle(color: colorScheme.onPrimary),
            children:<TextSpan> [
              TextSpan(
                text:"Register now",
                style: TextStyle(decoration: TextDecoration.underline),
                recognizer: new TapGestureRecognizer()
                  ..onTap=(){
                    
                  }
              )  
            ] 
          ),
        ),
      ),
      flex: 1,
    );
  }
}