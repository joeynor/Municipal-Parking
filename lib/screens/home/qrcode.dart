import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:municipal_parking/constants/font_family.dart';
import 'package:municipal_parking/widgets/Common.dart';
import 'qr_code_scanner.dart';
import 'qr_scanner_overlay_shape.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:municipal_parking/routes.dart';


const flash_on = "FLASH ON";
const flash_off = "FLASH OFF";
const front_camera = "FRONT CAMERA";
const back_camera = "BACK CAMERA";





typedef void ScanButtonPressed();

class QRcodeWindow extends StatefulWidget {
  const QRcodeWindow({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRcodeWindowState();
}





class _QRcodeWindowState extends State<QRcodeWindow> {
  var qrText = "";
  var flashState = flash_on;
  var cameraState = front_camera;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  List<Widget> qrStackWidget;

  final double borderWidth=3;
  double cutOutSize=250;
  
  String scanButtonText="Scan";
  @override 
  void initState(){
    super.initState();
  }
  void _scanButtonPressed(){
    setState(() {
      scanButtonText=(scanButtonText=="Scan")?"Scanning":"Scan";
    });
    print("Scann button------------->$scanButtonText");
    Navigator.pushNamed(
      context, 
      Routes.paymentDetails,
      arguments: FeeDetails(
        hours: 5,
        minutes: 50,
        category: "Normal",
        perHourRate: 2,
        amountDue: 11.40,
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:(BuildContext context, BoxConstraints constraints){
        this.cutOutSize=max(constraints.maxWidth*.65,230);
        return  Column(
          children: <Widget>[
            Expanded(
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.white,
                  borderRadius: 1,
                  borderLength: 40,
                  borderWidth: this.borderWidth,
                  cutOutSize: this.cutOutSize,
                ),
                // stackWidget: <Widget>[],
                stackWidget:_getStackWidget()
              ),
              flex: 1,
            ),
          ],
        );
      }
    );
    
  }
  List<Widget> _getStackWidget(){
      return [
        
        FlashButton(buttonText: scanButtonText,scanButtonPressed: _scanButtonPressed,cutOutSize: this.cutOutSize,borderWidth: this.borderWidth,),
        ParkingNoInput(buttonText: scanButtonText,scanButtonPressed: _scanButtonPressed,cutOutSize: this.cutOutSize,borderWidth: this.borderWidth,),
        ScanButton(buttonText: scanButtonText,scanButtonPressed: _scanButtonPressed,cutOutSize: this.cutOutSize,borderWidth: this.borderWidth,)
        
      ];
  }
  _isFlashOn(String current) {
    return flash_on == current;
  }

  _isBackCamera(String current) {
    return back_camera == current;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
class FlashButton extends StatelessWidget{
  FlashButton({@required this.buttonText, @required this.cutOutSize, @required this.borderWidth, @required this.scanButtonPressed});
  final double cutOutSize;
  final double borderWidth;
  final String buttonText;
  final ScanButtonPressed scanButtonPressed;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
          builder: (BuildContext context,BoxConstraints constraints){
            return Container(
              child: Align(
                  alignment:Alignment.centerRight,
                  child:Container(
                    height: cutOutSize*.20,
                    width:  (constraints.maxWidth-cutOutSize)/2-borderWidth,
                    padding: EdgeInsets.symmetric(horizontal:2.0),
                    // decoration:
                    //     BoxDecoration(shape: BoxShape.rectangle, color: Colors.red),
                    child: Center(
                      child:NiceButton(
                        mini: true,
                        icon: Icons.flash_off,
                        padding: EdgeInsets.all(10),
                        text: "ggg",
                        iconColor: Theme.of(context).colorScheme.primary,
                        background: Colors.transparent,
                        onPressed: () {
                          print("hello");
                        },
                      ),
                    ),
                ),
              )
            );
          },
    );
  }

}
class ParkingNoInput extends StatelessWidget{
  ParkingNoInput({@required this.buttonText, @required this.cutOutSize, @required this.borderWidth, @required this.scanButtonPressed});
  final double cutOutSize;
  final double borderWidth;
  final String buttonText;
  final ScanButtonPressed scanButtonPressed;
  @override
  Widget build(BuildContext context) {
    Color onPrimary=Theme.of(context).colorScheme.onPrimary;
    Color primary=Theme.of(context).colorScheme.primary;
    return LayoutBuilder(
          builder: (BuildContext context,BoxConstraints constraints){
            return Container(
              child: Align(
                  alignment:Alignment.topCenter,
                  child:Container(
                    height: constraints.maxHeight/2-cutOutSize/2-borderWidth,
                    width:  cutOutSize,
                    // decoration:
                    //     BoxDecoration(shape: BoxShape.rectangle, color: Colors.red),
                    child:Column(children: <Widget>[
                      Expanded(
                        child: Center(
                          // padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: TextField(
                            // minLines: 20,
                            maxLines: 1,
                            autocorrect: false,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Enter Parking Number',
                              hintStyle: TextStyle(color: onPrimary,fontSize: 17,decoration: TextDecoration.none),
                              filled: true,
                              fillColor: Colors.blueGrey[900],
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(color: onPrimary),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(color: onPrimary),
                              ),
                              suffixIcon: Icon(Icons.keyboard,color: onPrimary,)
                            ),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: onPrimary,fontSize: 17,decoration: TextDecoration.none,height: 2,fontWeight: FontWeight.bold),
                            textCapitalization: TextCapitalization.characters,
                          ),
                        ),
                        flex: 2,
                      ),
                      // Divider(color: Colors.white70,),
                      Expanded(
                        child: Text("OR",style:TextStyle(color: Colors.white70),textAlign: TextAlign.center,),
                        flex: 1,
                      )
                    ]
                  )
                ),
              )
            );
          },
    );
  }

}

class ScanButton extends StatelessWidget{
  ScanButton({@required this.buttonText, @required this.cutOutSize, @required this.borderWidth, @required this.scanButtonPressed});
  final double cutOutSize;
  final double borderWidth;
  final String buttonText;
  final ScanButtonPressed scanButtonPressed;
  @override
  Widget build(BuildContext context) {
     return LayoutBuilder(
          builder: (BuildContext context,BoxConstraints constraints){
            return Container(
              child: Align(
                  alignment:Alignment.bottomCenter,
                  child:Container(
                    height: constraints.maxHeight/2-cutOutSize/2-borderWidth,
                    width:  cutOutSize,
                    // padding: EdgeInsets.symmetric(horizontal:8.0),
                    // decoration:
                    //     BoxDecoration(shape: BoxShape.rectangle, color: Colors.red),
                    child: Center(
                        child:NiceButton(
                          width: cutOutSize*0.60,
                          elevation: 8.0,
                          radius: 52.0,
                          text: buttonText,
                          textColor: Theme.of(context).colorScheme.onPrimary,
                          background: Theme.of(context).colorScheme.primary,
                          onPressed: scanButtonPressed
                        ),
                    ),
                ),
              )
            );
          },
        );
  }
  
}