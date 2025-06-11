import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:groc_shopy/core/custom_assets/assets.gen.dart';
import 'package:groc_shopy/utils/app_colors/app_colors.dart';
import 'package:groc_shopy/utils/text_style/text_style.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                  Assets.images.profileImage.path), // Placeholder image
            ),
            SizedBox(width: 10),
            Column(
              children: [
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Angel Mthembu',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        Color(0xFFEFC0D4), // Light pink
                        AppColors.primary, // Light teal
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                  child: Text(
                    "I’m on \nthe phone",
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
            callerOption("MOM"),
            callerOption("Love"),
            callerOption("Dad"),

            Spacer(),

            // Start call button
            AppButton(
              text: 'Start Call',
              onPressed: () {
                // Add your logic here
              },
              backgroundColor: AppColors.primary,
              textStyle: AppStyle.inter16w700CFFFFFF,
              enabled: true, // Ensure it's enabled
              width: double.infinity, // Optional, adjust as needed
              height: 48, // Optional, adjust as needed
              borderRadius: 12, // Optional, adjust as needed
            ),
          ],
        ),
      ),
    );
  }

  // Call time button widget
  Widget callTimeButton(String time) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCallTime = time; // Update the selected time
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: 79.w,
        height: 29.h,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selectedCallTime == time
                ? AppColors.primary
                : Colors.white, // Change color when selected
            borderRadius: BorderRadius.circular(8),
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

  // Caller option widget
  Widget callerOption(String name) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCaller = name; // Update the selected caller
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.w),
        decoration: BoxDecoration(
            color: selectedCaller == name ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              spacing: 16.w,
              children: [
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
              color: selectedCaller == name
                  ? AppColors.whiteFFFFFF
                  : Colors.black, // Change color when selected
            ),
          ],
        ),
      ),
    );
  }
}
