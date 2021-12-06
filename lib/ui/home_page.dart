import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/services/notification_services.dart';
import 'package:todo_getx/services/theme_services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          Text("Theme Data",
          style: Theme.of(context).textTheme.headline2.copyWith(
            fontSize: 30
          ),)
        ],
      ),

    );
  }

  _appBar(){
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.nightlight_round,
        size: 20,),
        onPressed: (){
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title:"Theme Changed",
            body:!Get.isDarkMode?"Activated Dark Theme" : "Activated Light Theme"
          );
        },
      ),
      actions: [
      Icon(Icons.person,
      size: 20,),

      ],
    );
  }
}
