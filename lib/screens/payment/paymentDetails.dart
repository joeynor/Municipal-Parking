import 'package:flutter/material.dart';
import 'package:municipal_parking/widgets/Common.dart';
import 'package:nice_button/NiceButton.dart';
import 'dart:math';
class PaymentDetails extends StatelessWidget{
  FeeDetails _args;
  String buttonText="Pay & Unlock";
   
  double width;

  ColorScheme colorScheme;
  BuildContext context;



  @override
  Widget build(BuildContext context) {
    colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    _args = ModalRoute.of(context).settings.arguments;
    this.context=context;

    return Scaffold(
      appBar: commonAppBar,
      body: _getBody(),
      resizeToAvoidBottomInset: false,
    );
  }
  Widget _getBody() {
    return LayoutBuilder(builder: (context,constrainsts){
      this.width=constrainsts.maxWidth;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
                fontSize: width*0.11,
                height: 1.2
                // letterSpacing: 1.0
                ),
            ),
          ],
        ),
        flex:1,
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
                // height: width*0.005
              ),
            ),
            Text("Category: ${_args.category}"),
            Text("Hourly Rate: ${_args.perHourRate}"),
          ],
        ),
        flex:1,
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
            Text("RM: ${_args.amountDue.toStringAsFixed(2)}",
              style: TextStyle(
                color:colorScheme.primary,
                fontSize: width*0.11,
                height: 1.2
                // letterSpacing: 1.0
               ),
            ),
          ],
        ),
        flex:1,
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
      flex: 1,
    );
  }

  void _payButtonPressed(){

  }

}