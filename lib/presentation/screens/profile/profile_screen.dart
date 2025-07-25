import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:groc_shopy/core/routes/route_path.dart';
import 'package:groc_shopy/core/routes/routes.dart';
import 'package:groc_shopy/helper/extension/base_extension.dart';
import 'package:groc_shopy/presentation/screens/home/controller/home_controller.dart'
    show HomeController;
import 'package:groc_shopy/utils/static_strings/static_strings.dart';
import 'package:groc_shopy/utils/text_style/text_style.dart';
import 'package:photo_view/photo_view.dart';

import '../../../core/custom_assets/assets.gen.dart';

class ProfileScreen extends StatelessWidget {
  // Method to show photo viewer
  void _showPhotoViewer(BuildContext context, String imagePath) {
    // Determine if the image is a network URL or local asset
    final bool isNetworkImage =
        imagePath.startsWith('http') || imagePath.startsWith('https');

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Profile Photo',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: PhotoView(
            imageProvider: isNetworkImage
                ? NetworkImage(imagePath) as ImageProvider
                : AssetImage(imagePath) as ImageProvider,
            backgroundDecoration: BoxDecoration(color: Colors.black),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2.0,
            initialScale: PhotoViewComputedScale.contained,
            heroAttributes: PhotoViewHeroAttributes(tag: "profile_photo"),
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.white, size: 50),
                    SizedBox(height: 16),
                    Text(
                      'Failed to load image',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: kToolbarHeight.h,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1.w),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          color: Colors.black, size: 15.r),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Text(
                      AppStrings.profile.tr,
                      style: AppStyle.kohSantepheap18w700C1E1E1E,
                    ),
                    Gap(15.w),
                  ],
                ),
              ),
              Gap(20.h),
              Container(
                height: 100.w,
                width: double.infinity,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1.w,
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => _showPhotoViewer(
                          context,
                          homeController.userProfile.value?.image!.addBaseUrl ??
                              Assets.images.profileImage.path),
                      child: Hero(
                        tag: "profile_photo",
                        child: Obx(() {
                          final profile = homeController.userProfile.value;
                          final profileImageUrl = profile?.image!.addBaseUrl;

                          return CircleAvatar(
                            radius: 30.r,
                            backgroundImage: profileImageUrl != null &&
                                    profileImageUrl.isNotEmpty
                                ? NetworkImage(profileImageUrl)
                                : AssetImage(Assets.images.profileImage.path)
                                    as ImageProvider,
                            onBackgroundImageError: profileImageUrl != null
                                ? (exception, stackTrace) {
                                    // Fallback to default image on error
                                  }
                                : null,
                          );
                        }),
                      ),
                    ),
                    Gap(19.w),
                    Obx(() {
                      final profile = homeController.userProfile.value;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile?.name ?? 'User',
                            style: AppStyle.robotoMono18w500C030303,
                          ),
                          Text(
                            profile?.email ?? '',
                            style: AppStyle.roboto14w400C808080,
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              Gap(32.h),
              Container(
                width: double.infinity,
                height: 47.h,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 21.w),
                decoration: BoxDecoration(
                  color: const Color(0x33D9D9D9),
                  border: Border(
                    top: BorderSide(
                        width: 1.w, color: Colors.black.withAlpha(51)),
                    bottom: BorderSide(
                        width: 1.w, color: Colors.black.withAlpha(51)),
                  ),
                ),
                child: Text(
                  AppStrings.profileAndAccount.tr,
                  style: AppStyle.roboto14w600C999999,
                ),
              ),
              Gap(20.h),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1.w),
                  ),
                ),
                child: ListTile(
                  leading:
                      Icon(Icons.person_outlined, color: Colors.grey.shade600),
                  title: Text(
                    AppStrings.updateProfile.tr,
                    style: AppStyle.roboto16w400C000000,
                  ),
                  onTap: () {
                    context.push(RoutePath.updateProfileScreen.addBasePath);
                  },
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 16.r, color: Colors.grey.shade600),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1.w),
                  ),
                ),
                child: ListTile(
                  leading:
                      Icon(Icons.lock_outline, color: Colors.grey.shade600),
                  title: Text(
                    AppStrings.changePassword.tr,
                    style: AppStyle.roboto16w400C000000,
                  ),
                  onTap: () {
                    context.push(RoutePath.changePasswordScreen.addBasePath);
                  },
                  trailing: Icon(Icons.arrow_forward_ios,
                      size: 16.r, color: Colors.grey.shade600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
