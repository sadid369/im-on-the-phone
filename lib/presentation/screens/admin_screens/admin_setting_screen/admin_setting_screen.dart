import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:groc_shopy/core/routes/route_path.dart';
import 'package:groc_shopy/core/routes/routes.dart';
import 'package:groc_shopy/helper/extension/base_extension.dart';
import 'package:groc_shopy/utils/text_style/text_style.dart';

import '../../../../core/custom_assets/assets.gen.dart';
import '../../../widgets/custom_bottons/custom_button/app_button.dart';

class AdminSettingsScreen extends StatelessWidget {
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
                // padding: EdgeInsets.symmetric(horizontal: 16.0),
                height: kToolbarHeight,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Settings',
                      style: AppStyle.kohSantepheap18w700C1E1E1E,
                    ),
                  ],
                ),
              ),
              Gap(20.h),
              Container(
                height: 100.w,
                width: double.infinity,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundImage: AssetImage(Assets.images.profileImage
                          .path), // Replace with your image asset
                    ),
                    Gap(19.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Admin',
                          style: AppStyle.robotoMono18w500C030303,
                        ),
                        Text(
                          'admin@example.com',
                          style: AppStyle.roboto14w400C808080,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              Container(
                width: double.infinity,
                height: 47,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 21),
                decoration: BoxDecoration(
                  color: const Color(0x33D9D9D9),
                  // borderRadius: BorderRadius.circular(50),
                  border: Border(
                    top:
                        BorderSide(width: 1, color: Colors.black.withAlpha(51)),
                    bottom:
                        BorderSide(width: 1, color: Colors.black.withAlpha(51)),
                  ),
                ),
                child: Text(
                  'Profile & Account',
                  style: AppStyle.roboto14w600C999999,
                ),
              ),
              Gap(20.h),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                ),
                child: ListTile(
                  leading:
                      Icon(Icons.person_outlined, color: Colors.grey.shade600),
                  title: Text(
                    'Update Profile',
                    style: AppStyle.roboto16w400C000000,
                  ),
                  onTap: () {
                    // Handle update profile logic
                    context.push(
                        '${RoutePath.adminSettings.addBasePath}/${RoutePath.adminUpdateProfileScreen}');
                  },
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.grey.shade600),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                ),
                child: ListTile(
                  leading:
                      Icon(Icons.lock_outline, color: Colors.grey.shade600),
                  title: Text(
                    'Change Password',
                    style: AppStyle.roboto16w400C000000,
                  ),
                  onTap: () {
                    context.push(
                        '${RoutePath.adminSettings.addBasePath}/${RoutePath.adminChangePasswordScreen}');
                  },
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.grey.shade600),
                ),
              ),
              Gap(20.h),
              Container(
                width: double.infinity,
                height: 47,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 21),
                decoration: BoxDecoration(
                  color: const Color(0x33D9D9D9),
                  // borderRadius: BorderRadius.circular(50),
                  border: Border(
                    top:
                        BorderSide(width: 1, color: Colors.black.withAlpha(51)),
                    bottom:
                        BorderSide(width: 1, color: Colors.black.withAlpha(51)),
                  ),
                ),
                child: Text(
                  'App Preference',
                  style: AppStyle.roboto14w600C999999,
                ),
              ),
              Gap(20.h),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                ),
                child: ListTile(
                  leading: SvgPicture.asset(Assets.icons.slider.path),
                  title: Text(
                    'App Configurations',
                    style: AppStyle.roboto16w400C000000,
                  ),
                  onTap: () {
                    context.push(
                        '${RoutePath.adminSettings.addBasePath}/${RoutePath.appConfigurationsScreen}');
                  },
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.grey.shade600),
                ),
              ),
              Gap(23.w),
              AppButton(
                text: "Logout",
                onPressed: () {},
                width: double.infinity,
                height: 35.h,
                backgroundColor: Colors.grey,
                borderRadius: 8,
                textStyle: AppStyle.inter16w700CFFFFFF,
              )
            ],
          ),
        ),
      ),
    );
  }
}
