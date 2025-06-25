import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../helper/local_db/local_db.dart';

class HomeController extends GetxController {
  static const String iconColorKey = 'selected_icon_color';
  static const Color defaultColor = Color(0xffC9867B);

  Rx<Color> selectedIconColor = defaultColor.obs;

  @override
  void onInit() {
    super.onInit();
    loadIconColor();
  }

  void setIconColor(Color color) async {
    selectedIconColor.value = color;
    await SharedPrefsHelper.setString(
        iconColorKey, color.value.toRadixString(16));
  }

  void resetToDefault() async {
    selectedIconColor.value = defaultColor;
    await SharedPrefsHelper.setString(
        iconColorKey, defaultColor.value.toRadixString(16));
  }

  void loadIconColor() async {
    String colorString = await SharedPrefsHelper.getString(iconColorKey);
    if (colorString.isNotEmpty) {
      try {
        selectedIconColor.value = Color(int.parse(colorString, radix: 16));
      } catch (_) {
        selectedIconColor.value = defaultColor;
      }
    } else {
      selectedIconColor.value = defaultColor;
    }
  }
}
