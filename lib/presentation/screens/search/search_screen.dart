import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:groc_shopy/core/routes/route_path.dart';
import 'package:groc_shopy/helper/extension/base_extension.dart';
import 'package:groc_shopy/utils/app_colors/app_colors.dart';
import 'package:groc_shopy/utils/static_strings/static_strings.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> callers = [
    {
      'initials': 'M',
      'name': AppStrings.mom,
      'message': AppStrings.momWorriedMessage,
      'color': Colors.red[200],
    },
    {
      'initials': 'Bf',
      'name': AppStrings.bestFriend,
      'message': AppStrings.bestFriendMessage,
      'color': Colors.brown[400],
    },
    {
      'initials': 'D',
      'name': AppStrings.dad,
      'message': AppStrings.dadMessage,
      'color': Colors.orange[200],
    },
    {
      'initials': 'L',
      'name': AppStrings.love,
      'message': AppStrings.loveMessage,
      'color': Colors.green[200],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.caller.tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.black, size: 24.r),
                    onPressed: () {
                      context.push(RoutePath.newContactScreen.addBasePath);
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  prefixIcon: Icon(Icons.search, size: 22.r),
                  hintText: AppStrings.search.tr,
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            Gap(8.h),
            Expanded(
              child: ListView.builder(
                itemCount: callers.length,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemBuilder: (context, index) {
                  final caller = callers[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    elevation: 0,
                    child: ListTile(
                      tileColor: AppColors.backgroundColor,
                      leading: CircleAvatar(
                        radius: 30.r,
                        backgroundColor: caller['color'],
                        child: Text(
                          caller['initials'],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                      title: Text(
                        caller['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      subtitle: Text(
                        caller['message'],
                        style: TextStyle(fontSize: 13.sp),
                      ),
                      onTap: () {
                        // TODO: Handle tap
                      },
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
