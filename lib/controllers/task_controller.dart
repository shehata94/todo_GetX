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

  var taskList = <Task>[].obs;

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task){
    DBHelper.delete(task);
    getTasks();
  }

  void markTaskCompleted(int id)async{
    await DBHelper.update(id);
    getTasks();
  }
  }