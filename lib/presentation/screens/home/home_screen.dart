// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:go_router/go_router.dart';
// import 'package:groc_shopy/core/custom_assets/assets.gen.dart';
// import 'package:groc_shopy/utils/app_colors/app_colors.dart';
// import 'package:groc_shopy/utils/text_style/text_style.dart';

// import '../../../core/routes/route_path.dart';
// import '../../widgets/custom_bottons/custom_button/app_button.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String? selectedCallTime;
//   String? selectedCaller;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 20,
//                     backgroundImage: AssetImage(
//                         Assets.images.profileImage.path), // Placeholder image
//                   ),
//                   SizedBox(width: 10),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Welcome back!',
//                         style: AppStyle.robotoMono10w500C030303,
//                       ),
//                       Text(
//                         'Angel Mthembu',
//                         style: AppStyle.robotoMono12w500C030303,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               Gap(20.h),
//               // Banner
//               Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     height: 103.h,
//                     padding:
//                         EdgeInsets.symmetric(vertical: 15.h, horizontal: 16.w),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           Color(0xFFEFC0D4), // Light pink
//                           AppColors.primary, // Light teal
//                         ],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                       ),
//                       borderRadius:
//                           BorderRadius.circular(15), // Rounded corners
//                     ),
//                     child: Text(
//                       "I’m on \nthe phone",
//                       style: AppStyle.robotoMono32w500CFFFFFF,
//                     ),
//                   ),
//                   Positioned(
//                     right: 0,
//                     top: -25,
//                     child: Image.asset(
//                       Assets.images.bannerImage1.path,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),

//               // Call time options
//               Text(
//                 'Set up fake call',
//                 style: AppStyle.kohSantepheap18w700C030303,
//               ),
//               SizedBox(height: 10),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     callTimeButton("15 sec"),
//                     callTimeButton("30 sec"),
//                     callTimeButton("1 min"),
//                     callTimeButton("Custom"),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),

//               // Caller options
//               Text(
//                 'Caller',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(height: 10),
//               Column(
//                 spacing: 10.h,
//                 children: [
//                   callerOption("MOM"),
//                   callerOption("Love"),
//                   callerOption("Dad"),
//                 ],
//               ),

//               Spacer(),

//               // Start call button
//               AppButton(
//                 text: 'Start Call',
//                 onPressed: () {
//                   context.pushNamed(RoutePath.incomingCallScreen, extra: {
//                     'callerName': 'John Doe',
//                     'time': '10:30',
//                   });
//                 },
//                 backgroundColor: AppColors.primary,
//                 textStyle: AppStyle.inter16w700CFFFFFF,
//                 enabled: true, // Ensure it's enabled
//                 width: double.infinity, // Optional, adjust as needed
//                 height: 48, // Optional, adjust as needed
//                 borderRadius: 12, // Optional, adjust as needed
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Call time button widget
//   Widget callTimeButton(String time) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedCallTime = time; // Update the selected time
//         });
//       },
//       child: Container(
//         alignment: Alignment.center,
//         width: 79.w,
//         height: 35.w,
//         child: Container(
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: selectedCallTime == time
//                 ? AppColors.primary
//                 : Color(0xffF2F2F2), // Change color when selected
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           child: Text(
//             time,
//             style: selectedCallTime == time
//                 ? AppStyle.roboto16w600CFFFFFF
//                 : AppStyle.roboto16w500C030303,
//           ),
//         ),
//       ),
//     );
//   }

//   // Caller option widget
//   Widget callerOption(String name) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedCaller = name; // Update the selected caller
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.w),
//         decoration: BoxDecoration(
//             color: selectedCaller == name ? AppColors.primary : Colors.white,
//             border: Border.all(color: Colors.black.withOpacity(0.1)),
//             borderRadius: BorderRadius.circular(10.r)),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               spacing: 16.w,
//               children: [
//                 Container(
//                   alignment: Alignment.center,
//                   width: 48.w,
//                   height: 48.h,
//                   decoration: BoxDecoration(
//                     color: Color(0xffC9867B),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Text(
//                     name[0],
//                     style: AppStyle.roboto32w600CFFFFFF,
//                   ),
//                 ),
//                 Text(
//                   name,
//                   style: selectedCaller == name
//                       ? AppStyle.roboto16w800CFFFFFF
//                       : AppStyle.roboto16w500C000000,
//                 ),
//               ],
//             ),
//             Icon(
//               Icons.arrow_forward_ios,
//               color: selectedCaller == name
//                   ? AppColors.whiteFFFFFF
//                   : Colors.black, // Change color when selected
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:groc_shopy/core/custom_assets/assets.gen.dart';
import 'package:groc_shopy/utils/app_colors/app_colors.dart';
import 'package:groc_shopy/utils/text_style/text_style.dart';

import '../../../core/routes/route_path.dart';
import '../../widgets/custom_bottons/custom_button/app_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCallTime;
  String? selectedCaller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        AssetImage(Assets.images.profileImage.path),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome back!',
                        style: AppStyle.robotoMono10w500C030303,
                      ),
                      Text(
                        'Angel Mthembu',
                        style: AppStyle.robotoMono12w500C030303,
                      ),
                    ],
                  ),
                ],
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
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "I'm on \nthe phone",
                      style: AppStyle.robotoMono32w500CFFFFFF,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: -25,
                    child: Image.asset(
                      Assets.images.bannerImage1.path,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Call time options
              Text(
                'Set up fake call',
                style: AppStyle.kohSantepheap18w700C030303,
              ),
              SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    callTimeButton("15 sec"),
                    callTimeButton("30 sec"),
                    callTimeButton("1 min"),
                    callTimeButton("Custom"),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Caller options
              Text(
                'Caller',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  SizedBox(height: 10.h),
                  callerOption("MOM"),
                  SizedBox(height: 10.h),
                  callerOption("Love"),
                  SizedBox(height: 10.h),
                  callerOption("Dad"),
                ],
              ),

              Spacer(),

              // Start call button
              AppButton(
                text: 'Start Call',
                onPressed: () {
                  if (selectedCaller == null || selectedCallTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Please select both caller and call time'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }

                  context.pushNamed(RoutePath.incomingCallScreen, extra: {
                    'callerName': selectedCaller!,
                    'time': _getFormattedTime(),
                    'callDuration': selectedCallTime!,
                  });
                },
                backgroundColor: AppColors.primary,
                textStyle: AppStyle.inter16w700CFFFFFF,
                enabled: true,
                width: double.infinity,
                height: 48,
                borderRadius: 12,
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

  Widget callTimeButton(String time) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCallTime = time;
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: 79.w,
        height: 35.w,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selectedCallTime == time
                ? AppColors.primary
                : Color(0xffF2F2F2),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            time,
            style: selectedCallTime == time
                ? AppStyle.roboto16w600CFFFFFF
                : AppStyle.roboto16w500C030303,
          ),
        ),
      ),
    );
  }

  Widget callerOption(String name) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCaller = name;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.w),
        decoration: BoxDecoration(
          color: selectedCaller == name ? AppColors.primary : Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: 16.w),
                Container(
                  alignment: Alignment.center,
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: Color(0xffC9867B),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    name[0],
                    style: AppStyle.roboto32w600CFFFFFF,
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  name,
                  style: selectedCaller == name
                      ? AppStyle.roboto16w800CFFFFFF
                      : AppStyle.roboto16w500C000000,
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              color:
                  selectedCaller == name ? AppColors.whiteFFFFFF : Colors.black,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
