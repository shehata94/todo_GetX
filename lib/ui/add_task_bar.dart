import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_getx/ui/theme.dart';
import 'package:todo_getx/ui/widgets/button.dart';
import 'package:todo_getx/ui/widgets/input_field.dart';

class AddTaskBar extends StatefulWidget {
  @override
  _AddTaskBarState createState() => _AddTaskBarState();
}

class _AddTaskBarState extends State<AddTaskBar> {
  var selectedDate = DateTime.now();
  var startTime = DateFormat("hh:mm a").format(DateTime.now());
  var endTime = DateFormat("hh:mm a").format(DateTime.now().add(Duration(hours: 1)));
  int selectedRemind = 5;
  List<int> remindList =[5,10,15,20];
  String selectedRepeat = "None";
  List<String> repeatList =["None","Daily","Weekly","Monthly"];
  int selectedColor = 0;
  List<Color> colors=[primaryClr,pinkClr,yellowClr];
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  var _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Task",
                  style: headingStyle,
                ),
                MyInputField(title: "Title", hint: "Enter title here ",controller: titleController,validationMessage: "Title must not be empty",),
                MyInputField(title: "Note", hint: "Enter note here ",controller: noteController,validationMessage: "Note must not be empty",),
                MyInputField(
                  title: "Date",
                  hint: DateFormat.yMd().format(selectedDate).toString(),
                  widget: IconButton(
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () async {
                      selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2016),
                        lastDate: DateTime(2023),
                      );
                      setState(() {});
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: MyInputField(
                      title: "Start Time",
                      hint: startTime,
                      widget: IconButton(
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () async {
                          TimeOfDay pickerTime = await showTimePicker(
                            initialEntryMode: TimePickerEntryMode.input,
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          startTime = pickerTime.format(context);
                          setState(() {});
                        },
                      ),
                    )),
                    SizedBox(width: 15,),
                    Expanded(
                        child: MyInputField(
                          title: "End Time",
                          hint: endTime,
                          widget: IconButton(
                            icon: Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey,
                            ),
                            onPressed: () async {
                              TimeOfDay pickerTime = await showTimePicker(
                                initialEntryMode: TimePickerEntryMode.input,
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              endTime = pickerTime.format(context);
                              setState(() {});
                            },
                          ),
                        )),
                  ],
                ),
                MyInputField(title: "Remind", hint: "$selectedRemind minutes early",
                widget: DropdownButton(
                  icon:Icon(Icons.keyboard_arrow_down,
                  color: Colors.grey,),
                  iconSize: 32,
                  elevation: 4,
                  style: subtitleStyle,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String value){
                    setState(() {
                      selectedRemind =int.parse(value);
                    });
                  },
                  items: remindList.map<DropdownMenuItem<String>>((int value) => DropdownMenuItem<String>(value: value.toString(),child: Text("$value") )).toList()
                ),),
                MyInputField(title: "Repeat", hint: "$selectedRepeat",
                  widget: DropdownButton(
                      icon:Icon(Icons.keyboard_arrow_down,
                        color: Colors.grey,),
                      iconSize: 32,
                      elevation: 4,
                      style: subtitleStyle,
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (String value){
                        setState(() {
                          selectedRepeat = value;
                        });
                      },

                      items: repeatList.map<DropdownMenuItem<String>>((String value) => DropdownMenuItem<String>(value:value,child: Text(value) )).toList()
                  ),),
                SizedBox(height: 18,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Color",style: titleStyle,),
                        SizedBox(height: 8,),
                        Wrap(
                          children: List<Widget>.generate(3,(int index){return
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                selectedColor = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right:8.0),
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: colors[index],
                                child: selectedColor==index?Icon(Icons.done,
                                size: 16,
                                color: Colors.white,):Container(),
                              ),
                            ),
                          );},),
                        )
                      ],
                    ),
                    MyButton(label: "Create Task",onTap: (){
                      _key.currentState.validate();
                      _validate();
                    },)
                  ],
                ),
                SizedBox(height: 40,)

              ],
            ),
          ),
        ),
      ),
    );
  }

  _validate() {
    if(titleController.text.isNotEmpty && noteController.text.isNotEmpty)
      Get.back();
    else if(titleController.text.isEmpty || noteController.text.isEmpty)
      Get.snackbar("Required", "All fields are required !",
      snackPosition: SnackPosition.BOTTOM,
      icon: Icon(Icons.warning_amber_outlined,),
      backgroundColor: Colors.white,
      colorText: pinkClr);
  }
  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      actions: [
        CircleAvatar(
          backgroundImage: AssetImage("images/profile.png"),
        ),
      ],
    );
  }
}
