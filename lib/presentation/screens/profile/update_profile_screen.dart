import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:groc_shopy/core/custom_assets/assets.gen.dart';
import 'package:groc_shopy/utils/static_strings/static_strings.dart';

import '../../../utils/text_style/text_style.dart';
import '../../widgets/custom_bottons/custom_button/app_button.dart';
import '../../widgets/custom_text_form_field/custom_text_form.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Angel Mthembu');
  final FocusNode _nameFocusNode = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
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
                // Add your back arrow widget here if needed
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
                      child: Image.asset(
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
                                child: Column(
                                  children: [
                                    Gap(5.h), // top spacing
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 30.w,
                                        height: 4.h,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFCACACA),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.r),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Gap(10.h), // spacing
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 20.h, horizontal: 20.w),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                width: 50.w,
                                                height: 50.w,
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: OvalBorder(),
                                                  shadows: [
                                                    BoxShadow(
                                                      color: Color(0x3F000000),
                                                      blurRadius: 4.r,
                                                      offset: Offset(1, 2),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                                child: IconButton(
                                                  icon: Icon(Icons.camera_alt,
                                                      color: Colors.black,
                                                      size: 24.r),
                                                  onPressed: () {
                                                    // Handle camera upload
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                              Gap(8.h),
                                              Text(
                                                AppStrings
                                                    .camera.tr, // <-- Added .tr
                                                style: AppStyle
                                                    .roboto14w400C808080,
                                              ),
                                            ],
                                          ),
                                          Gap(20.w),
                                          Column(
                                            children: [
                                              Container(
                                                width: 50.w,
                                                height: 50.w,
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: OvalBorder(),
                                                  shadows: [
                                                    BoxShadow(
                                                      color: Color(0x3F000000),
                                                      blurRadius: 4.r,
                                                      offset: Offset(1, 2),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                                child: IconButton(
                                                  icon: Icon(Icons.attach_file,
                                                      color: Colors.black,
                                                      size: 24.r),
                                                  onPressed: () {
                                                    // Handle upload
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                              Gap(8.h),
                                              Text(
                                                AppStrings
                                                    .upload.tr, // <-- Added .tr
                                                style: AppStyle
                                                    .roboto14w400C808080,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
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
                        Padding(
                          padding: EdgeInsets.only(right: 16.w, top: 8.h),
                          child: InkWell(
                            onTap: () {
                              _nameFocusNode.requestFocus();
                            },
                            child: Icon(
                              Icons.edit_note,
                              color: Colors.black.withOpacity(0.5),
                              size: 30.r,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomTextFormField(
                      prefix: Icon(Icons.person_2_outlined,
                          color: Colors.black.withOpacity(0.5), size: 20.r),
                      controller: _nameController,
                      focusNode: _nameFocusNode,
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
              AppButton(
                text: AppStrings.saveChanges.tr, // <-- Added .tr
                onPressed: () {
                  // Handle save changes action
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
