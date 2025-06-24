import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:groc_shopy/utils/app_colors/app_colors.dart';

import '../../../widgets/custom_text_form_field/custom_text_form.dart';

class AdminUserScreen extends StatelessWidget {
  final List<Map<String, String>> users = [
    {'name': 'Alice Smith', 'email': 'alice.s@example.com'},
    {'name': 'George Jetson', 'email': 'george.j@example.com'},
    {'name': 'Ferdo Khurrum', 'email': 'khurrom@example.com'},
    {'name': 'Fiona Glenanne', 'email': 'fiona.g@example.com'},
    {'name': 'Bob Johnson', 'email': 'bob.j@example.com'},
    {'name': 'Holly Golightly', 'email': 'holly.g@example.com'},
    {'name': 'Charlie Brown', 'email': 'charlie.b@example.com'},
    {'name': 'Diana Prince', 'email': 'diana.p@example.com'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management', style: TextStyle(fontSize: 18.sp)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            CustomTextFormField(
              controller: TextEditingController(),
              hintText: "Search users...",
              prefix: Icon(Icons.search, color: Colors.grey, size: 20.r),
              filled: true,
              fillColor: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.h, horizontal: 12.w),
              enabledBorderColor: Colors.grey.shade300,
              focusedBorderColor: AppColors.primary,
              showCounter: false,
            ),
            Gap(16.h),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 70.w,
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    margin: EdgeInsets.only(bottom: 10.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.w,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 24.r,
                          backgroundColor: Colors.grey[300],
                          child: Icon(Icons.person,
                              color: Colors.black, size: 24.r),
                        ),
                        Gap(12.w),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                users[index]['name']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Gap(2.h),
                              Text(
                                users[index]['email']!,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.grey[700],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        AppButton(
                          text: 'Subscriber',
                          onPressed: () {},
                          width: 90.w,
                          height: 32.h,
                          backgroundColor: AppColors.primary,
                          borderRadius: 10.r,
                          textStyle:
                              TextStyle(fontSize: 10.sp, color: Colors.white),
                        ),
                        Gap(5.w),
                        Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.grey,
                          size: 22.r,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color backgroundColor;
  final double borderRadius;
  final TextStyle textStyle;

  const AppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.borderRadius,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
