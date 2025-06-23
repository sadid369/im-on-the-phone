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
        title: Text('User Management'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextFormField(
              controller: TextEditingController(),
              hintText: "Search users...",
              prefix: Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              borderRadius: BorderRadius.circular(8),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              enabledBorderColor: Colors.grey.shade300,
              focusedBorderColor: AppColors.primary,
              showCounter: false,
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 70.w,
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    margin: EdgeInsets.only(bottom: 10.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.grey[300],
                          child: Icon(Icons.person, color: Colors.black),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                users[index]['name']!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2),
                              Text(
                                users[index]['email']!,
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[700]),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        AppButton(
                          text: 'Subscriber',
                          onPressed: () {},
                          width: 90,
                          height: 32,
                          backgroundColor: AppColors.primary,
                          borderRadius: 10,
                          textStyle:
                              TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        Gap(5.w),
                        Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.grey,
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
