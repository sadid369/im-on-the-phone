// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:groc_shopy/utils/app_colors/app_colors.dart';
// import 'package:groc_shopy/utils/static_strings/static_strings.dart';
// import 'package:groc_shopy/utils/text_style/text_style.dart';
// import '../custom_bottons/custom_button/app_button.dart';

// class SubscriptionModal extends StatelessWidget {
//   const SubscriptionModal({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: AppColors.subscriptionModalBackground,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(24.r),
//       ),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Align(
//                 alignment: Alignment.topRight,
//                 child: TextButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: Text(
//                     AppStrings.skip,
//                     style: AppStyle.inter16w500C6A4DFF,
//                   ),
//                 ),
//               ),
//               Gap(8.h),
//               Text(
//                 AppStrings.getUnlimitedAccess,
//                 style: AppStyle.kohSantepheap20w700C090A0A,
//                 textAlign: TextAlign.center,
//               ),
//               Gap(12.h),
//               Text(
//                 AppStrings.takeTheFirstStep,
//                 style: AppStyle.roboto12w400C090A0A,
//                 textAlign: TextAlign.center,
//               ),
//               Gap(24.h),
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(20.r),
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       AppStrings.popular,
//                       style: AppStyle.inter12w400C090A0A,
//                     ),
//                     Gap(4.h),
//                     Text(
//                       AppStrings.forMoreScan,
//                       style: AppStyle.roboto16w700C090A0A,
//                     ),
//                     Gap(8.h),
//                     Text(
//                       '\$60.99',
//                       style: AppStyle.roboto40w700C090A0A,
//                     ),
//                     Gap(4.h),
//                     Text(
//                       AppStrings.forOneYear,
//                       style: AppStyle.inter12w400C090A0A,
//                     ),
//                     Gap(16.h),
//                     Text(
//                       AppStrings.unlimitedAccessTosSan,
//                       style: AppStyle.inter14w400C090A0A,
//                       textAlign: TextAlign.center,
//                     ),
//                     Gap(20.h),
//                     AppButton(
//                       text: AppStrings.subscribe,
//                       onPressed: () {
//                         // Handle subscribe logic
//                       },
//                       width: double.infinity,
//                       height: 48.h,
//                       backgroundColor: AppColors.yellowFFD673,
//                       borderRadius: 24.r,
//                       textStyle: AppStyle.inter16w500White,
//                     )
//                   ],
//                 ),
//               ),
//               Gap(16.h),
//               Text(
//                 AppStrings.youWillBe,
//                 style: AppStyle.inter12w400C090A0A,
//                 textAlign: TextAlign.center,
//               ),
//               Gap(16.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart'; // for .tr
import 'package:groc_shopy/utils/app_colors/app_colors.dart';
import 'package:groc_shopy/utils/static_strings/static_strings.dart';
import 'package:groc_shopy/utils/text_style/text_style.dart';
import '../custom_bottons/custom_button/app_button.dart';

class SubscriptionModal extends StatelessWidget {
  const SubscriptionModal({super.key});

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
                    AppStrings.skip.tr,
                    style: AppStyle.inter16w500C6A4DFF,
                  ),
                ),
              ),
              Gap(8.h),
              Text(
                AppStrings.getUnlimitedAccess.tr,
                style: AppStyle.kohSantepheap20w700C090A0A,
                textAlign: TextAlign.center,
              ),
              Gap(12.h),
              Text(
                AppStrings.takeTheFirstStep.tr,
                style: AppStyle.roboto12w400C090A0A,
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
                    Text(
                      AppStrings.popular.tr,
                      style: AppStyle.inter12w400C090A0A,
                    ),
                    Gap(4.h),
                    Text(
                      AppStrings.forMoreScan.tr,
                      style: AppStyle.roboto16w700C090A0A,
                    ),
                    Gap(8.h),
                    Text(
                      '\$60.99',
                      style: AppStyle.roboto40w700C090A0A,
                    ),
                    Gap(4.h),
                    Text(
                      AppStrings.forOneYear.tr,
                      style: AppStyle.inter12w400C090A0A,
                    ),
                    Gap(16.h),
                    Text(
                      AppStrings.unlimitedAccessTosSan.tr,
                      style: AppStyle.inter14w400C090A0A,
                      textAlign: TextAlign.center,
                    ),
                    Gap(20.h),
                    AppButton(
                      text: AppStrings.subscribe.tr,
                      onPressed: () {
                        // Handle subscribe logic
                      },
                      width: double.infinity,
                      height: 48.h,
                      backgroundColor: AppColors.yellowFFD673,
                      borderRadius: 24.r,
                      textStyle: AppStyle.inter16w500White,
                    )
                  ],
                ),
              ),
              Gap(16.h),
              Text(
                AppStrings.youWillBe.tr,
                style: AppStyle.inter12w400C090A0A,
                textAlign: TextAlign.center,
              ),
              Gap(16.h),
            ],
          ),
        ),
      ),
    );
  }
}
