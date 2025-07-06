import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../../core/routes/route_path.dart';
import '../../../../helper/extension/base_extension.dart';
import '../../../../utils/static_strings/static_strings.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  // Observable variables
  var rememberMe = false.obs;
  var passwordVisible = false.obs;
  var isLoading = false.obs;
  var isResetButtonEnabled = false.obs;

  // Text controllers for signup
  final fullNameController = TextEditingController();
  final emailController = TextEditingController(text: 'user');
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
          AppStrings.emailRegexp
              .hasMatch(forgotPasswordEmailController.text.trim());
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
  void _showAwesomeSnackbar(
    BuildContext context, {
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

  void loginWithApple(BuildContext context) async {
    if (isLoading.value) return;

    isLoading.value = true;

    try {
      // For USB connected device, use the server IP that works in your browser (10.10.7.84)
      final res = await http.get(
        Uri.parse('http://10.10.7.84:8000/'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Connection timeout');
        },
      );

      if (res.statusCode == 200) {
        _showAwesomeSnackbar(
          context,
          title: AppStrings.success.tr,
          message: 'Apple login server responded: ${res.body}',
          contentType: ContentType.success,
        );
        print('Response status: ${res.statusCode}');
        print('Response body: ${res.body}');
      } else {
        _showAwesomeSnackbar(
          context,
          title: AppStrings.warning.tr,
          message: 'Server returned status: ${res.statusCode}',
          contentType: ContentType.warning,
        );
      }
    } catch (e) {
      String errorMessage;
      if (e.toString().contains('Connection failed') ||
          e.toString().contains('Network is unreachable')) {
        errorMessage = 'Cannot connect to server at 10.10.7.84:8000\n'
            'USB connected device should use PC\'s network.';
      } else if (e.toString().contains('timeout')) {
        errorMessage = 'Connection timeout. Server may be busy.';
      } else {
        errorMessage = 'Apple login error: ${e.toString()}';
      }

      _showAwesomeSnackbar(
        context,
        title: AppStrings.error.tr,
        message: errorMessage,
        contentType: ContentType.failure,
      );

      print('Apple login error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
