import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart'; // for .tr
import 'package:groc_shopy/utils/app_colors/app_colors.dart';
import 'package:groc_shopy/utils/static_strings/static_strings.dart';
import 'package:groc_shopy/utils/text_style/text_style.dart';
import '../custom_bottons/custom_button/app_button.dart';

class SubscriptionModal extends StatelessWidget {
  final VoidCallback? onSubscribe;
  const SubscriptionModal({super.key, this.onSubscribe});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.subscriptionModalBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    AppStrings.skip.tr, // <-- Added .tr
                    style: AppStyle.inter16w500C6A4DFF,
                  ),
                ),
              ),
              Gap(8.h),
              Text(
                AppStrings.getUnlimitedAccess.tr, // <-- Added .tr
                style: AppStyle.kohSantepheap20w700C090A0A,
                textAlign: TextAlign.center,
              ),
              Gap(24.h),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    Gap(17.w),
                    Text(
                      AppStrings.popular.tr, // <-- Added .tr
                      style: AppStyle.inter12w400C090A0A,
                    ),
                    Gap(4.h),
                    Text(
                      AppStrings.forCustom.tr, // <-- Added .tr
                      style: AppStyle.roboto16w700C090A0A,
                    ),
                    Gap(8.h),
                    Text(
                      AppStrings.pricePerYear.tr, // <-- Added .tr
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF090A0A),
                        fontSize: 40,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 1.40,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      AppStrings.forOneYear.tr, // <-- Added .tr
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF090A0A),
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1,
                      ),
                    ),
                    Gap(8.h),
                    SizedBox(
                      width: 224,
                      child: Text(
                        AppStrings.fullLibrary.tr, // <-- Added .tr
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF090A0A),
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.43,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 275,
                      child: Text(
                        AppStrings.customCaller.tr, // <-- Added .tr
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF090A0A),
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 1.43,
                        ),
                      ),
                    ),
                    Gap(20.h),
                    AppButton(
                      text: AppStrings.subscribe.tr, // <-- Added .tr
                      onPressed: onSubscribe,
                      width: double.infinity,
                      height: 48.h,
                      backgroundColor: AppColors.primary,
                      borderRadius: 24.r,
                      textStyle: AppStyle.inter16w500White,
                    ),
                    Gap(20.h),
                  ],
                ),
              ),
              Gap(16.h),
              SizedBox(
                width: 262,
                child: Text(
                  AppStrings.subscriptionNote.tr, // <-- Added .tr
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF090A0A),
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
              ),
              Gap(16.h),
            ],
          ),
        ),
      ),
    );
  }
}
