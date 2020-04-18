import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final String label;
  PasswordField({this.label,this.validator});
  var validator;
  @override
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
      validator: widget.validator,
    );
  }
}
