import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_path.dart';
import '../../../../helper/extension/base_extension.dart';
import '../../../../core/routes/routes.dart';

class AuthController extends GetxController {
  // Observable variables
  var isAdmin = false.obs;
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

  // Set admin status and refresh router
  void setAdminStatus(bool status) {
    isAdmin.value = status;
    // Force router to rebuild with new admin status
    AppRouter.refreshRouter();
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

    // if (password.isEmpty) {
    //   _showError(context, 'Please enter password');
    //   return;
    // }

    isLoading.value = true;

    // Simulate login process
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;

      if (email == 'admin') {
        // Navigate to a route that exists for both admin and user, then redirect
        // context.go(RoutePath.home.addBasePath);
        // Then immediately navigate to admin dashboard

        setAdminStatus(true);
        context.go(RoutePath.adminDashboard.addBasePath);
      } else if (email == 'user') {
        setAdminStatus(false);
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
