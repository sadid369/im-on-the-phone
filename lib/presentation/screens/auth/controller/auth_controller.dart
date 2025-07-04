import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../../core/routes/route_path.dart';
import '../../../../helper/extension/base_extension.dart';
import '../../../../utils/static_strings/static_strings.dart';

class AuthController extends GetxController {
  // Observable variables
  var rememberMe = false.obs;
  var passwordVisible = false.obs;
  var isLoading = false.obs;
  var isResetButtonEnabled = false.obs;

  // Text controllers for signup
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
  // Text controller for forgot password
  final forgotPasswordEmailController = TextEditingController();

  // Form keys for validation
  final formKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    
    // Listen to forgot password email changes
    forgotPasswordEmailController.addListener(() {
      final isValid = forgotPasswordEmailController.text.isNotEmpty &&
          AppStrings.emailRegexp.hasMatch(forgotPasswordEmailController.text.trim());
      isResetButtonEnabled.value = isValid;
    });
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    forgotPasswordEmailController.dispose();
    super.onClose();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  // Toggle remember me
  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  // Validation functions using localized strings
  String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.fullNameRequired.tr;
    }
    if (value.trim().length < 2) {
      return AppStrings.fullNameMinLength.tr;
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emailRequired.tr;
    }
    if (!AppStrings.emailRegexp.hasMatch(value.trim())) {
      return AppStrings.enterValidEmail.tr;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired.tr;
    }
    if (!AppStrings.passwordRegex.hasMatch(value)) {
      return AppStrings.passWordMustBeAtLeast.tr;
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.confirmPasswordRequired.tr;
    }
    if (value != passwordController.text) {
      return AppStrings.passwordsDoNotMatch.tr;
    }
    return null;
  }

  // Show awesome snackbar
  void _showAwesomeSnackbar(BuildContext context, {
    required String title,
    required String message,
    required ContentType contentType,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  // Signup method
  void signUp(BuildContext context) async {
    if (isLoading.value) return;

    if (!formKey.currentState!.validate()) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.validationError.tr,
        message: AppStrings.pleaseFixErrors.tr,
        contentType: ContentType.failure,
      );
      return;
    }

    isLoading.value = true;

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate success
      _showAwesomeSnackbar(
        context,
        title: AppStrings.success.tr,
        message: AppStrings.accountCreatedSuccessfully.tr,
        contentType: ContentType.success,
      );

      // Navigate to login or dashboard
      Future.delayed(const Duration(seconds: 1), () {
        context.go(RoutePath.login.addBasePath);
      });

    } catch (e) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.error.tr,
        message: AppStrings.failedToCreateAccount.tr,
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Login method
  void login(BuildContext context) {
    if (isLoading.value) return;

    String email = emailController.text.trim().toLowerCase();
    String password = passwordController.text.trim();

    // Basic validation
    if (email.isEmpty) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.warning.tr,
        message: AppStrings.pleaseEnterEmail.tr,
        contentType: ContentType.warning,
      );
      return;
    }

    isLoading.value = true;

    // Simulate login process
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;

      if (email == 'admin') {
        _showAwesomeSnackbar(
          context,
          title: AppStrings.welcome_title.tr,
          message: AppStrings.adminLoginSuccessful.tr,
          contentType: ContentType.success,
        );
        context.go(RoutePath.adminDashboard.addBasePath);
      } else if (email == 'user') {
        _showAwesomeSnackbar(
          context,
          title: AppStrings.welcome_title.tr,
          message: AppStrings.userLoginSuccessful.tr,
          contentType: ContentType.success,
        );
        context.go(RoutePath.home.addBasePath);
      } else {
        _showAwesomeSnackbar(
          context,
          title: AppStrings.invalidCredentials.tr,
          message: AppStrings.enterAdminOrUser.tr,
          contentType: ContentType.failure,
        );
      }
    });
  }

  // Forgot Password method
  void forgotPassword(BuildContext context) async {
    if (isLoading.value) return;

    if (!forgotPasswordFormKey.currentState!.validate()) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.validationError.tr,
        message: AppStrings.pleaseFixErrors.tr,
        contentType: ContentType.failure,
      );
      return;
    }

    isLoading.value = true;

    try {
      // Simulate API call for password reset
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulate success
      _showAwesomeSnackbar(
        context,
        title: AppStrings.success.tr,
        message: AppStrings.passwordResetLinkSent.tr,
        contentType: ContentType.success,
      );

      // Navigate to verification screen
      Future.delayed(const Duration(seconds: 1), () {
        context.push(RoutePath.verification.addBasePath);
      });

    } catch (e) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.error.tr,
        message: AppStrings.failedToSendResetLink.tr,
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Clear form
  void clearForm() {
    fullNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    rememberMe.value = false;
    passwordVisible.value = false;
  }

  // Social login methods
  void loginWithGoogle() {
    Get.snackbar(AppStrings.info.tr, AppStrings.googleLoginNotImplemented.tr);
  }

  void loginWithApple() {
    Get.snackbar(AppStrings.info.tr, AppStrings.appleLoginNotImplemented.tr);
  }
}
