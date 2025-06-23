import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:groc_shopy/core/custom_assets/assets.gen.dart';

import '../../../../utils/text_style/text_style.dart';
import '../../../widgets/custom_bottons/custom_button/app_button.dart';
import '../../../widgets/custom_text_form_field/custom_text_form.dart';

class AdminUpdateProfileScreen extends StatefulWidget {
  @override
  State<AdminUpdateProfileScreen> createState() =>
      _AdminUpdateProfileScreenState();
}

class _AdminUpdateProfileScreenState extends State<AdminUpdateProfileScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Angel Mthembu');
  final TextEditingController _emailController =
      TextEditingController(text: 'admin@example.com');

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Title
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 16.0),
                height: kToolbarHeight,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          color: Colors.black, size: 15),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Text(
                      'Update Profile',
                      style: AppStyle.kohSantepheap18w700C1E1E1E,
                    ),
                    SizedBox()
                  ],
                ),
              ),
              // Divider

              // Back arrow (replace with IconButton if needed)
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(
                    left: 32, top: 0), // Changed top: -23 to top: 0
                width: 12,
                height: 24,
                // Add your back arrow widget here
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  // Profile image
                  Container(
                    margin: const EdgeInsets.only(top: 44),
                    width: 100,
                    height: 100,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFD9D9D9),
                      shape: OvalBorder(),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        Assets.images.profileImage
                            .path, // Replace with your image path
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  // Camera icon overlay (bottom right)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.camera_alt,
                            color: Colors.black, size: 16),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                            ),
                            builder: (context) {
                              return Container(
                                width: 393,
                                height: 182,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: 5), // top spacing
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: 30,
                                        height: 4,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFFCACACA),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10), // spacing
                                    // Add more widgets here if needed
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 20),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: OvalBorder(),
                                                  shadows: [
                                                    BoxShadow(
                                                      color: Color(0x3F000000),
                                                      blurRadius: 4,
                                                      offset: Offset(1, 2),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                                child: IconButton(
                                                  icon: Icon(Icons.camera_alt,
                                                      color: Colors.black,
                                                      size: 24),
                                                  onPressed: () {
                                                    // Handle camera upload
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 8), // spacing
                                              Text(
                                                'Camera',
                                                style: AppStyle
                                                    .roboto14w400C808080,
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 20), // spacing
                                          Column(
                                            children: [
                                              Container(
                                                width: 50,
                                                height: 50,
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: OvalBorder(),
                                                  shadows: [
                                                    BoxShadow(
                                                      color: Color(0x3F000000),
                                                      blurRadius: 4,
                                                      offset: Offset(1, 2),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                                child: IconButton(
                                                  icon: Icon(Icons.attach_file,
                                                      color: Colors.black,
                                                      size: 24),
                                                  onPressed: () {
                                                    // Handle camera upload
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ),
                                              SizedBox(height: 8), // spacing
                                              Text(
                                                'Upload',
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
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  'Tap the camera icon to upload',
                  style: AppStyle.roboto14w400C808080,
                ),
              ),
              Gap(13.w),
              // Full Name field
              Container(
                // padding: const EdgeInsets.symmetric(
                //     vertical: 15, horizontal: 16), // Adjusted padding
                alignment: Alignment.center,
                // margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
                width: double.infinity,
                height: 100.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
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
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: Text(
                            "Full Name",
                            style: AppStyle.roboto14w400C808080,
                          ),
                        ),
                      ],
                    ),
                    CustomTextFormField(
                      prefix: Icon(Icons.person_2_outlined,
                          color: Colors.black.withOpacity(0.5), size: 20),
                      controller: _nameController,
                      style: AppStyle.robotoMono16w500C030303,
                      filled: false,
                      enabledBorderColor: Colors.transparent,
                      focusedBorderColor: Colors.transparent,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0),
                      borderRadius: BorderRadius.circular(0),
                      showCounter: false,
                      onChanged: (value) {
                        // Handle name change
                      },
                    ),
                  ],
                ),
              ),
              Gap(25.w),
              Container(
                // padding: const EdgeInsets.symmetric(
                //     vertical: 15, horizontal: 16), // Adjusted padding
                alignment: Alignment.center,
                // margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
                width: double.infinity,
                height: 100.w,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
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
                          padding: const EdgeInsets.only(left: 16, top: 8),
                          child: Text(
                            "Email Address",
                            style: AppStyle.roboto14w400C808080,
                          ),
                        ),
                      ],
                    ),
                    CustomTextFormField(
                      prefix: Icon(Icons.email_outlined,
                          color: Colors.black.withOpacity(0.5), size: 20),
                      controller: _emailController,
                      style: AppStyle.robotoMono16w500C030303,
                      filled: false,
                      enabledBorderColor: Colors.transparent,
                      focusedBorderColor: Colors.transparent,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 0),
                      borderRadius: BorderRadius.circular(0),
                      showCounter: false,
                      onChanged: (value) {
                        // Handle name change
                      },
                    ),
                  ],
                ),
              ),
              Gap(57.w),
              // Save Changes button
              AppButton(
                text: 'Save Changes',
                onPressed: () {
                  // Handle save changes action
                },
                height: 35,
                backgroundColor: const Color(0xFF77E9D6),
                borderRadius: 5,
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
