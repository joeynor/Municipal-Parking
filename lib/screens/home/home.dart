import 'package:flutter/material.dart';
import 'package:municipal_parking/screens/home/qrcode.dart';
import 'package:municipal_parking/widgets/Common.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:municipal_parking/screens/home/account.dart';

class HomeScreen extends StatefulWidget{
  @override
  HomeScreenState createState()=>HomeScreenState();
 }  

class HomeScreenState extends State<HomeScreen>{
  int _currentIndex;
  List<BottomNavigationBarItem> _bottomNavigationBarItems;
  bool _showBottomNavBar;
  BuildContext context;
  ColorScheme colorScheme;
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    _showBottomNavBar=true;
    _currentIndex=0; 
    _bottomNavigationBarItems=[
      BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("Home")),
      BottomNavigationBarItem(icon: Icon(Icons.notifications),title:Text("Notifications")),
      BottomNavigationBarItem(icon: Icon(Icons.history),title:Text("History")),
      BottomNavigationBarItem(icon: Icon(Icons.account_box),title:Text("Account")),
      // BottomNavigationBarItem(icon: Icon(Icons.settings_applications),title:Text("Settings")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    this.context=context;
    colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // key:_scaffoldKey,
      backgroundColor: _currentIndex==0?Colors.black12:Colors.white,
      appBar: currentAppBar(),
      body: currentBody(),
      bottomNavigationBar: Visibility(
        visible: _showBottomNavBar,
        maintainSize: true,
        maintainState: true,
        maintainAnimation: true,
        child: BottomNavigationBar(
          showUnselectedLabels:false,
          items: _bottomNavigationBarItems,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: textTheme.caption.fontSize,
          unselectedFontSize: textTheme.caption.fontSize,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: colorScheme.onPrimary,
          unselectedItemColor: colorScheme.onPrimary.withOpacity(0.38),
          backgroundColor: colorScheme.primary,
          selectedIconTheme: Theme.of(context).accentIconTheme,
          unselectedIconTheme: Theme.of(context).iconTheme,
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child:Icon(Icons.add), 
      //   onPressed: (){
      //       Navigator.pushNamed(context, '/login');
      //   }
      // ),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget currentAppBar(){
    // return Common.myAppBar();
    return commonAppBar;
  }

  Widget currentBody(){
    switch(_currentIndex){
      case 0:
        return QRcodeWindow(navBarVisibility: _navBarCallBack,);
      case 3:
        // Scaffold.of(context).openDrawer();
        // _scaffoldKey.currentState.openDrawer();
        return AccountWindow();
      default:
        return Center(child: Text("$_currentIndex"),);
    }
  }
  void _navBarCallBack(bool flag){
    setState(() {
      this._showBottomNavBar=flag;
    });
  }

  void dispose(){
    this._showBottomNavBar=true;
    super.dispose();
  }


}
