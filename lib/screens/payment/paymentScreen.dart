import 'package:flutter/material.dart';
import 'package:municipal_parking/widgets/Common.dart';

class PaymentScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => PaymentScreenState();

}

class PaymentScreenState extends State<PaymentScreen>{
  BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context=context;

    return Scaffold(
      appBar: commonAppBar,
      body: Center(child: Text("dd"),),
      resizeToAvoidBottomInset: false,
    );
  }


}