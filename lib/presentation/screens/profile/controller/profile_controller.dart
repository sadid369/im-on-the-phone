import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../../utils/static_strings/static_strings.dart';
import '../../../../service/user_profile_update_service.dart';
import '../../../../service/user_profile_service.dart';
import '../../../../service/change_password_service.dart';
import '../../home/controller/home_controller.dart';

class ProfileController extends GetxController {
  // Observable variables
  var isLoading = false.obs;
  var passwordVisible = false.obs;
  var profileImage = Rxn<File>();
  var profileImagePath = ''.obs;

  // Text controllers for update profile
  final nameController = TextEditingController(text: 'Angel Mthembu');
  final emailController = TextEditingController(text: 'angelmthembu@example.com');

  // Text controllers for change password
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Form keys for validation
  final updateProfileFormKey = GlobalKey<FormState>();
  final changePasswordFormKey = GlobalKey<FormState>();

  // Image picker instance
  final ImagePicker _picker = ImagePicker();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize with current user data
    _initializeUserData();
  }

  // Initialize with current user profile data
  void _initializeUserData() {
    final homeController = Get.find<HomeController>();
    final userProfile = homeController.userProfile.value;
    
    if (userProfile != null) {
      nameController.text = userProfile.name ?? '';
      emailController.text = userProfile.email ?? '';
    }
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  // Validation functions
  String? validateName(String? value) {
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

  String? validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.currentPasswordRequired.tr;
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.newPasswordRequired.tr;
    }
    if (!AppStrings.passwordRegex.hasMatch(value)) {
      return AppStrings.passWordMustBeAtLeast.tr;
    }
    if (value == currentPasswordController.text) {
      return AppStrings.newPasswordMustBeDifferent.tr;
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.confirmPasswordRequired.tr;
    }
    if (value != newPasswordController.text) {
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

  // Pick image from camera
  Future<void> pickImageFromCamera(BuildContext context) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 512,
        maxHeight: 512,
      );

      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
        profileImagePath.value = pickedFile.path;
        
        _showAwesomeSnackbar(
          context,
          title: AppStrings.success.tr,
          message: AppStrings.profilePictureUpdated.tr,
          contentType: ContentType.success,
        );
      }
    } catch (e) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.error.tr,
        message: AppStrings.failedToPickImage.tr,
        contentType: ContentType.failure,
      );
    }
  }

  // Pick image from gallery
  Future<void> pickImageFromGallery(BuildContext context) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 512,
        maxHeight: 512,
      );

      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
        profileImagePath.value = pickedFile.path;
        
        _showAwesomeSnackbar(
          context,
          title: AppStrings.success.tr,
          message: AppStrings.profilePictureUpdated.tr,
          contentType: ContentType.success,
        );
      }
    } catch (e) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.error.tr,
        message: AppStrings.failedToPickImage.tr,
        contentType: ContentType.failure,
      );
    }
  }

  // Update profile - Modified to use real API
  Future<void> updateProfile(BuildContext context) async {
    if (isLoading.value) return;

    if (!updateProfileFormKey.currentState!.validate()) {
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
      // Call the API to update profile
      final success = await UserProfileUpdateService.updateUserProfile(
        context,
        name: nameController.text.trim(),
        profileImage: profileImage.value,
      );

      if (success) {
        // Refresh user profile data in HomeController
        final homeController = Get.find<HomeController>();
        await homeController.loadUserProfile(context);
        
        _showAwesomeSnackbar(
          context,
          title: AppStrings.success.tr,
          message: AppStrings.profileUpdatedSuccessfully.tr,
          contentType: ContentType.success,
        );

        // Navigate back after success
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      } else {
        _showAwesomeSnackbar(
          context,
          title: AppStrings.error.tr,
          message: AppStrings.failedToUpdateProfile.tr,
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.error.tr,
        message: AppStrings.failedToUpdateProfile.tr,
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Change password - Updated to use real API
  Future<void> changePassword(BuildContext context) async {
    if (isLoading.value) return;

    if (!changePasswordFormKey.currentState!.validate()) {
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
      // Call the API to change password
      final success = await ChangePasswordService.changePassword(
        context,
        currentPassword: currentPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim(),
        confirmNewPassword: confirmPasswordController.text.trim(),
      );

      if (success) {
        _showAwesomeSnackbar(
          context,
          title: AppStrings.success.tr,
          message: AppStrings.passwordChangedSuccessfully.tr,
          contentType: ContentType.success,
        );

        // Clear password fields
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();

        // Navigate back after success
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });
      } else {
        _showAwesomeSnackbar(
          context,
          title: AppStrings.error.tr,
          message: AppStrings.failedToChangePassword.tr,
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.error.tr,
        message: AppStrings.failedToChangePassword.tr,
        contentType: ContentType.failure,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Show image picker bottom sheet
  void showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildImagePickerBottomSheet(context),
    );
  }

  Widget _buildImagePickerBottomSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: 20),
          Text(
            AppStrings.selectImageSource.tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildImageSourceOption(
                context,
                icon: Icons.camera_alt,
                label: AppStrings.camera.tr,
                onTap: () {
                  Navigator.pop(context);
                  pickImageFromCamera(context);
                },
              ),
              _buildImageSourceOption(
                context,
                icon: Icons.photo_library,
                label: AppStrings.gallery.tr,
                onTap: () {
                  Navigator.pop(context);
                  pickImageFromGallery(context);
                },
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildImageSourceOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 30,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}