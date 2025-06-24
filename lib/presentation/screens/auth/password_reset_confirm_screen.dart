import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:groc_shopy/core/routes/route_path.dart';
import 'package:groc_shopy/helper/extension/base_extension.dart';
import 'package:groc_shopy/utils/app_colors/app_colors.dart';
import 'package:groc_shopy/utils/static_strings/static_strings.dart';
import 'package:groc_shopy/utils/text_style/text_style.dart';

import '../../../core/custom_assets/assets.gen.dart';
import '../../widgets/custom_bottons/custom_button/app_button.dart';

class PasswordResetConfirmScreen extends StatelessWidget {
  const PasswordResetConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Image.asset(
                  Assets.icons.arrowBackGrey.path,
                  width: 24.w,
                  height: 24.w,
                ),
              ),
              Gap(53.h),
              Text(
                AppStrings.passwordReset.tr,
                style: AppStyle.kohSantepheap18w700C1E1E1E,
              ),
              Gap(18.h),
              Text(
                AppStrings.confirmPassword.tr,
                style: AppStyle.roboto14w500C989898,
              ),
              Gap(32.h),
              AppButton(
                text: AppStrings.confirm.tr,
                onPressed: () {
                  context.push(RoutePath.resetPass.addBasePath);
                },
                width: double.infinity,
                height: 48.h,
                backgroundColor: AppColors.primary,
                borderRadius: 8.r,
                textStyle: AppStyle.inter16w700CFFFFFF,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
