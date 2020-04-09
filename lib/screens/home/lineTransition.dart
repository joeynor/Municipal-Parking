import 'package:flutter/material.dart';


class LineTransition extends AnimatedWidget {
  const LineTransition({Key key, Animation<double> animation,this.width,this.height,this.left,this.top})
      : super(key: key, listenable: animation);
  

  final double height,width,left,top;
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
      return Visibility(
        visible: animation.value!=0,
        child:Positioned(
        top: this.top+this.height * animation.value,
        left: this.left,
        child: Container(
        height: 3,
        width: this.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          gradient: RadialGradient(
            radius: width*.3,
            colors: [
              Colors.white38,
              Colors.transparent,
            ],
            stops: [0, .95],
          ),
          // border: Border.all(color:Colors.black12)
        )
       )
      )
      );
  }
}
