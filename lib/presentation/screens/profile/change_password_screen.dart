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
import 'controller/profile_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late final ProfileController profileController;

  @override
  void initState() {
    super.initState();
    profileController = Get.isRegistered<ProfileController>() 
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: profileController.changePasswordFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
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
                        AppStrings.changePassword.tr,
                        style: AppStyle.kohSantepheap18w700C1E1E1E,
                      ),
                      Gap(15.w),
                    ],
                  ),
                ),
                Gap(18.h),
                
                Text(
                  AppStrings.currentPassword.tr,
                  style: AppStyle.roboto16w600C2A2A2A,
                ),
                Gap(8.h),
                Obx(() => CustomTextFormField(
                  controller: profileController.currentPasswordController,
                  validator: profileController.validateCurrentPassword,
                  hintText: AppStrings.enterYourCurrentPassword.tr,
                  obscureText: !profileController.passwordVisible.value,
                  suffixIcon: profileController.passwordVisible.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  onSuffixIconTap: profileController.togglePasswordVisibility,
                  style: AppStyle.roboto16w500C545454,
                  hintStyle: AppStyle.roboto14w500CB3B3B3,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  enabledBorderColor: AppColors.black30opacity4D000000,
                  focusedBorderColor: AppColors.primary,
                  errorBorderColor: Colors.red,
                  focusedErrorBorderColor: Colors.red,
                  enabledBorderWidth: 1.5.w,
                  focusedBorderWidth: 1.8.w,
                  borderRadius: BorderRadius.circular(12.r),
                )),
                Gap(18.h),
                
                Text(
                  AppStrings.newPassword.tr,
                  style: AppStyle.roboto16w600C2A2A2A,
                ),
                Gap(8.h),
                Obx(() => CustomTextFormField(
                  controller: profileController.newPasswordController,
                  validator: profileController.validateNewPassword,
                  hintText: AppStrings.enterYourNewPassword.tr,
                  obscureText: !profileController.passwordVisible.value,
                  suffixIcon: profileController.passwordVisible.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  onSuffixIconTap: profileController.togglePasswordVisibility,
                  style: AppStyle.roboto16w500C545454,
                  hintStyle: AppStyle.roboto14w500CB3B3B3,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  enabledBorderColor: AppColors.black30opacity4D000000,
                  focusedBorderColor: AppColors.primary,
                  errorBorderColor: Colors.red,
                  focusedErrorBorderColor: Colors.red,
                  enabledBorderWidth: 1.5.w,
                  focusedBorderWidth: 1.8.w,
                  borderRadius: BorderRadius.circular(12.r),
                )),
                Gap(18.h),
                
                Text(
                  AppStrings.confirmNewPassword.tr,
                  style: AppStyle.roboto16w600C2A2A2A,
                ),
                Gap(8.h),
                Obx(() => CustomTextFormField(
                  controller: profileController.confirmPasswordController,
                  validator: profileController.validateConfirmPassword,
                  hintText: AppStrings.confirmYourNewPassword.tr,
                  obscureText: !profileController.passwordVisible.value,
                  suffixIcon: profileController.passwordVisible.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  onSuffixIconTap: profileController.togglePasswordVisibility,
                  style: AppStyle.roboto16w500C545454,
                  hintStyle: AppStyle.roboto14w500CB3B3B3,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  enabledBorderColor: AppColors.black30opacity4D000000,
                  focusedBorderColor: AppColors.primary,
                  errorBorderColor: Colors.red,
                  focusedErrorBorderColor: Colors.red,
                  enabledBorderWidth: 1.5.w,
                  focusedBorderWidth: 1.8.w,
                  borderRadius: BorderRadius.circular(12.r),
                )),
                Gap(26.h),
                
                // Change Password button
                Obx(() => AppButton(
                  text: profileController.isLoading.value 
                      ? AppStrings.changing.tr
                      : AppStrings.changePassword.tr,
                  onPressed: profileController.isLoading.value
                      ? null
                      : () => profileController.changePassword(context),
                  height: 35.h,
                  backgroundColor: profileController.isLoading.value
                      ? const Color(0xFF77E9D6).withOpacity(0.6)
                      : const Color(0xFF77E9D6),
                  borderRadius: 5.r,
                  textStyle: AppStyle.inter12w700CFFFFFF,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
