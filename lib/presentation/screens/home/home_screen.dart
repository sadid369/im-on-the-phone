import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:groc_shopy/core/custom_assets/assets.gen.dart';
import 'package:groc_shopy/utils/app_colors/app_colors.dart';
import 'package:groc_shopy/utils/text_style/text_style.dart';
import 'dart:async';
import 'package:get/get.dart';

import '../../../core/routes/route_path.dart';
import '../../../helper/local_db/local_db.dart';
import '../../../utils/static_strings/static_strings.dart';
import '../../widgets/custom_bottons/custom_button/app_button.dart';
import '../../widgets/subscription_modal/subscription_modal.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCallTime; // Store the key, e.g., AppStrings.fifteenSec
  String? selectedCaller; // Store the key, e.g., AppStrings.mom
  int? customMinutes;
  int? customSeconds;
  Timer? _countdownTimer;
  int _remainingSeconds = 0;
  bool _isCountdownActive = false;
  final HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSubscriptionModal();
    });
  }

  void _showSubscriptionModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SubscriptionModal(
          onSubscribe: () {
            Navigator.of(context).pop();
            print('User subscribed!');
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
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
              InkWell(
                onTap: () {
                  context.pushNamed(RoutePath.profile);
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage:
                          AssetImage(Assets.images.profileImage.path),
                    ),
                    Gap(10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.welcome.tr,
                          style: AppStyle.robotoMono10w500C030303,
                        ),
                        Text(
                          'Angel Mthembu', // You may want to use a variable here
                          style: AppStyle.robotoMono12w500C030303,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(20.h),
              // Banner
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: 103.h,
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFEFC0D4),
                          AppColors.primary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Text(
                      AppStrings.appName.tr,
                      style: AppStyle.robotoMono32w500CFFFFFF,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: -25.h,
                    child: Image.asset(
                      Assets.images.bannerImage1.path,
                      width: 120.w,
                      height: 120.h,
                    ),
                  ),
                ],
              ),
              Gap(20.h),

              // Call time options
              Text(
                AppStrings.setUpFakeCall.tr,
                style: AppStyle.kohSantepheap18w700C030303,
              ),
              Gap(10.h),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    callTimeButton(AppStrings.fifteenSec),
                    callTimeButton(AppStrings.thirtySec),
                    callTimeButton(AppStrings.oneMin),
                    callTimeButton(AppStrings.custom),
                  ],
                ),
              ),
              Gap(20.h),

              // Caller options
              Text(
                AppStrings.caller.tr,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Gap(10.h),
              Column(
                children: [
                  Gap(10.h),
                  callerOption(AppStrings.mom),
                  Gap(10.h),
                  callerOption(AppStrings.love),
                  Gap(10.h),
                  callerOption(AppStrings.dad),
                ],
              ),

              const Spacer(),

              // Start call button
              AppButton(
                text: AppStrings.startCall.tr,
                onPressed: () {
                  if (selectedCaller == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppStrings.pleaseSelectCallerAndTime.tr),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }
                  if (selectedCallTime != null) {
                    _startDelayedCall();
                  } else {
                    _startImmediateCall();
                  }
                },
                backgroundColor: AppColors.primary,
                textStyle: AppStyle.inter16w700CFFFFFF,
                enabled: true,
                width: double.infinity,
                height: 48.h,
                borderRadius: 12.r,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getFormattedTime() {
    final now = DateTime.now();
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void _showCustomTimePicker() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        int tempMinutes = customMinutes ?? 0;
        int tempSeconds = customSeconds ?? 0;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      AppStrings.setCustomTime.tr,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    Gap(20.h),

                    // Time pickers container
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Color(0xffF8F9FA),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Minutes picker
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  AppStrings.minutes.tr,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                                Gap(8.h),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: AppColors.primary.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: DropdownButton<int>(
                                    value: tempMinutes,
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppColors.primary,
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    items: List.generate(60, (index) => index)
                                        .map((int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(
                                          value.toString().padLeft(2, '0'),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setDialogState(() {
                                        tempMinutes = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Gap(16.w),

                          // Separator
                          Container(
                            width: 1.w,
                            height: 60.h,
                            color: AppColors.primary.withOpacity(0.3),
                          ),

                          Gap(16.w),

                          // Seconds picker
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  AppStrings.seconds.tr,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                                Gap(8.h),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: AppColors.primary.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: DropdownButton<int>(
                                    value: tempSeconds,
                                    isExpanded: true,
                                    underline: SizedBox(),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppColors.primary,
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    items: List.generate(60, (index) => index)
                                        .map((int value) {
                                      return DropdownMenuItem<int>(
                                        value: value,
                                        child: Text(
                                          value.toString().padLeft(2, '0'),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setDialogState(() {
                                        tempSeconds = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Gap(24.h),

                    // Selected time display
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time,
                            color: AppColors.primary,
                            size: 20.r,
                          ),
                          Gap(8.w),
                          Text(
                            '${AppStrings.selected.tr}: ${tempMinutes}m ${tempSeconds}s',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Gap(24.h),

                    // Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                AppStrings.cancel.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Gap(16.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                customMinutes = tempMinutes;
                                customSeconds = tempSeconds;
                                selectedCallTime = AppStrings.custom;
                              });
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                AppStrings.setTime.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  int _getDelayInSeconds() {
    switch (selectedCallTime) {
      case AppStrings.fifteenSec:
        return 15;
      case AppStrings.thirtySec:
        return 30;
      case AppStrings.oneMin:
        return 60;
      case AppStrings.custom:
        return (customMinutes ?? 0) * 60 + (customSeconds ?? 0);
      default:
        return 0;
    }
  }

  // void _startDelayedCall() {
  //   int delaySeconds = _getDelayInSeconds();

  //   if (delaySeconds == 0) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(AppStrings.pleaseSetValidTime.tr),
  //         behavior: SnackBarBehavior.floating,
  //       ),
  //     );
  //     return;
  //   }

  //   // Show success message
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content:
  //           Text('${AppStrings.fakeCallWillStartIn.tr} ${selectedCallTime}'),
  //       behavior: SnackBarBehavior.floating,
  //       duration: Duration(seconds: 2),
  //     ),
  //   );

  //   Timer(Duration(seconds: delaySeconds), () {
  //     if (mounted) {
  //       context.pushNamed(RoutePath.incomingCallScreen, extra: {
  //         'callerName': selectedCaller!,
  //         'time': _getFormattedTime(),
  //         'callDuration': selectedCallTime!,
  //       });
  //     }
  //   });
  // }

  void _cancelCountdown() {
    _countdownTimer?.cancel();
    setState(() {
      _isCountdownActive = false;
      _remainingSeconds = 0;
    });
  }

  String _getFormattedRemainingTime() {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  Widget callTimeButton(String timeKey) {
    String displayText = timeKey.tr;

    if (timeKey == AppStrings.custom && selectedCallTime == AppStrings.custom) {
      displayText = "${customMinutes ?? 0}m ${customSeconds ?? 0}s";
    }

    return GestureDetector(
      onTap: () {
        if (timeKey == AppStrings.custom) {
          _showCustomTimePicker();
        } else {
          setState(() {
            selectedCallTime = timeKey;
          });
          // Do NOT start the call here!
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: 79.w,
        height: 35.h,
        decoration: BoxDecoration(
          color: selectedCallTime == timeKey
              ? AppColors.primary
              : const Color(0xffF2F2F2),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          displayText,
          style: selectedCallTime == timeKey
              ? AppStyle.roboto16w600CFFFFFF
              : AppStyle.roboto16w500C030303,
        ),
      ),
    );
  }

  Widget callerOption(String callerKey) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCaller = callerKey;
        });
        // Do NOT start the call here!
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: selectedCaller == callerKey ? AppColors.primary : Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Gap(16.w),
                Obx(() => Container(
                      alignment: Alignment.center,
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: homeController.selectedIconColor.value,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        callerKey.tr[0],
                        style: AppStyle.roboto32w600CFFFFFF,
                      ),
                    )),
                Gap(16.w),
                Text(
                  callerKey.tr,
                  style: selectedCaller == callerKey
                      ? AppStyle.roboto16w800CFFFFFF
                      : AppStyle.roboto16w500C000000,
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: selectedCaller == callerKey
                  ? AppColors.whiteFFFFFF
                  : Colors.black,
              size: 16.r,
            ),
          ],
        ),
      ),
    );
  }

  // New helper for immediate call
  void _startImmediateCall() {
    context.pushNamed(RoutePath.incomingCallScreen, extra: {
      'callerName': selectedCaller!,
      'time': _getFormattedTime(),
      'callDuration': '0',
    });
  }

  // Update _startDelayedCall to remove the double-check
  void _startDelayedCall() {
    int delaySeconds = _getDelayInSeconds();

    if (delaySeconds == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppStrings.pleaseSetValidTime.tr),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('${AppStrings.fakeCallWillStartIn.tr} ${selectedCallTime}'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );

    Timer(Duration(seconds: delaySeconds), () {
      if (mounted) {
        context.pushNamed(RoutePath.incomingCallScreen, extra: {
          'callerName': selectedCaller!,
          'time': _getFormattedTime(),
          'callDuration': selectedCallTime!,
        });
      }
    });
  }
}

// class HomeController extends GetxController {
//   static const String iconColorKey = 'selected_icon_color';
//   Rx<Color> selectedIconColor = const Color(0xffC9867B).obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadIconColor();
//   }

//   void setIconColor(Color color) async {
//     selectedIconColor.value = color;
//     // Save as hex string
//     await SharedPrefsHelper.setString(
//         iconColorKey, color.value.toRadixString(16));
//   }

//   void loadIconColor() async {
//     String colorString = await SharedPrefsHelper.getString(iconColorKey);
//     if (colorString.isNotEmpty) {
//       try {
//         selectedIconColor.value = Color(int.parse(colorString, radix: 16));
//       } catch (_) {
//         selectedIconColor.value = const Color(0xffC9867B);
//       }
//     }
//   }
// }
