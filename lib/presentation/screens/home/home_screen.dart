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
import '../../../global/model/contact.dart';
import '../../../service/contact_api_service.dart';
import '../new_contact_screen/controller/contact_controller.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCallTime; // Store the key, e.g., AppStrings.fifteenSec
  Contact? selectedCaller; // Changed to Contact type
  int? customMinutes;
  int? customSeconds;
  Timer? _countdownTimer;
  int _remainingSeconds = 0;
  bool _isCountdownActive = false;
  final HomeController homeController = Get.find<HomeController>();

  // Add these variables for API contacts
  List<Contact> apiContacts = [];
  bool isLoadingContacts = false;

  late final ContactController contactController;

  @override
  void initState() {
    super.initState();
    _loadApiContacts(); // Load contacts from API

    // Load user profile
    homeController.loadUserProfile(context);

    // Get the ContactController
    contactController = Get.find<ContactController>();

    // Listen for contact changes
    ever(contactController.contactsChanged, (_) {
      _loadApiContacts(); // Refresh when contacts change
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSubscriptionModal();
    });
  }

  // Add this method to load contacts from API
  Future<void> _loadApiContacts() async {
    setState(() {
      isLoadingContacts = true;
    });

    try {
      final contacts = await ContactApiService.getContacts(context);
      setState(() {
        apiContacts = contacts;
        isLoadingContacts = false;
      });
    } catch (e) {
      setState(() {
        isLoadingContacts = false;
      });
      print('Error loading contacts: $e');
      // You can show a snackbar or error message here
    }
  }

  final plans = [
    SubscriptionPlan(
      title: 'Monthly Premium',
      price: '\$1.99',
      priceSuffix: '/month',
      features: [
        'More calls',
        'Choose new ringtone',
        'Customize call time',
      ],
    ),
    SubscriptionPlan(
      title: 'Yearly Premium',
      price: '\$9.99',
      priceSuffix: '/year',
      features: [
        'Unlimited calls',
        'Choose new ringtone',
        'Customize call time',
      ],
    ),
  ];
  void _showSubscriptionModal() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SubscriptionModal(
          plans: plans,
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
              // Updated header code with user profile
              Obx(() => InkWell(
                    onTap: () {
                      context.pushNamed(RoutePath.profile);
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundImage: homeController.userProfile.value
                                      ?.fullImageUrl.isNotEmpty ==
                                  true
                              ? NetworkImage(
                                  homeController
                                      .userProfile.value!.fullImageUrl,
                                )
                              : AssetImage(Assets.images.profileImage.path)
                                  as ImageProvider,
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
                              homeController.userProfile.value?.name ?? 'User',
                              style: AppStyle.robotoMono12w500C030303,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              Gap(20.h),

              // ...existing banner code...
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

              // Call time options (keep existing code)
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

              // Caller options - Updated to show API contacts
              Text(
                AppStrings.caller.tr,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Gap(10.h),

              // Show loading or contacts
              Expanded(
                child: isLoadingContacts
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                    : apiContacts.isEmpty
                        ? Center(
                            child: Text(
                              'No contacts available',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemCount: apiContacts.length,
                            separatorBuilder: (context, index) => Gap(10.h),
                            itemBuilder: (context, index) {
                              return callerOptionFromContact(
                                  apiContacts[index]);
                            },
                          ),
              ),

              Gap(20.h),

              // Start call button (update validation)
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
        ));
  }

  // New helper for immediate call
  void _startImmediateCall() {
    context.pushNamed(RoutePath.incomingCallScreen, extra: {
      'callerName': selectedCaller!.fullName,
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
          'callerName': selectedCaller!.fullName,
          'time': _getFormattedTime(),
          'callDuration': selectedCallTime!,
        });
      }
    });
  }

  // New method to create caller option from Contact
  Widget callerOptionFromContact(Contact contact) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCaller = contact; // This works correctly now
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: selectedCaller?.apiId == contact.apiId
              ? AppColors.primary
              : Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Obx(
              () => CircleAvatar(
                radius: 24.r,
                backgroundColor: homeController.selectedIconColor.value,
                backgroundImage:
                    contact.photo != null ? NetworkImage(contact.photo!) : null,
                child: contact.photo == null
                    ? Text(
                        contact.initials,
                        style: AppStyle.roboto32w600CFFFFFF,
                      )
                    : null,
              ),
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.fullName,
                    style: selectedCaller?.apiId == contact.apiId
                        ? AppStyle.roboto16w800CFFFFFF
                        : AppStyle.roboto16w500C000000,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: selectedCaller?.apiId == contact.apiId
                  ? AppColors.whiteFFFFFF
                  : Colors.black,
              size: 16.r,
            ),
          ],
        ),
      ),
    );
  }
}
