import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'dart:math';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:municipal_parking/utils/api.dart';
import 'dart:convert';
import 'package:municipal_parking/routes.dart';

import './passwordField.dart';

class SignUpScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>SignUpScreenState();

}
class SignUpScreenState extends State<SignUpScreen> {
  BuildContext context;
  BuildContext bodyContext;
  ColorScheme colorScheme;
  double width;
  double height;
  bool _keyBoardOn;

  String _fullName;
  String _password;
  String _email;
 
  bool _isLoading;


  @override
  void initState() {
    super.initState();
    _keyBoardOn=false;
    _isLoading=false;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: _getAppBar(),
      body: _getBody(),
      // resizeToAvoidBottomInset: false,
    );
  }

  Widget _getBody() {
    // print("---------------->${MediaQuery.of(context).viewInsets.bottom}");
    _keyBoardOn=MediaQuery.of(context).viewInsets.bottom != 0;
    return LayoutBuilder(
      builder: (context, constraints) {
        this.bodyContext=context;
        this.width = constraints.maxWidth;
        this.height = constraints.maxHeight;
        return Container(
            padding: EdgeInsets.only(left: width * .08, right: width * .08),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [colorScheme.primaryVariant, colorScheme.primary])),
            child: Column(children: [
              Expanded(
                  child: FittedBox(
                      fit: BoxFit.contain,
                      alignment: Alignment.topCenter,
                      child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * .05),
                          child: Text(
                            "Create an Account",
                            style: TextStyle(color: colorScheme.onPrimary),
                          ))),
                  flex: 1),
              Expanded(child: _getSignUpForm(), flex: 4),
              Visibility(
                child: Expanded(child: _getFinishButton(), flex: 1),
                visible: !_keyBoardOn,
              ),
              Visibility(
                child: Expanded(
                  child: Container(),
                  flex: 2,
                ),
                visible: !_keyBoardOn,
              ),
            ]));
      },
    );
  }

  Widget _getSignUpForm() {
    return Form(
        key: _formKey,
        child: Column(children: [
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 0, bottom: 10),
                suffixIcon: Icon(
                  Icons.person,
                  color: colorScheme.onPrimary,
                ),
                suffixIconConstraints: BoxConstraints.loose(Size.fromWidth(25)),
                labelText: "Full Name",
                labelStyle: TextStyle(
                    color: Colors.white54, fontWeight: FontWeight.w600),
              ),
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: colorScheme.onPrimary),
              validator: (fullName){
                if(fullName.isEmpty)
                  return "Please enter fullname";
                _fullName=fullName;
                return null;
              },
            ),
            flex: 1,
          ),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 0, bottom: 10),
                suffixIcon: Icon(
                  Icons.email,
                  color: colorScheme.onPrimary,
                ),
                suffixIconConstraints: BoxConstraints.loose(Size.fromWidth(25)),
                labelText: "Email Address",
                labelStyle: TextStyle(
                    color: Colors.white54, fontWeight: FontWeight.w600),
              ),
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: colorScheme.onPrimary),
              validator: (email){
                if(!EmailValidator.validate(email))
                  return "Please enter valid email";
                _email=email;
                return null;
              },
            ),
            flex: 1,
          ),
          Expanded(
            child: PasswordField(label: "Password",validator: (String pass){
              if(pass.isEmpty) return "Please enter valid password";
              _password=pass;
              return null;
            },),
            flex: 1,
          ),
          Expanded(
            child: PasswordField(label: "Confirm Password",validator: (String pass){
              if(pass.isEmpty) return "Please enter valid password";
              if(_password!=pass) return "Password doesn't match";
              return null;
            }),
            flex: 1,
          ),
        ]));
  }

  _getFinishButton() {
    return FittedBox(
        child: NiceButton(
            width: min(this.width * 0.50, 200),
            padding: EdgeInsets.all(5.0),
            elevation: 2.0,
            radius: 40.0,
            text: _isLoading?"Processing":"Register",
            textColor: colorScheme.onPrimary,
            background: colorScheme.primary,
            onPressed: _finishButtonPressed),
        fit: BoxFit.contain);
  }

  Widget _getAppBar() {
    return AppBar(
      bottomOpacity: 0,
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[colorScheme.primaryVariant, colorScheme.primary],
          ),
        ),
      ),
    );
  }

  void _finishButtonPressed() async {
    if (_formKey.currentState.validate()) {
      // try {
      //   final result = await InternetAddress.lookup('google.com');
      //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          _register();
        // }
      // } on SocketException catch (_) {
      //   final snackBar = SnackBar(content: Text("Error: Server isn't reachable"));
      //   Scaffold.of(context).showSnackBar(snackBar);
      // }
        // print("reg form valided");
    }
    // else
      // print("Reg fomr invalid");
  }
  
  void _register()async{
    setState(() {
      _isLoading = true;
    });
    var data = {
      'name':_fullName,
      'email' : _email,
      'password': _password,
    };


    try{
      var res = await Network().authData(data, '/register');
      var body = json.decode(res.body);
      if(body['success']){
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', json.encode(body['token']));
        localStorage.setString('user', json.encode(body['user']));
        Navigator.pushNamedAndRemoveUntil(context,Routes.home,(r)=>false);
      }
      else{
        if(body['message'].containsKey("email")){
          final snackBar = SnackBar(content:Text("Email aready exists",textAlign:TextAlign.center,));
          Scaffold.of(bodyContext).showSnackBar(snackBar);
        }
        else{
          final snackBar = SnackBar(content:Text("Unkown error",textAlign:TextAlign.center,));
          Scaffold.of(bodyContext).showSnackBar(snackBar);
        }
      } 
    }
    catch(e){
        final snackBar = SnackBar(content:Text("Error: Server isn't reachable",textAlign:TextAlign.center,));
        Scaffold.of(bodyContext).showSnackBar(snackBar);
    }
    setState(() {
      _isLoading = false;
    });
  }

}

