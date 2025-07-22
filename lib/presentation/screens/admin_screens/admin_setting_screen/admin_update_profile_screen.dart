import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:groc_shopy/core/custom_assets/assets.gen.dart';
import 'package:groc_shopy/helper/extension/base_extension.dart';
import 'package:groc_shopy/utils/static_strings/static_strings.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/text_style/text_style.dart';
import '../../../widgets/custom_bottons/custom_button/app_button.dart';
import '../../../widgets/custom_text_form_field/custom_text_form.dart';
import '../admin_setting_screen/controller/admin_settings_controller.dart';

class AdminUpdateProfileScreen extends StatefulWidget {
  @override
  State<AdminUpdateProfileScreen> createState() =>
      _AdminUpdateProfileScreenState();
}

class _AdminUpdateProfileScreenState extends State<AdminUpdateProfileScreen> {
  final adminController = Get.find<AdminSettingsController>();
  late TextEditingController _nameController;
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    // Use the current name from the profile if available, else fallback
    _nameController = TextEditingController(
      text: adminController.userProfile.value?.name ?? '',
    );
    // Listen for profile changes and update the controller if needed
    ever(adminController.userProfile, (profile) {
      if (profile != null) {
        _nameController.text = profile.name ?? '';
      }
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source, imageQuality: 80);
    if (picked != null) {
      setState(() {
        _pickedImage = File(picked.path);
      });
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              // Title
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
                      AppStrings.updateProfile.tr, // <-- Added .tr
                      style: AppStyle.kohSantepheap18w700C1E1E1E,
                    ),
                    Gap(15.w),
                  ],
                ),
              ),
              // Back arrow (replace with IconButton if needed)
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 32.w, top: 0.h),
                width: 12.w,
                height: 24.h,
                // Add your back arrow widget here
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  // Profile image
                  Container(
                    margin: EdgeInsets.only(top: 44.h),
                    width: 100.w,
                    height: 100.w,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFD9D9D9),
                      shape: OvalBorder(),
                    ),
                    child: ClipOval(
                      child: _pickedImage != null
                          ? Image.file(
                              _pickedImage!,
                              fit: BoxFit.cover,
                              width: 100.w,
                              height: 100.w,
                            )
                          : (adminController.userProfile.value?.image != null &&
                                  adminController
                                      .userProfile.value!.image!.isNotEmpty)
                              ? Image.network(
                                  adminController
                                      .userProfile.value!.image!.addBaseUrl,
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
                  // Camera icon overlay (bottom right)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.camera_alt,
                            color: Colors.black, size: 16.r),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20.r)),
                            ),
                            builder: (context) {
                              return Container(
                                width: 393.w,
                                height: 182.h,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.camera_alt,
                                              color: Colors.black, size: 24.r),
                                          onPressed: () =>
                                              _pickImage(ImageSource.camera),
                                        ),
                                        Text(AppStrings.camera.tr,
                                            style:
                                                AppStyle.roboto14w400C808080),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.attach_file,
                                              color: Colors.black, size: 24.r),
                                          onPressed: () =>
                                              _pickImage(ImageSource.gallery),
                                        ),
                                        Text(AppStrings.upload.tr,
                                            style:
                                                AppStyle.roboto14w400C808080),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              // Upload text
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Text(
                  AppStrings.tapCameraToUpload.tr, // <-- Added .tr
                  style: AppStyle.roboto14w400C808080,
                ),
              ),
              Gap(13.h),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.w, top: 8.h),
                          child: Text(
                            AppStrings.fullName.tr, // <-- Added .tr
                            style: AppStyle.roboto14w400C808080,
                          ),
                        ),
                      ],
                    ),
                    CustomTextFormField(
                      prefix: Icon(Icons.person_2_outlined,
                          color: Colors.black.withOpacity(0.5), size: 20.r),
                      controller: _nameController,
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
              Gap(25.h),

              Gap(40.h),
              // Save Changes button
              AppButton(
                text: AppStrings.saveChanges.tr,
                onPressed: () {
                  adminController.saveProfile(
                    context,
                    _nameController.text,
                    _pickedImage,
                  );
                },
                height: 35.h,
                backgroundColor: const Color(0xFF77E9D6),
                borderRadius: 5.r,
                textStyle: AppStyle.inter12w700CFFFFFF,
              ),
              // Add more fields as needed...
            ],
          ),
        ),
      ),
    );
  }
}
