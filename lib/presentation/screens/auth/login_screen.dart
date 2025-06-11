import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart'; // << Added this import
import 'package:groc_shopy/helper/extension/base_extension.dart';
import 'package:groc_shopy/utils/app_colors/app_colors.dart';
import 'package:groc_shopy/utils/static_strings/static_strings.dart';
import '../../../core/custom_assets/assets.gen.dart';
import '../../../core/routes/route_path.dart';
import '../../../utils/text_style/text_style.dart';
import '../../widgets/custom_bottons/custom_button/app_button.dart';
import '../../widgets/custom_text_form_field/custom_text_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  bool passwordVisible = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gap(15.h),
                  Text(
                    AppStrings.signIn.tr,
                    style: AppStyle.kohSantepheap30w700C000000,
                  ),
                  Gap(88.h),
                  CustomTextFormField(
                    controller: emailController,
                    labelText: AppStrings.email.tr,
                    hintText: AppStrings.enterYourEmailHint.tr,
                    suffixIcon: Icons.email_outlined,
                    obscureText: false,
                    hintStyle: AppStyle.roboto14w500CB3B3B3,
                    style: AppStyle.roboto16w500C545454,
                    labelStyle: AppStyle.roboto14w500C000000,
                    enabledBorderColor: AppColors.black30opacity4D000000,
                    focusedBorderColor: AppColors.primary,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 14.h),
                  ),
                  Gap(35.h),
                  CustomTextFormField(
                    controller: passwordController,
                    labelText: AppStrings.password.tr,
                    hintText: AppStrings.password.tr,
                    suffixIcon: passwordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    obscureText: !passwordVisible,
                    onSuffixIconTap: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                    hintStyle: AppStyle.roboto14w500CB3B3B3,
                    style: AppStyle.roboto16w500C545454,
                    labelStyle: AppStyle.roboto14w500C000000,
                    enabledBorderColor: AppColors.black30opacity4D000000,
                    focusedBorderColor: AppColors.primary,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 14.h),
                  ),
                  Gap(6.73.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        context.push(RoutePath.forgotPass.addBasePath);
                      },
                      child: Text(
                        AppStrings.forgotPassword.tr,
                        style: AppStyle.roboto14w500C7CE3D7,
                      ),
                    ),
                  ),
                  // Only show the Remember Me and Sign In button
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (val) {
                          setState(() {
                            rememberMe = val ?? false;
                          });
                        },
                        activeColor: AppColors.primary,
                      ),
                      Text(
                        AppStrings.rememberMe.tr,
                        style: AppStyle.roboto14w400C000000,
                      ),
                    ],
                  ),

                  Gap(33.h),

                  AppButton(
                    text: AppStrings.signIn.tr,
                    onPressed: () => context.push(RoutePath.main.addBasePath),
                    width: double.infinity,
                    height: 48.h,
                    backgroundColor: AppColors.primary,
                    borderRadius: 8,
                    textStyle: AppStyle.inter16w700CFFFFFF,
                  ),

                  Gap(28.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.dontHaveAAccount.tr,
                        style: AppStyle.roboto14w400C000000,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push(RoutePath.adminSignUp.addBasePath);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              // color: AppColors.yellowFFD673,
                              // Optional for rounded background
                              border: Border(
                                  bottom: BorderSide(
                                      width: 2, color: AppColors.primary))),
                          // padding: EdgeInsets.only(bottom: 2.h),
                          child: Text(
                            AppStrings.signUp.tr,
                            style: AppStyle
                                .inter14w500C7CE3D7, // Change text color for contrast if needed
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(20.h),
                  Text(
                    AppStrings.or.tr,
                    style: AppStyle.roboto14w500C80000000,
                  ),

                  Gap(20.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon(
                        iconPath: Assets.icons.appleSignin.path,
                        onTap: () {},
                      ),
                      Gap(15.w),
                      _buildSocialIcon(
                        iconPath: Assets.icons.google.path,
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon({
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.asset(iconPath),
      ),
    );
  }
}
