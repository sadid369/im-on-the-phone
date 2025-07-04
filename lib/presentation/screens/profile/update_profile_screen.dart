import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:groc_shopy/core/custom_assets/assets.gen.dart';
import 'package:groc_shopy/utils/static_strings/static_strings.dart';
import 'package:photo_view/photo_view.dart';
import '../../../utils/text_style/text_style.dart';
import '../../widgets/custom_bottons/custom_button/app_button.dart';
import '../../widgets/custom_text_form_field/custom_text_form.dart';
import 'controller/profile_controller.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late final ProfileController profileController;

  @override
  void initState() {
    super.initState();
    profileController = Get.isRegistered<ProfileController>() 
        ? Get.find<ProfileController>()
        : Get.put(ProfileController());
  }

  // Method to show photo viewer
  void _showPhotoViewer(BuildContext context) {
    ImageProvider imageProvider;
    
    if (profileController.profileImage.value != null) {
      imageProvider = FileImage(profileController.profileImage.value!);
    } else {
      imageProvider = AssetImage(Assets.images.profileImage.path);
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 24.r),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Profile Photo',
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.white, size: 24.r),
                onPressed: () {
                  Navigator.pop(context);
                  profileController.showImagePickerBottomSheet(context);
                },
              ),
            ],
          ),
          body: PhotoView(
            imageProvider: imageProvider,
            backgroundDecoration: BoxDecoration(color: Colors.black),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3.0,
            initialScale: PhotoViewComputedScale.contained,
            heroAttributes: PhotoViewHeroAttributes(tag: "profile_photo_edit"),
            loadingBuilder: (context, event) => Center(
              child: CircularProgressIndicator(
                value: event == null 
                    ? 0 
                    : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
                color: Color(0xFF77E9D6),
              ),
            ),
            errorBuilder: (context, error, stackTrace) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.white, size: 50.r),
                  SizedBox(height: 16.h),
                  Text(
                    'Failed to load image',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: profileController.updateProfileFormKey,
            child: Column(
              children: [
                // Header
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
                        AppStrings.updateProfile.tr,
                        style: AppStyle.kohSantepheap18w700C1E1E1E,
                      ),
                      Gap(15.w),
                    ],
                  ),
                ),
                Gap(30.h),
                
                // Profile Image Section
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Obx(() => Container(
                      margin: EdgeInsets.only(top: 44.h),
                      width: 100.w,
                      height: 100.w,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFD9D9D9),
                        shape: OvalBorder(),
                      ),
                      child: GestureDetector(
                        onTap: () => _showPhotoViewer(context),
                        child: Hero(
                          tag: "profile_photo_edit",
                          child: ClipOval(
                            child: profileController.profileImage.value != null
                                ? Image.file(
                                    profileController.profileImage.value!,
                                    fit: BoxFit.cover,
                                    width: 100.w,
                                    height: 100.w,
                                  )
                                : Image.asset(
                                    Assets.images.profileImage.path,
                                    fit: BoxFit.cover,
                                    width: 100.w,
                                    height: 100.w,
                                  ),
                          ),
                        ),
                      ),
                    )),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 28.w,
                        height: 28.w,
                        decoration: ShapeDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.camera_alt,
                              color: Colors.black, size: 16.r),
                          onPressed: () {
                            profileController.showImagePickerBottomSheet(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  child: Text(
                    AppStrings.tapCameraToUpload.tr,
                    style: AppStyle.roboto14w400C808080,
                  ),
                ),
                Gap(30.h),
                
                // Full Name field
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 100.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1.w,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16.w, top: 8.h),
                            child: Text(
                              AppStrings.fullName.tr,
                              style: AppStyle.roboto14w400C808080,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 16.w, top: 8.h),
                            child: Icon(
                              Icons.edit_note,
                              color: Colors.black.withOpacity(0.5),
                              size: 30.r,
                            ),
                          ),
                        ],
                      ),
                      CustomTextFormField(
                        prefix: Icon(Icons.person_2_outlined,
                            color: Colors.black.withOpacity(0.5), size: 20.r),
                        controller: profileController.nameController,
                        validator: profileController.validateName,
                        style: AppStyle.robotoMono16w500C030303,
                        filled: false,
                        enabledBorderColor: Colors.transparent,
                        focusedBorderColor: Colors.transparent,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
                        borderRadius: BorderRadius.circular(0),
                        showCounter: false,
                        onChanged: (value) {
                          // Handle name change
                        },
                      ),
                    ],
                  ),
                ),
                Gap(57.h),
                
                // Save Changes button
                Obx(() => AppButton(
                  text: profileController.isLoading.value 
                      ? AppStrings.updating.tr
                      : AppStrings.saveChanges.tr,
                  onPressed: profileController.isLoading.value
                      ? null
                      : () => profileController.updateProfile(context),
                  height: 35.h,
                  backgroundColor: profileController.isLoading.value
                      ? const Color(0xFF77E9D6).withOpacity(0.6)
                      : const Color(0xFF77E9D6),
                  borderRadius: 5.r,
                  textStyle: AppStyle.inter12w700CFFFFFF,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
