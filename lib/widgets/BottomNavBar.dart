import 'package:flutter/material.dart';

class CommonBottomNavBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items:const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        )
      ]
    );
  }
}


