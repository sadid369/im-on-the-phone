import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/custom_assets/assets.gen.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/text_style/text_style.dart';
import '../../../widgets/custom_bottons/custom_button/app_button.dart';

class AppConfigScreen extends StatefulWidget {
  @override
  _AppConfigScreenState createState() => _AppConfigScreenState();
}

class _AppConfigScreenState extends State<AppConfigScreen> {
  bool _pushNotifications = true;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'App Configuration',
          style: AppStyle.kohSantepheap18w700C1E1E1E,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.r),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              height: 155.w,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                  width: 1.w,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notifications',
                    style: AppStyle.roboto16w500C000000,
                  ),
                  Gap(4.h),
                  Text(
                    'Control how and when you receive notifications.',
                    style: AppStyle.roboto14w400C808080,
                  ),
                  Gap(16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundColor: const Color(0xFFD2FFF7),
                        child: Icon(
                          Icons.notifications_outlined,
                          color: AppColors.primary,
                          size: 40.w,
                        ),
                      ),
                      Gap(10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Push Notifications',
                              style: AppStyle.roboto16w500C000000,
                            ),
                            Text(
                              'Receive alerts and updates via\n push notifications.',
                              style: AppStyle.roboto14w400C808080,
                            ),
                          ],
                        ),
                      ),
                      Gap(10.w),
                      Switch(
                        inactiveTrackColor: Colors.grey[300],
                        activeColor: AppColors.primary,
                        activeTrackColor: AppColors.primary,
                        thumbColor: WidgetStateProperty.all(Colors.white),
                        trackOutlineColor:
                            WidgetStateProperty.all(Colors.transparent),
                        value: _pushNotifications,
                        onChanged: (value) {
                          setState(() {
                            _pushNotifications = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(32.h),
            Container(
              padding: EdgeInsets.all(10.w),
              height: 104.w,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                  width: 1.w,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(Assets.icons.chooseYourLanguage.path,
                          width: 24.w, height: 24.w),
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
                            _selectedLanguage = 'English';
                          });
                        },
                        width: 100.w,
                        height: 29.h,
                        borderRadius: 50.r,
                        backgroundColor: _selectedLanguage == 'English'
                            ? AppColors.primary
                            : const Color(0xffF2F2F2),
                        textStyle: _selectedLanguage == 'English'
                            ? AppStyle.roboto12w500CFFFFFF
                            : AppStyle.roboto12w400C000000,
                      ),
                      Gap(8.w),
                      AppButton(
                        text: 'Spanish',
                        onPressed: () {
                          setState(() {
                            _selectedLanguage = 'Spanish';
                          });
                        },
                        width: 110.w,
                        height: 29.h,
                        borderRadius: 50.r,
                        backgroundColor: _selectedLanguage == 'Spanish'
                            ? AppColors.primary
                            : const Color(0xffF2F2F2),
                        textStyle: _selectedLanguage == 'Spanish'
                            ? AppStyle.roboto12w500CFFFFFF
                            : AppStyle.roboto12w400C000000,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(40.h),
            AppButton(
              text: 'Save Changes',
              onPressed: () {
                // Handle save changes action
              },
              height: 35.h,
              backgroundColor: const Color(0xFF77E9D6),
              borderRadius: 5.r,
              textStyle: AppStyle.inter12w700CFFFFFF,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageButton(String language) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _selectedLanguage = language;
        });
      },
      child: Text(language),
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedLanguage == language
            ? Color(0xFF00BFAE)
            : Colors.grey[200],
        foregroundColor:
            _selectedLanguage == language ? Colors.white : Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }
}
