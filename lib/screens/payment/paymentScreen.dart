import 'package:flutter/material.dart';
import 'package:municipal_parking/widgets/Common.dart';
import 'package:municipal_parking/utils/api.dart';
import 'dart:convert';

class PaymentScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => PaymentScreenState();

}

class PaymentScreenState extends State<PaymentScreen>{
  BuildContext context;

  bool _isLoading;
  String _msg;
  bool _notRequested;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading=true;
    _msg=" ";
    _notRequested=true;

  }

  @override
  Widget build(BuildContext context) {
    this.context=context;
    final Parking parking = ModalRoute.of(context).settings.arguments;

    if(_notRequested)
    {
      fetchPaymentDetails(parking);
      _notRequested=false;
    }
    return Scaffold(
      appBar: commonAppBar,
      body: Center(child: _isLoading?CircularProgressIndicator():Text(_msg),),
      resizeToAvoidBottomInset: false,
    );
  }

  void fetchPaymentDetails(Parking parking) async{

    try{

      final response = await Network().getData('/processpayment/${parking.parkingNo}');
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        _msg=body['message'];
      } 
      else {
        _msg='Status Code ${response.statusCode}';
      }
    }
    catch(e){
      _msg="Error: Server isn't reachable";
    }
    if(this.mounted)
      setState(() {
        _isLoading=false;
      });

  }
}