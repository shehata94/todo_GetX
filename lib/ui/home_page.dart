import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_getx/services/notification_services.dart';
import 'package:todo_getx/services/theme_services.dart';
import 'package:todo_getx/ui/add_task_bar.dart';
import 'package:todo_getx/ui/theme.dart';
import 'package:todo_getx/ui/widgets/button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();
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
          _addTaskBar(),
          _addDateBar(),

        ],
      ),

    );
  }
  _addDateBar()=> Container(
    margin: const EdgeInsets.only(top: 20,left: 20),
    child: DatePicker(
      DateTime.now(),
      height: 100,
      width: 80,
      initialSelectedDate: DateTime.now(),
      selectionColor: primaryClr,
      selectedTextColor: Colors.white,
      dateTextStyle: GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey
        ),
      ),
      dayTextStyle: GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey
        ),
      ),
      monthTextStyle: GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey
        ),
      ),
      onDateChange: (date){
        selectedDate = date;
      },

    ),
  );
  _addTaskBar()=> Container(
    margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat.yMMMd().format(DateTime.now()),
                  style: subHeadingStyle),
              Text("Today",
                style: headingStyle,),
            ],
          ),
        ),
        MyButton(
          label: "+ Add Task",onTap:(){
            Get.to(()=>AddTaskBar());
            },
        )
      ],

    ),
  );
  _appBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: IconButton(
        icon: Icon(!Get.isDarkMode ? Icons.nightlight_round:Icons.wb_sunny,
        size: 20,
        color: Get.isDarkMode ? Colors.white: Colors.black,),
        onPressed: (){
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title:"Theme Changed",
            body:!Get.isDarkMode?"Activated Dark Theme" : "Activated Light Theme"
          );
        },
      ),
      actions: [
      CircleAvatar(
        backgroundImage: AssetImage(
          "images/profile.png"
        ),
      ),

      ],
    );
  }
}
