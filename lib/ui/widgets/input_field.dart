import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx/ui/theme.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final Widget widget;
  final String validationMessage;

  const MyInputField({Key key, @required this.title,@required this.hint, this.controller, this.widget, this.validationMessage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:16),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            height: 52,
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children: [
                Expanded(child: TextFormField(
                  validator: (String value){
                      return value.isEmpty? validationMessage:null;
                  },
                  autofocus: false,
                  cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                  controller: controller,
                  style: subtitleStyle,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: subtitleStyle,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: context.theme.backgroundColor,
                        width: 0
                      )
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0
                        )
                    )
                  ),
                )),
                widget == null?Container():Container(child:widget),
              ],
            ),
          )

        ],
      )
    );
  }
}
