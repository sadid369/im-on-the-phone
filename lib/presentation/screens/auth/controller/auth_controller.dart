import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_path.dart';
import '../../../../helper/extension/base_extension.dart';

class AuthController extends GetxController {
  // Observable variables
  var rememberMe = false.obs;
  var passwordVisible = false.obs;
  var isLoading = false.obs;

  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
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

  // Login method
  void login(BuildContext context) {
    if (isLoading.value) return;

    String email = emailController.text.trim().toLowerCase();
    String password = passwordController.text.trim();

    // Basic validation
    if (email.isEmpty) {
      _showError(context, 'Please enter email');
      return;
    }

    isLoading.value = true;

    // Simulate login process
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;

      if (email == 'admin') {
        // Navigate directly to admin dashboard
        context.go(RoutePath.adminDashboard.addBasePath);
      } else if (email == 'user') {
        // Navigate directly to user home
        context.go(RoutePath.home.addBasePath);
      } else {
        _showError(context, 'Please enter "admin" or "user" in email field');
      }
    });
  }

  // Show error message
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Clear form
  void clearForm() {
    emailController.clear();
    passwordController.clear();
    rememberMe.value = false;
    passwordVisible.value = false;
  }

  // Social login methods (placeholder)
  void loginWithGoogle() {
    // Implement Google login
    Get.snackbar('Info', 'Google login not implemented yet');
  }

  void loginWithApple() {
    // Implement Apple login
    Get.snackbar('Info', 'Apple login not implemented yet');
  }
}
