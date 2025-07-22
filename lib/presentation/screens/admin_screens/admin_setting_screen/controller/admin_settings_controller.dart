import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../service/change_password_service.dart';
import '../../../../../service/user_profile_service.dart';
import '../../../../../global/model/user_profile.dart';
import '../../../../../service/user_profile_update_service.dart';

class AdminSettingsController extends GetxController {
  var userProfile = Rxn<UserProfile>();

  Future<void> loadUserProfile(BuildContext context) async {
    final profile = await UserProfileService.getUserProfile(context);
    userProfile.value = profile;
  }

  Future<void> saveProfile(
    BuildContext context,
    String name,
    File? profileImage,
  ) async {
    final success = await UserProfileUpdateService.updateUserProfile(
      context,
      name: name,
      profileImage: profileImage,
    );
    if (success) {
      // Refresh profile data in controller
      await loadUserProfile(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated!')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  var isLoading = false.obs;

  Future<bool> changePassword(
    BuildContext context, {
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    isLoading.value = true;
    final success = await ChangePasswordService.changePassword(
      context,
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    );
    isLoading.value = false;
    return success;
  }
}
