import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:municipal_parking/widgets/Common.dart';
import 'dart:math';
import 'package:nice_button/NiceButton.dart';

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
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient:LinearGradient(
            colors:[Colors.white,Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
          backgroundBlendMode: BlendMode.hardLight,
          boxShadow: kElevationToShadow[2]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center ,
          children: [
            Expanded(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text("Hello",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  Text("Please login to your account",style: TextStyle(fontWeight: FontWeight.w100),)
                ]
              ),
              flex:2
            ),
            Expanded(
              child: TextFormField(
                 decoration: InputDecoration(
                    suffixIcon: Icon(Icons.email,color: colorScheme.primary,),
                    suffixIconConstraints: BoxConstraints.loose(Size.fromWidth(25)),
                    labelText: "Email Address",
                labelStyle: TextStyle(color:Colors.black26,fontWeight: FontWeight.w100)
                  )
              ),
              flex:2,
            ),
            Expanded(
              child: TextFormField(
                 decoration: InputDecoration(
                    suffixIcon: Icon(Icons.offline_bolt,color: colorScheme.primary,),
                    suffixIconConstraints: BoxConstraints.loose(Size.fromWidth(25)),
                    labelText: "Password",
                    labelStyle: TextStyle(color:Colors.black26,fontWeight: FontWeight.w100),
                  
                  ),
                  obscureText: true,
              ),
              flex:2,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child:Text("Forgot Password ?",style: TextStyle(color:colorScheme.primary),),
              ),
              flex: 1,
            ),
            Expanded(
              child:NiceButton(
                width: min(this.width*0.50,200),
                padding: EdgeInsets.all(9.0),
                elevation: 2.0,
                radius: 50.0,
                text: "Login",
                textColor: Theme.of(context).colorScheme.onPrimary,
                background: Theme.of(context).colorScheme.primary,
                onPressed: _signInButtonPressed

              ),
              flex: 2,
            )

          ]
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

  void _signInButtonPressed(){

  }
}