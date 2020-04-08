import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'dart:math';

class SignUpScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>SignUpScreenState();

}
class SignUpScreenState extends State<SignUpScreen> {
  BuildContext context;
  ColorScheme colorScheme;
  double width;
  double height;
  bool _keyBoardOn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _keyBoardOn=false;
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
    print("---------------->${MediaQuery.of(context).viewInsets.bottom}");
    _keyBoardOn=MediaQuery.of(context).viewInsets.bottom != 0;
    return LayoutBuilder(
      builder: (context, constraints) {
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
            ),
            flex: 1,
          ),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.words,
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
            ),
            flex: 1,
          ),
          Expanded(
            child: PasswordField(label: "Password"),
            flex: 1,
          ),
          Expanded(
            child: PasswordField(label: "Confirm Password"),
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
            text: "Finish",
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

  void _finishButtonPressed() {}
}

class PasswordField extends StatefulWidget {
  @override
  final String label;
  PasswordField({this.label});

  State<StatefulWidget> createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool _passwordVisible;
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return TextFormField(
      obscureText: !_passwordVisible,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 0, bottom: 10),
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: colorScheme.onPrimary,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        suffixIconConstraints: BoxConstraints.loose(Size.fromWidth(34)),
        labelText: widget.label,
        labelStyle:
            TextStyle(color: Colors.white54, fontWeight: FontWeight.w600),
      ),
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(
          decoration: TextDecoration.none, color: colorScheme.onPrimary),
    );
  }
}
