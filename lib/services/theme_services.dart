import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class ThemeService{
  final storage = GetStorage();
  final key = 'isDark';

  bool loadThemeFromStorage () => storage.read(key)??false;
  saveThemeStorage(bool isDark) => storage.write(key, isDark);
  ThemeMode get theme => loadThemeFromStorage()?ThemeMode.dark:ThemeMode.light;

  void switchTheme(){
    Get.changeThemeMode(loadThemeFromStorage()?ThemeMode.light:ThemeMode.dark);
    saveThemeStorage(!loadThemeFromStorage());
  }


}