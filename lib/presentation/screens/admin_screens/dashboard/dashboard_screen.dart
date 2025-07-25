import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:groc_shopy/core/custom_assets/assets.gen.dart';
import 'package:groc_shopy/helper/extension/base_extension.dart';
import 'package:groc_shopy/utils/app_colors/app_colors.dart';

import '../../../../core/routes/route_path.dart';
import '../../../../utils/static_strings/static_strings.dart';
import '../../../../utils/text_style/text_style.dart';
import '../../../widgets/custom_bottons/custom_button/app_button.dart';
import '../admin_setting_screen/controller/admin_settings_controller.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final adminController = Get.find<AdminSettingsController>();
    if (adminController.userProfile.value == null) {
      adminController.loadUserProfile(context);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(AppStrings.dashboard.tr), // <-- Added .tr
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 25.w),
            child: Obx(() {
              final profile = adminController.userProfile.value;
              final imageUrl = profile
                  ?.image!.addBaseUrl; // Remove ! and .addBaseUrl if not needed

              // Debug print
              print('Profile image url: $imageUrl');

              return CircleAvatar(
                radius: 20,
                backgroundImage: (imageUrl != null && imageUrl.isNotEmpty)
                    ? NetworkImage(imageUrl)
                    : AssetImage(Assets.images.profileImage.path)
                        as ImageProvider,
              );
            }),
          ),
        ],
        elevation: 0, // Remove default shadow if you want only the line
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade300, // Line color
            height: 1.0,
            width: double.infinity,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Subscribers Section
              Container(
                padding: EdgeInsets.all(15.w),
                height: 95.w,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                // padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.totalSubscribers.tr, // <-- Added .tr
                          style: AppStyle.roboto12w500C666666,
                        ),
                        Gap(12.w),
                        Row(
                          spacing: 10.w,
                          children: [
                            SvgPicture.asset(
                              Assets.icons.users.path,
                              color: AppColors.primary,
                              width: 24.w,
                              height: 24.w,
                            ),
                            Text(
                              "1,002",
                              style: AppStyle.roboto28w500C000000,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(20.w),
              // Manage Users and App Settings Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 20.w,
                children: [
                  AppButton(
                    text: AppStrings.manageUsers.tr, // <-- Added .tr
                    onPressed: () {
                      context.goNamed(RoutePath.adminUser);
                    },
                    width: double.infinity,
                    height: 48.h,
                    backgroundColor: AppColors.primary,
                    borderRadius: 8,
                    textStyle: AppStyle.inter16w700CFFFFFF,
                    icon: SvgPicture.asset(
                      Assets.icons.users.path,
                      color: Colors.white,
                    ),
                  ),
                  AppButton(
                    text: AppStrings.appSettings.tr, // <-- Added .tr
                    onPressed: () {
                      context.goNamed(RoutePath.adminSettings);
                    },
                    width: double.infinity,
                    height: 48.h,
                    backgroundColor: AppColors.primary,
                    borderRadius: 8,
                    textStyle: AppStyle.inter16w700CFFFFFF,
                    icon: SvgPicture.asset(
                      Assets.icons.settings.path,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32),

              // Monthly User Growth Chart
              Container(
                padding: EdgeInsets.all(16),
                height: 280.w,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // <-- Add this line
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.monthlyUserGrowth.tr, // <-- Added .tr
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 140.w,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 8),
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(
                              show: true,
                              horizontalInterval: 50,
                              verticalInterval: 1,
                              drawVerticalLine:
                                  false, // <-- This removes vertical grid lines
                            ),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 50,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      value.toInt().toString(),
                                      style: TextStyle(fontSize: 12),
                                    );
                                  },
                                ),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles: false), // <-- Hide top X-axis
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 36,
                                  interval: 1,
                                  getTitlesWidget: (value, meta) {
                                    String text = '';
                                    switch (value.toInt()) {
                                      case 0:
                                        text =
                                            AppStrings.jan.tr; // <-- Added .tr
                                        break;
                                      case 1:
                                        text =
                                            AppStrings.feb.tr; // <-- Added .tr
                                        break;
                                      case 2:
                                        text =
                                            AppStrings.mar.tr; // <-- Added .tr
                                        break;
                                      case 3:
                                        text =
                                            AppStrings.apr.tr; // <-- Added .tr
                                        break;
                                      case 4:
                                        text =
                                            AppStrings.may.tr; // <-- Added .tr
                                        break;
                                      case 5:
                                        text =
                                            AppStrings.jun.tr; // <-- Added .tr
                                        break;
                                      default:
                                        text = '';
                                    }
                                    return Text(text);
                                  },
                                ),
                              ),
                            ),
                            borderData: FlBorderData(
                              show: false, // <-- Remove the border
                              // border: Border.all(color: Colors.black, width: 1), // You can remove or comment this line
                            ),
                            minX: 0,
                            maxX: 5,
                            minY: 0,
                            maxY: 200,
                            lineBarsData: [
                              LineChartBarData(
                                  spots: [
                                    FlSpot(0, 70), // Jan
                                    FlSpot(1, 100), // Feb
                                    FlSpot(2, 120), // Mar
                                    FlSpot(3, 170), // Apr
                                    FlSpot(4, 185), // May
                                    FlSpot(5, 195), // Jun
                                  ],
                                  isCurved: true,
                                  color:
                                      AppColors.primary, // <-- Chart line color
                                  belowBarData: BarAreaData(
                                      show: true, color: Color(0xFFD0FFF7)
                                      // <-- Area below line
                                      ),
                                  dotData: FlDotData(show: false)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
