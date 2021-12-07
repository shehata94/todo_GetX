import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_getx/controllers/task_controller.dart';
import 'package:todo_getx/db/db_helper.dart';
import 'package:todo_getx/models/task.dart';
import 'package:todo_getx/services/notification_services.dart';
import 'package:todo_getx/services/theme_services.dart';
import 'package:todo_getx/ui/add_task_bar.dart';
import 'package:todo_getx/ui/theme.dart';
import 'package:todo_getx/ui/widgets/button.dart';
import 'package:todo_getx/ui/widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();
  final taskController = Get.put(TaskController());
  var notifyHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    taskController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          _showTask(),
        ],
      ),
    );
  }

  _showTask() => Expanded(child: Obx(() {
        return ListView.builder(
            itemCount: taskController.taskList.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            _showBottomSheet(context,taskController.taskList[index]);

                          },
                          child: TaskTile(taskController.taskList[index]),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      }));
  _addDateBar() => Container(
        margin: const EdgeInsets.only(top: 20, left: 20,bottom: 15),
        child: DatePicker(
          DateTime.now(),
          height: 100,
          width: 80,
          initialSelectedDate: DateTime.now(),
          selectionColor: primaryClr,
          selectedTextColor: Colors.white,
          dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          monthTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          onDateChange: (date) {
            selectedDate = date;
          },
        ),
      );
  _addTaskBar() => Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat.yMMMd().format(DateTime.now()), style: subHeadingStyle),
                  Text(
                    "Today",
                    style: headingStyle,
                  ),
                ],
              ),
            ),
            MyButton(
              label: "+ Add Task",
              onTap: () {
                Get.to(() => AddTaskBar());
              },
            )
          ],
        ),
      );
  _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: IconButton(
        icon: Icon(
          !Get.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
        onPressed: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(title: "Theme Changed", body: !Get.isDarkMode ? "Activated Dark Theme" : "Activated Light Theme");
        },
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage("images/profile.png"),
        ),
      ],
    );
  }
  _bottomSheetButton({
    String label,
    Function onTap,
    Color clr,
    bool isClose = false,
    BuildContext context
}){
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
            color: isClose?Colors.transparent:clr,
            border: Border.all(
            width: 2,
            color: isClose?Get.isDarkMode?Colors.grey[600]:Colors.grey[300]:clr,
          ),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(child: Text(label,
        style: isClose?titleStyle:titleStyle.copyWith(color: Colors.white),)),
      ),
    );

  }
  _showBottomSheet(BuildContext context, Task task){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height*0.24
            : MediaQuery.of(context).size.height*0.32,
        color: Get.isDarkMode?darkGreyClr:white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
              ),
            ),
            Spacer(),
            task.isCompleted ==1
            ? Container()
                : _bottomSheetButton(
              label: "Task Completed",
              onTap: (){
                taskController.markTaskCompleted(task.id);
                Get.back();
              },
              clr: primaryClr,
              context: context
            ),
            SizedBox(height: 5,),
            _bottomSheetButton(
                label: "Delete Task",
                onTap: (){
                  taskController.delete(task);
                  Get.back();
                },
                clr: Colors.red[300],
                context: context
            ),
            SizedBox(height: 15,),
            _bottomSheetButton(
                label: "Close",
                onTap: (){
                  Get.back();
                },
                isClose: true,
                clr: Colors.red[300],
                context: context
            ),
            SizedBox(height: 10,)
          ],
        ),
      )
    );
  }
}
