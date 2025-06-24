import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:groc_shopy/core/custom_assets/assets.gen.dart';

import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/static_strings/static_strings.dart';
import '../../../utils/text_style/text_style.dart';
import '../../widgets/custom_bottons/custom_button/app_button.dart';
import '../../widgets/custom_text_form_field/custom_text_form.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  void dispose() {
    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Container(
                height: kToolbarHeight.h,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1.w),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          color: Colors.black, size: 15.r),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Text(
                      'Change Password',
                      style: AppStyle.kohSantepheap18w700C1E1E1E,
                    ),
                    Gap(15.w),
                  ],
                ),
              ),
              Gap(18.h),
              // Back arrow (replace with IconButton if needed)
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 32.w, top: 0.h),
                width: 12.w,
                height: 24.h,
                // Add your back arrow widget here
              ),
              Text(
                AppStrings.currentPassword.tr,
                style: AppStyle.roboto16w600C2A2A2A,
              ),
              Gap(8.h),
              CustomTextFormField(
                controller: _currentPassword,
                hintText: AppStrings.enterYourCurrentPassword.tr,
                obscureText: _obscurePassword,
                suffixIcon: _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                onSuffixIconTap: _togglePasswordVisibility,
                style: AppStyle.roboto16w500C545454,
                hintStyle: AppStyle.roboto14w500CB3B3B3,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                enabledBorderColor: AppColors.black30opacity4D000000,
                focusedBorderColor: AppColors.primary,
                enabledBorderWidth: 1.5.w,
                focusedBorderWidth: 1.8.w,
                borderRadius: BorderRadius.circular(12.r),
              ),
              Gap(18.h),
              Text(
                AppStrings.newPassword.tr,
                style: AppStyle.roboto16w600C2A2A2A,
              ),
              Gap(8.h),
              CustomTextFormField(
                controller: _newPassword,
                hintText: AppStrings.enterYourCurrentPassword.tr,
                obscureText: _obscurePassword,
                suffixIcon: _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                onSuffixIconTap: _togglePasswordVisibility,
                style: AppStyle.roboto16w500C545454,
                hintStyle: AppStyle.roboto14w500CB3B3B3,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                enabledBorderColor: AppColors.black30opacity4D000000,
                focusedBorderColor: AppColors.primary,
                enabledBorderWidth: 1.5.w,
                focusedBorderWidth: 1.8.w,
                borderRadius: BorderRadius.circular(12.r),
              ),
              Gap(18.h),
              Text(
                AppStrings.confirmNewPassword.tr,
                style: AppStyle.roboto16w600C2A2A2A,
              ),
              Gap(8.h),
              CustomTextFormField(
                controller: _confirmPassword,
                hintText: AppStrings.enterYourCurrentPassword.tr,
                obscureText: _obscurePassword,
                suffixIcon: _obscurePassword
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                onSuffixIconTap: _togglePasswordVisibility,
                style: AppStyle.roboto16w500C545454,
                hintStyle: AppStyle.roboto14w500CB3B3B3,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                enabledBorderColor: AppColors.black30opacity4D000000,
                focusedBorderColor: AppColors.primary,
                enabledBorderWidth: 1.5.w,
                focusedBorderWidth: 1.8.w,
                borderRadius: BorderRadius.circular(12.r),
              ),
              Gap(26.h),
              // Save Changes button
              AppButton(
                text: 'Change Password',
                onPressed: () {
                  // Handle save changes action
                },
                height: 35.h,
                backgroundColor: const Color(0xFF77E9D6),
                borderRadius: 5.r,
                textStyle: AppStyle.inter12w700CFFFFFF,
              ),
              // Add more fields as needed...
            ],
          ),
        ),
      ),
    );
  }
}
