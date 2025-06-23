import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/custom_assets/assets.gen.dart';
import '../../../../utils/app_colors/app_colors.dart';
import '../../../../utils/text_style/text_style.dart';
import '../../../widgets/custom_bottons/custom_button/app_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppConfigScreen(),
    );
  }
}

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
        title: Text('App Configuration'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notifications',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Control how and when you receive notifications.',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Push Notifications',
                  style: TextStyle(fontSize: 16),
                ),
                Switch(
                  focusColor: AppColors.primary,
                  activeColor: AppColors.primary,
                  value: _pushNotifications,
                  onChanged: (value) {
                    setState(() {
                      _pushNotifications = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.all(10.w),
              height: 104.w,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                // color: Colors.white,
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
                              _selectedLanguage = 'English';
                            });
                          },
                          width: 100.w,
                          height: 29.w,
                          borderRadius: 50.r,
                          backgroundColor: _selectedLanguage == 'English'
                              ? AppColors.primary
                              : Color(0xffF2F2F2),
                          textStyle: _selectedLanguage == 'English'
                              ? AppStyle.roboto12w500CFFFFFF
                              : AppStyle.roboto12w400C000000),
                      SizedBox(width: 8),
                      AppButton(
                          text: 'Spanish',
                          onPressed: () {
                            setState(() {
                              _selectedLanguage = 'Spanish';
                            });
                          },
                          width: 100.w,
                          height: 29.w,
                          borderRadius: 50.r,
                          backgroundColor: _selectedLanguage == 'Spanish'
                              ? AppColors.primary
                              : Color(0xffF2F2F2),
                          textStyle: _selectedLanguage == 'Spanish'
                              ? AppStyle.roboto12w500CFFFFFF
                              : AppStyle.roboto12w400C000000),
                    ],
                  ),
                ],
              ),
            ),
            // Spacer(),
            Gap(40.w),
            AppButton(
              text: 'Save Changes',
              onPressed: () {
                // Handle save changes action
              },
              height: 35,
              backgroundColor: const Color(0xFF77E9D6),
              borderRadius: 5,
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
