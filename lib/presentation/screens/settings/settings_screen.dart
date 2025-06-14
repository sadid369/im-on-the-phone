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

import '../../widgets/custom_bottons/custom_button/app_button.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedLanguage = 'English';
  String selectedTheme = 'Light';
  String selectedRingtone = 'Default';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 40.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
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
                              border: Border.all(width: 0.5.w)),
                          child: SvgPicture.asset(
                            Assets.icons.logout.path,
                          )),
                    ),
                  ],
                ),
              ),
              // Icon Color Picker
              Container(
                padding: EdgeInsets.all(10.w),
                height: 116.w,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
                child: Column(
                  spacing: 10.w,
                  children: [
                    Row(
                      spacing: 10.w,
                      children: [
                        SvgPicture.asset(Assets.icons.chooseYourIconColor.path),
                        Text('Choose your icon color',
                            style: AppStyle.roboto14w400C000000),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      spacing: 15.w,
                      children: [
                        SizedBox(
                          width: 15.w,
                        ),
                        ColorCircle(color: Colors.red),
                        ColorCircle(color: Colors.orange),
                        ColorCircle(color: Colors.green),
                        ColorCircle(color: Colors.cyan),
                        ColorCircle(color: Colors.purple),
                        ColorCircle(color: Colors.pink),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Language Picker
              Container(
                padding: EdgeInsets.all(10.w),
                height: 104.w,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  spacing: 20.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      spacing: 10.w,
                      children: [
                        SvgPicture.asset(Assets.icons.chooseYourLanguage.path),
                        Text('Choose your language',
                            style: AppStyle.roboto14w400C000000),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 30.w,
                        ),
                        AppButton(
                            text: 'English',
                            onPressed: () {
                              setState(() {
                                selectedLanguage = 'English';
                              });
                            },
                            width: 100.w,
                            height: 29.w,
                            borderRadius: 50.r,
                            backgroundColor: selectedLanguage == 'English'
                                ? AppColors.primary
                                : Color(0xffF2F2F2),
                            textStyle: selectedLanguage == 'English'
                                ? AppStyle.roboto12w500CFFFFFF
                                : AppStyle.roboto12w400C000000),
                        SizedBox(width: 8),
                        AppButton(
                            text: 'Spanish',
                            onPressed: () {
                              setState(() {
                                selectedLanguage = 'Spanish';
                              });
                            },
                            width: 100.w,
                            height: 29.w,
                            borderRadius: 50.r,
                            backgroundColor: selectedLanguage == 'Spanish'
                                ? AppColors.primary
                                : Color(0xffF2F2F2),
                            textStyle: selectedLanguage == 'Spanish'
                                ? AppStyle.roboto12w500CFFFFFF
                                : AppStyle.roboto12w400C000000),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Theme Picker
              Container(
                padding: EdgeInsets.all(10.w),
                height: 104.w,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                  ),
                ),
                child: Column(
                  spacing: 20.w,
                  children: [
                    Row(
                      spacing: 10.w,
                      children: [
                        SvgPicture.asset(Assets.icons.switchAppTheme.path),
                        Text('Switch app theme:',
                            style: AppStyle.roboto14w400C000000),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30.w,
                        ),
                        AppButton(
                            text: 'Light',
                            onPressed: () {
                              setState(() {
                                selectedTheme = 'Light';
                              });
                            },
                            width: 95.w,
                            height: 29.w,
                            borderRadius: 50.r,
                            backgroundColor: selectedTheme == 'Light'
                                ? AppColors.primary
                                : Color(0xffF2F2F2),
                            textStyle: selectedTheme == 'Light'
                                ? AppStyle.roboto12w500CFFFFFF
                                : AppStyle.roboto12w400C000000),
                        SizedBox(width: 8),
                        AppButton(
                            text: 'Pastel',
                            onPressed: () {
                              setState(() {
                                selectedTheme = 'Pastel';
                              });
                            },
                            width: 95.w,
                            height: 29.w,
                            borderRadius: 50.r,
                            backgroundColor: selectedTheme == 'Pastel'
                                ? AppColors.primary
                                : Color(0xffF2F2F2),
                            textStyle: selectedTheme == 'Pastel'
                                ? AppStyle.roboto12w500CFFFFFF
                                : AppStyle.roboto12w400C000000),
                        SizedBox(width: 8),
                        AppButton(
                            text: 'Dark',
                            onPressed: () {
                              setState(() {
                                selectedTheme = 'Dark';
                              });
                            },
                            width: 95.w,
                            height: 29.w,
                            borderRadius: 50.r,
                            backgroundColor: selectedTheme == 'Dark'
                                ? AppColors.primary
                                : Color(0xffF2F2F2),
                            textStyle: selectedTheme == 'Dark'
                                ? AppStyle.roboto12w500CFFFFFF
                                : AppStyle.roboto12w400C000000),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              // Ringtone Picker
              Container(
                padding: EdgeInsets.all(10.w),
                height: 104.w,
                width: MediaQuery.of(context).size.width,
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
                      spacing: 10.w,
                      children: [
                        SvgPicture.asset(Assets.icons.ringtone.path),
                        Text('Ringtone', style: AppStyle.roboto14w400C000000),
                      ],
                    ),
                    SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 20.w,
                          ),
                          AppButton(
                              text: 'Default',
                              onPressed: () {
                                setState(() {
                                  selectedRingtone = 'Default';
                                });
                              },
                              width: 86.w,
                              height: 29.w,
                              borderRadius: 50.r,
                              backgroundColor: selectedRingtone == 'Default'
                                  ? AppColors.primary
                                  : Color(0xffF2F2F2),
                              textStyle: selectedRingtone == 'Default'
                                  ? AppStyle.roboto12w500CFFFFFF
                                  : AppStyle.roboto12w400C000000),
                          SizedBox(width: 8),
                          AppButton(
                            text: 'Quad',
                            onPressed: () {
                              setState(() {
                                selectedRingtone = 'Quad';
                              });
                            },
                            width: 86.w,
                            height: 29.w,
                            borderRadius: 50.r,
                            backgroundColor: selectedRingtone == 'Quad'
                                ? AppColors.primary
                                : Color(0xffF2F2F2),
                            textStyle: selectedRingtone == 'Quad'
                                ? AppStyle.roboto12w500CFFFFFF
                                : AppStyle.roboto12w400C000000,
                          ),
                          SizedBox(width: 8),
                          AppButton(
                              text: 'Radial',
                              onPressed: () {
                                setState(() {
                                  selectedRingtone = 'Radial';
                                });
                              },
                              width: 86.w,
                              height: 29.w,
                              borderRadius: 50.r,
                              backgroundColor: selectedRingtone == 'Radial'
                                  ? AppColors.primary
                                  : Color(0xffF2F2F2),
                              textStyle: selectedRingtone == 'Radial'
                                  ? AppStyle.roboto12w500CFFFFFF
                                  : AppStyle.roboto12w400C000000),
                          IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.add,
                                size: 25.r, // Icon size
                                color: Colors.black, // Icon color
                              ),
                              onPressed: () {},
                              style: IconButton.styleFrom(
                                padding: EdgeInsets.zero,
                                backgroundColor: Color(0xffF2F2F2),
                                shape: OvalBorder(),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Gap(40.w),

              // Buttons
              Row(
                spacing: 20.w,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppButton(
                    text: 'Reset to Default',
                    onPressed: () {},
                    width: 167.w,
                    height: 40.w,
                    borderRadius: 50.r,
                    textStyle: AppStyle.inter13w400C000000,
                    backgroundColor: Colors.white,
                    borderColor: Colors.black,
                    borderWidth: 1.w,
                  ),
                  AppButton(
                    text: 'Save Changes',
                    onPressed: () {},
                    width: 167.w,
                    height: 40.w,
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

  const ColorCircle({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
