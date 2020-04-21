import 'package:flutter/material.dart';
import 'package:municipal_parking/widgets/Common.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:municipal_parking/routes.dart';
import 'package:municipal_parking/utils/api.dart';
import 'dart:convert';
import 'dart:math';





class PaymentDetails extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>PaymentDetailsState();

}
class PaymentDetailsState extends State<PaymentDetails>{
  FeeDetails _args;
  String buttonText="Pay & Unlock";
   
  double width;

  ColorScheme colorScheme;
  BuildContext context;

  Parking parking;
  String _msg;
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  bool _isLoading;
  bool _success;
  bool _requested;

  @override
  void initState() {
    super.initState();
    _isLoading=true;
    _success=false;
    _requested=false;
    _msg=" ";
  }
  



  void fetchPaymentDetails(Parking parking) async{

    try{

      final response = await Network().getData('/transactions/${parking.parkingNo}');
      if (response.statusCode == 200) {
        var body = json.decode(response.body);
        if(body['success']){
          _args= FeeDetails.fromJson(body['details']);
          setState(() {
            _success=true;
          });
        }
        else{
           _msg=body['message'];
        }
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




  @override
  Widget build(BuildContext context) {
    colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    parking = ModalRoute.of(context).settings.arguments;
    this.context=context;
    if(!_requested){
       _requested=true;
       fetchPaymentDetails(parking);
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: commonAppBar,
      body: _isLoading? Center(child:CircularProgressIndicator()):_getBody(),
      resizeToAvoidBottomInset: false,
    );
  }
  Widget _getBody() {
    return !_success?Center(child:Text(_msg)): LayoutBuilder(builder: (context,constrainsts){
      this.width=constrainsts.maxWidth;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child:RichText(
                  text:TextSpan(
                    text:"Parking No: ",
                    style: TextStyle(fontSize: width*.06,color: Colors.black),
                    children: [
                      TextSpan(
                        text:_args.parkingNo,
                        style:TextStyle(color:colorScheme.primary)
                      )
                    ]
                  )
                )
              ),
              flex:1
            ),
            _getDurationWidget(),
            Divider(indent: width*.23,thickness: width*.005,endIndent: width*.23,),
            _getDescriptionWidget(),
            Divider(indent: width*.15,thickness: width*.005,endIndent: width*.15,),
            _getAmountWidget(),
            Divider(indent: width*.23,thickness: width*.005,endIndent: width*.23,),
            _getPayButton(),
        ],
      );
    }
    );
  }
  Widget _getDurationWidget(){
    return Expanded(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Duration",
              style: TextStyle(
                color: Colors.lightBlueAccent,
                // letterSpacing: width*0.005,
                fontSize: width*0.05,
                // height: width*0.005
              ),
            ),
            Text("${_args.hours}h:${_args.minutes}m",
              style: TextStyle(
                color:colorScheme.primary,
                fontSize: width*0.08,
                height: 1.2
                // letterSpacing: 1.0
                ),
            ),
          ],
        ),
        flex:2,
    );
  }
  Widget _getDescriptionWidget(){
    return Expanded(
      
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Description",
              style: TextStyle(
                color: Colors.lightBlueAccent,
                letterSpacing: width*0.005,
                fontSize: width*0.065,
                height: width*0.005
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: <InlineSpan>[
                  TextSpan(text:"Category: ",style: TextStyle(color:Colors.brown)),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle ,
                    child:Text(_args.category,style: TextStyle(color:colorScheme.primary,fontSize: width*0.06))
                  )
                ]
              )

            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: <InlineSpan>[
                  TextSpan(text:"Hourly Rate: ",style: TextStyle(color:Colors.brown)),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle ,
                    child:Text(_args.perHourRate.toStringAsFixed(2),style: TextStyle(color:colorScheme.primary,fontSize: width*0.06))
                  )
                ]
              )

            ),
          ],
        ),
        flex:2,
    );

  }
  Widget _getAmountWidget(){ 
    return Expanded(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Amount Due",
              style: TextStyle(
                color: Colors.lightBlueAccent,
                // letterSpacing: width*0.005,
                fontSize: width*0.05,
                // height: width*0.005
              ),    
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(color:colorScheme.primary),
                children: <InlineSpan>[
                  TextSpan(text:"RM "),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle ,
                    child:Text(_args.amountDue.toStringAsFixed(2),style: TextStyle(fontSize: width*0.08,color: colorScheme.primary))
                  )
                ]
              )

            ),
          ],
        ),
        flex:2,
    );
  }
  Widget _getPayButton(){
    return Expanded(
      child: Center(
        child:NiceButton(
          width: min(this.width*0.50,200),
          elevation: 8.0,
          radius: 52.0,
          text: buttonText,
          textColor: Theme.of(context).colorScheme.onPrimary,
          background: Theme.of(context).colorScheme.primary,
          onPressed: _payButtonPressed
        ),
      ),
      flex: 2,
    );
  }

  void _payButtonPressed(){
      Navigator.pushNamed(
        context, 
        Routes.paymentScreen,
        arguments: parking
    );
  }

}