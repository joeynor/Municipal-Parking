import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:municipal_parking/routes.dart';
import 'package:municipal_parking/widgets/Common.dart';
import 'dart:math';
import 'package:nice_button/NiceButton.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:municipal_parking/utils/api.dart';







class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>LoginScreenState();

}
class LoginScreenState extends State<LoginScreen>{
  ColorScheme colorScheme;
  BuildContext context;
  double width;
  double height;
  bool passwordVisible;

  String _email;
  String _password;

  bool _keyBoardOn;
  bool _isLoading;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void initState(){
    super.initState();
    passwordVisible=false;
    _keyBoardOn=false;
    _isLoading=false;
  }

  @override
  Widget build(BuildContext context) {
    
    this.context=context;
    colorScheme=Theme.of(context).colorScheme;
    return Scaffold(
      key: _scaffoldKey,
      body: _getBody(),
      // resizeToAvoidBottomInset: false,

    );
  }

  Widget _getBody(){
    _keyBoardOn=MediaQuery.of(context).viewInsets.bottom == 0.0;
    return LayoutBuilder(
      builder: (context,constraints){
        this.width=constraints.maxWidth;
        this.height=constraints.maxHeight;

        return Container(
          padding: EdgeInsets.only(top:MediaQuery.of(context).padding.top,bottom:5),
          width: this.width,
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
              Visibility(
                child:_getBottomNote(),
                visible: _keyBoardOn,
              )
            ]
          )
        );

      },
    );
  }
  Widget _getLogo(){
    return Expanded(
      child:FittedBox(
        fit:BoxFit.fitHeight,
        child:Icon(Icons.child_care,semanticLabel: "Name")
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
        child: Form(
          key: _formKey,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center ,
            children: [
              Expanded(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    FittedBox(
                      fit: BoxFit.fitHeight,
                      child:Text("Hello",style: TextStyle(fontSize: this.height*0.04,fontWeight: FontWeight.bold),),
                    ),
                    FittedBox(
                      fit: BoxFit.fitHeight,
                      child:Text("Please login to your account",style: TextStyle(fontWeight: FontWeight.w200),)
                    ),
                    
                    
                  ]
                ),
                flex:2
              ),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top:0,bottom: 10),
                      suffixIcon: Icon(Icons.email,color: colorScheme.primary,),
                      suffixIconConstraints: BoxConstraints.loose(Size.fromWidth(25)),
                      labelText: "Email Address",
                      labelStyle: TextStyle(color:Colors.black38,fontWeight: FontWeight.w100)
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(decoration: TextDecoration.none),
                  validator: (email){
                    if(!EmailValidator.validate(email))
                      return "Invalid email adress";
                    _email=email;
                    return null;
                  },  
                ),
                flex:2,
              ),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top:0,bottom: 10),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                          color: colorScheme.primary,
                          ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                              passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                      suffixIconConstraints: BoxConstraints.loose(Size.fromWidth(34)),
                      labelText: "Password",
                      labelStyle: TextStyle(color:Colors.black38,fontWeight: FontWeight.w100),
                      // isCo
                    
                    ),
                    obscureText: !passwordVisible,
                  validator: (pass){
                    if(pass.isEmpty)return "Pasword can't be empty";
                    _password=pass;
                    return null;
                  },  
                ),
                flex:2,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child:FittedBox(
                    fit: BoxFit.fitHeight,
                    child:Text("Forgot Password ?",style: TextStyle(color:colorScheme.primary),),
                  )
                ),
                flex: 1,
              ),
              Expanded(
                child:FittedBox(
                  fit: BoxFit.contain,
                  child:NiceButton(
                  width: min(this.width*0.50,200),
                  padding: EdgeInsets.all(9.0),
                  elevation: 2.0,
                  radius: 50.0,
                  text: _isLoading?"Processsing":"Login",
                  textColor: Theme.of(context).colorScheme.onPrimary,
                  background: Theme.of(context).colorScheme.primary,
                  onPressed: _signInButtonPressed

                )
                ),
                flex: 2,
              )

            ]
          ),
        
        )

      ),
      flex: _keyBoardOn?5:4,
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
                    Navigator.pushNamed(context, Routes.signUpScreen);
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
    if(_formKey.currentState.validate()){
      _login();
    }
  }

  void _login() async{
    // Navigator.popAndPushNamed(context, Routes.home);
    // return;

    if(_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email' : _email,
      'password' : _password
    };

    var res = await Network().authData(data, '/login');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.popAndPushNamed(context, Routes.home);
    }else{
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });

  } 

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg,textAlign: TextAlign.center,),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  } 

}