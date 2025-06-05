import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/custom_navbar/custom_navbar.dart';
import '../../widgets/custom_navbar/navbar_controller.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../scan/scan_screen.dart';
import '../transaction_history/transaction_history_screen.dart';

// Your CustomBottomNavBar widget

class MainScreen extends StatelessWidget {
  final BottomNavController controller = Get.put(BottomNavController());

  final List<Widget> pages = [
    HomeScreen(),
    ScanScreen(),
    TransactionHistoryScreen(),
    ProfileScreen(),
  ];

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.selectedIndex.value,
            children: pages,
          )),
      bottomNavigationBar: Obx(() => CustomBottomNavBar(
            selectedIndex: controller.selectedIndex.value,
            onTap: controller.changeIndex,
          )),
    );
  }
}
