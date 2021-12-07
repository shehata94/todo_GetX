import 'package:get/get.dart';
import 'package:todo_getx/db/db_helper.dart';
import 'package:todo_getx/models/task.dart';

class TaskController extends GetxController{
   @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }
  
  Future<int> addTask({Task task})async{
     return await DBHelper.insert(task);
  }
}