import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:groc_shopy/core/custom_assets/assets.gen.dart';
import 'package:groc_shopy/core/routes/route_path.dart';
import 'package:groc_shopy/helper/extension/base_extension.dart';
import 'package:groc_shopy/utils/app_colors/app_colors.dart';
import 'package:groc_shopy/utils/text_style/text_style.dart';
import 'package:get/get.dart';

import '../../widgets/custom_bottons/custom_button/app_button.dart';
import 'package:groc_shopy/presentation/screens/home/controller/home_controller.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedLanguage = 'English';
  String selectedTheme = 'Light';
  String selectedRingtone = 'Default';
  final HomeController homeController = Get.find<HomeController>();

  // 1. Add default color as the first option
  final List<Color> colorOptions = [
    const Color(0xffC9867B), // Default color
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.cyan,
    Colors.purple,
    Colors.pink,
  ];

  // Local state for pending color selection
  late Color pendingIconColor;
  final Color defaultColor = const Color(0xffC9867B);

  @override
  void initState() {
    super.initState();
    // 2. Set pendingIconColor to the controller's color (from local db or default)
    pendingIconColor = homeController.selectedIconColor.value;
  }

  void _resetToDefault() {
    // 3. Set both controller and pending color to default
    homeController.resetToDefault();
    setState(() {
      pendingIconColor = defaultColor;
    });
  }

  void _saveChanges() {
    homeController.setIconColor(pendingIconColor);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Changes saved!'),
        duration: Duration(seconds: 1),
        backgroundColor: AppColors.primary.withOpacity(0.6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 40.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Text(
                      'Settings',
                      style: AppStyle.kohSantepheap20w400C030303,
                    ),
                    InkWell(
                      onTap: () {
                        context.pushReplacement(RoutePath.login.addBasePath);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 30.w,
                        height: 30.w,
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 0.5.w),
                        ),
                        child: SvgPicture.asset(
                          Assets.icons.logout.path,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Icon Color Picker
              Container(
                padding: EdgeInsets.all(10.w),
                height: 116.w,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Assets.icons.chooseYourIconColor.path),
                        Gap(10.w),
                        Text('Choose your icon color',
                            style: AppStyle.roboto14w400C000000),
                      ],
                    ),
                    Gap(8.h),
                    Row(
                      children: [
                        Gap(15.w),
                        ...colorOptions.map((color) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  pendingIconColor = color;
                                });
                              },
                              child: ColorCircle(
                                color: color,
                                isSelected: pendingIconColor == color,
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(16.h),

              // Language Picker
              Container(
                padding: EdgeInsets.all(10.w),
                height: 104.w,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Assets.icons.chooseYourLanguage.path),
                        Gap(10.w),
                        Text('Choose your language',
                            style: AppStyle.roboto14w400C000000),
                      ],
                    ),
                    Gap(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Gap(30.w),
                        AppButton(
                          text: 'English',
                          onPressed: () {
                            setState(() {
                              selectedLanguage = 'English';
                            });
                          },
                          width: 100.w,
                          height: 29.h,
                          borderRadius: 50.r,
                          backgroundColor: selectedLanguage == 'English'
                              ? AppColors.primary
                              : const Color(0xffF2F2F2),
                          textStyle: selectedLanguage == 'English'
                              ? AppStyle.roboto12w500CFFFFFF
                              : AppStyle.roboto12w400C000000,
                        ),
                        Gap(8.w),
                        AppButton(
                          text: 'Spanish',
                          onPressed: () {
                            setState(() {
                              selectedLanguage = 'Spanish';
                            });
                          },
                          width: 110.w,
                          height: 29.h,
                          borderRadius: 50.r,
                          backgroundColor: selectedLanguage == 'Spanish'
                              ? AppColors.primary
                              : const Color(0xffF2F2F2),
                          textStyle: selectedLanguage == 'Spanish'
                              ? AppStyle.roboto12w500CFFFFFF
                              : AppStyle.roboto12w400C000000,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Gap(16.h),

              // Theme Picker
              // Container(
              //   padding: EdgeInsets.all(10.w),
              //   height: 104.w,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10.r),
              //     color: Colors.white,
              //     border: Border.all(
              //       color: Colors.black.withOpacity(0.1),
              //     ),
              //   ),
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           SvgPicture.asset(Assets.icons.switchAppTheme.path),
              //           Gap(10.w),
              //           Text('Switch app theme:',
              //               style: AppStyle.roboto14w400C000000),
              //         ],
              //       ),
              //       Gap(20.h),
              //       Row(
              //         children: [
              //           Gap(30.w),
              //           AppButton(
              //             text: 'Light',
              //             onPressed: () {
              //               setState(() {
              //                 selectedTheme = 'Light';
              //               });
              //             },
              //             width: 95.w,
              //             height: 29.h,
              //             borderRadius: 50.r,
              //             backgroundColor: selectedTheme == 'Light'
              //                 ? AppColors.primary
              //                 : const Color(0xffF2F2F2),
              //             textStyle: selectedTheme == 'Light'
              //                 ? AppStyle.roboto12w500CFFFFFF
              //                 : AppStyle.roboto12w400C000000,
              //           ),
              //           Gap(8.w),
              //           AppButton(
              //             text: 'Pastel',
              //             onPressed: () {
              //               setState(() {
              //                 selectedTheme = 'Pastel';
              //               });
              //             },
              //             width: 95.w,
              //             height: 29.h,
              //             borderRadius: 50.r,
              //             backgroundColor: selectedTheme == 'Pastel'
              //                 ? AppColors.primary
              //                 : const Color(0xffF2F2F2),
              //             textStyle: selectedTheme == 'Pastel'
              //                 ? AppStyle.roboto12w500CFFFFFF
              //                 : AppStyle.roboto12w400C000000,
              //           ),
              //           Gap(8.w),
              //           AppButton(
              //             text: 'Dark',
              //             onPressed: () {
              //               setState(() {
              //                 selectedTheme = 'Dark';
              //               });
              //             },
              //             width: 95.w,
              //             height: 29.h,
              //             borderRadius: 50.r,
              //             backgroundColor: selectedTheme == 'Dark'
              //                 ? AppColors.primary
              //                 : const Color(0xffF2F2F2),
              //             textStyle: selectedTheme == 'Dark'
              //                 ? AppStyle.roboto12w500CFFFFFF
              //                 : AppStyle.roboto12w400C000000,
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              Gap(16.h),

              // Ringtone Picker
              Container(
                padding: EdgeInsets.all(10.w),
                height: 104.w,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(Assets.icons.ringtone.path),
                        Gap(10.w),
                        Text('Ringtone', style: AppStyle.roboto14w400C000000),
                      ],
                    ),
                    Gap(8.h),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Gap(20.w),
                          AppButton(
                            text: 'Default',
                            onPressed: () {
                              setState(() {
                                selectedRingtone = 'Default';
                              });
                            },
                            width: 100.w,
                            height: 29.h,
                            borderRadius: 50.r,
                            backgroundColor: selectedRingtone == 'Default'
                                ? AppColors.primary
                                : const Color(0xffF2F2F2),
                            textStyle: selectedRingtone == 'Default'
                                ? AppStyle.roboto12w500CFFFFFF
                                : AppStyle.roboto12w400C000000,
                          ),
                          Gap(8.w),
                          AppButton(
                            text: 'Quad',
                            onPressed: () {
                              setState(() {
                                selectedRingtone = 'Quad';
                              });
                            },
                            width: 100.w,
                            height: 29.h,
                            borderRadius: 50.r,
                            backgroundColor: selectedRingtone == 'Quad'
                                ? AppColors.primary
                                : const Color(0xffF2F2F2),
                            textStyle: selectedRingtone == 'Quad'
                                ? AppStyle.roboto12w500CFFFFFF
                                : AppStyle.roboto12w400C000000,
                          ),
                          Gap(8.w),
                          AppButton(
                            text: 'Radial',
                            onPressed: () {
                              setState(() {
                                selectedRingtone = 'Radial';
                              });
                            },
                            width: 100.w,
                            height: 29.h,
                            borderRadius: 50.r,
                            backgroundColor: selectedRingtone == 'Radial'
                                ? AppColors.primary
                                : const Color(0xffF2F2F2),
                            textStyle: selectedRingtone == 'Radial'
                                ? AppStyle.roboto12w500CFFFFFF
                                : AppStyle.roboto12w400C000000,
                          ),
                          Gap(8.w),
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.add,
                              size: 25.r,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              context.push(RoutePath
                                  .ringtoneSelectionScreen.addBasePath);
                            },
                            style: IconButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: const Color(0xffF2F2F2),
                              shape: const OvalBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Gap(40.h),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    text: 'Reset to Default',
                    onPressed: _resetToDefault,
                    width: 167.w,
                    height: 40.h,
                    borderRadius: 50.r,
                    textStyle: AppStyle.inter13w400C000000,
                    backgroundColor: Colors.white,
                    borderColor: Colors.black,
                    borderWidth: 1.w,
                  ),
                  Gap(20.w),
                  AppButton(
                    text: 'Save Changes',
                    onPressed: _saveChanges,
                    width: 167.w,
                    height: 40.h,
                    borderRadius: 50.r,
                    backgroundColor: AppColors.primary,
                    textStyle: AppStyle.inter13w900CFFFFFF,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorCircle extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const ColorCircle({Key? key, required this.color, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.w,
      height: 30.h,
      margin: EdgeInsets.only(right: 8.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: isSelected
            ? Border.all(color: AppColors.primary, width: 3.w)
            : null,
      ),
      child: isSelected
          ? Icon(Icons.check, color: Colors.white, size: 18.r)
          : null,
    );
  }
}
