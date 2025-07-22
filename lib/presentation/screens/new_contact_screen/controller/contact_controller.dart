import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../../global/model/contact.dart';
import '../../../../service/contact_api_service.dart';

import '../../../../utils/static_strings/static_strings.dart';

class ContactController extends GetxController {
  // Observable variables
  var isLoading = false.obs;
  var isSaving = false.obs;
  var isPickingFile = false.obs;
  var isPickingImage = false.obs;
  var contacts = <Contact>[].obs;
  var selectedContact = Rxn<Contact>();
  var isEditingApiContact = false.obs;

  // Form variables
  var profileImage = Rxn<File>();
  var selectedVoiceFile = Rxn<File>();
  var voiceFileName = ''.obs;
  var selectedThemeId = Rxn<String>();

  // Text controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Image picker instance
  final ImagePicker _imagePicker = ImagePicker();

  // Add this observable to notify when contacts change
  var contactsChanged = false.obs;

  // Add the missing static variable declaration
  static bool _isFilePickerActive = false;

  @override
  void onInit() {
    super.onInit();
    loadContacts();
  }

  @override
  void onClose() {
    // Reset static flag
    _isFilePickerActive = false;

    // Dispose controllers
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    messageController.dispose();

    super.onClose();
  }

  // Load contact for editing (works for both API and local contacts)
  void loadContactForEditing(Contact contact) {
    selectedContact.value = contact;
    isEditingApiContact.value = contact.isApiContact;

    // Only update controllers if they're empty or different
    if (firstNameController.text != contact.firstName) {
      firstNameController.text = contact.firstName;
    }
    if (lastNameController.text != contact.lastName) {
      lastNameController.text = contact.lastName;
    }
    if (phoneController.text != contact.phoneNumber) {
      phoneController.text = contact.phoneNumber;
    }
    if (messageController.text != contact.message) {
      messageController.text = contact.message;
    }

    // Handle image
    if (contact.isApiContact) {
      // For API contacts, you might want to download and cache the image
      // profileImage.value = null; // Will show network image instead
    } else {
      if (contact.profileImagePath != null) {
        profileImage.value = File(contact.profileImagePath!);
      }
    }

    // Handle voice file
    if (contact.isApiContact) {
      // For API contacts, you might want to download and cache the voice file
      voiceFileName.value = contact.voice?.split('/').last ?? '';
    } else {
      if (contact.voiceFilePath != null) {
        selectedVoiceFile.value = File(contact.voiceFilePath!);
        voiceFileName.value = contact.voiceFilePath!.split('/').last;
      }
    }

    selectedThemeId.value =
        contact.isApiContact ? contact.theme : contact.themeId;
  }

  // Load API contact for editing (deprecated - use loadContactForEditing instead)
  @Deprecated('Use loadContactForEditing instead')
  void loadApiContactForEditing(Contact contact) {
    loadContactForEditing(contact);
  }

  // Add this method to notify about contact changes
  void notifyContactsChanged() {
    contactsChanged.value =
        !contactsChanged.value; // Toggle to trigger reactivity
  }

  // Save contact (API or local)
  Future<void> saveContact(BuildContext context) async {
    if (isSaving.value) return;

    if (!formKey.currentState!.validate()) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.error.tr,
        message: 'Please fix the errors in the form',
        contentType: ContentType.failure,
      );
      return;
    }

    isSaving.value = true;

    try {
      if (isEditingApiContact.value && selectedContact.value != null) {
        // Update API contact
        final contact = selectedContact.value!;
        final updatedContact = await ContactApiService.updateContact(
          id: contact.apiId ?? 0,
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          phoneNumber: phoneController.text.trim(),
          message: messageController.text.trim(),
          voiceFile: selectedVoiceFile.value,
          photoFile: profileImage.value,
          context: context,
        );

        // Notify that contacts have changed
        notifyContactsChanged();

        _showAwesomeSnackbar(
          context,
          title: AppStrings.success.tr,
          message: 'Contact updated successfully on server',
          contentType: ContentType.success,
        );
      } else {
        // Create new contact via API
        final newContact = await ContactApiService.createContact(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          phoneNumber: phoneController.text.trim(),
          message: messageController.text.trim(),
          voiceFile: selectedVoiceFile.value,
          photoFile: profileImage.value,
          context: context,
        );

        // Notify that contacts have changed
        notifyContactsChanged();

        _showAwesomeSnackbar(
          context,
          title: AppStrings.success.tr,
          message: 'Contact created successfully on server',
          contentType: ContentType.success,
        );
      }

      // Clear form and navigate back
      clearForm();
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context, true);
      });
    } catch (e) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.error.tr,
        message: 'Failed to save contact: $e',
        contentType: ContentType.failure,
      );
    } finally {
      isSaving.value = false;
    }
  }

  // Update existing contact (works for both API and local contacts)
  Future<void> updateContact(BuildContext context, Contact contact) async {
    if (isSaving.value) return;

    if (!formKey.currentState!.validate()) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.error.tr,
        message: 'Please fix the errors in the form',
        contentType: ContentType.failure,
      );
      return;
    }

    isSaving.value = true;

    try {
      if (contact.isApiContact) {
        // Update API contact
        await ContactApiService.updateContact(
          id: contact.apiId ?? 0,
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          phoneNumber: phoneController.text.trim(),
          message: messageController.text.trim(),
          voiceFile: selectedVoiceFile.value,
          photoFile: profileImage.value,
          context: context,
        );

        // Notify that contacts have changed
        notifyContactsChanged();

        _showAwesomeSnackbar(
          context,
          title: AppStrings.success.tr,
          message: 'Contact updated successfully on server',
          contentType: ContentType.success,
        );
      } else {
        // Update local contact
        contact.firstName = firstNameController.text.trim();
        contact.lastName = lastNameController.text.trim();
        contact.phoneNumber = phoneController.text.trim();
        contact.message = messageController.text.trim();

        if (profileImage.value != null) {
          contact.profileImagePath = profileImage.value!.path;
        }

        if (selectedVoiceFile.value != null) {
          contact.voiceFilePath = selectedVoiceFile.value!.path;
        }

        contact.themeId = selectedThemeId.value;

        // Update in local list
        int index = contacts.indexWhere((c) => c.uniqueId == contact.uniqueId);
        if (index != -1) {
          contacts[index] = contact;
        }

        _showAwesomeSnackbar(
          context,
          title: AppStrings.success.tr,
          message: 'Contact updated successfully',
          contentType: ContentType.success,
        );
      }

      // Clear form and navigate back
      clearForm();
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context, true);
      });
    } catch (e) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.error.tr,
        message: 'Failed to update contact: $e',
        contentType: ContentType.failure,
      );
    } finally {
      isSaving.value = false;
    }
  }

  // Clear form
  void clearForm() {
    selectedContact.value = null;
    isEditingApiContact.value = false;
    firstNameController.clear();
    lastNameController.clear();
    phoneController.clear();
    messageController.clear();
    profileImage.value = null;
    selectedVoiceFile.value = null;
    voiceFileName.value = '';
    selectedThemeId.value = null;
  }

  // Validation functions
  String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.firstNameRequired.tr;
    }
    if (value.trim().length < 2) {
      return AppStrings.firstNameMinLength.tr;
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.lastNameRequired.tr;
    }
    if (value.trim().length < 2) {
      return AppStrings.lastNameMinLength.tr;
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.phoneNumberRequired.tr;
    }
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return AppStrings.invalidPhoneNumber.tr;
    }
    return null;
  }

  String? validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.messageRequired.tr;
    }
    if (value.trim().length < 10) {
      return AppStrings.messageMinLength.tr;
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

  // Pick profile image
  Future<void> pickProfileImage(
      BuildContext context, ImageSource source) async {
    if (isPickingImage.value) return;

    isPickingImage.value = true;

    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
        _showAwesomeSnackbar(
          context,
          title: AppStrings.success.tr,
          message: 'Profile image selected successfully',
          contentType: ContentType.success,
        );
      }
    } catch (e) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.error.tr,
        message: 'Failed to pick image: $e',
        contentType: ContentType.failure,
      );
    } finally {
      isPickingImage.value = false;
    }
  }

  // Pick voice file with better error handling
  Future<void> pickVoiceFile(BuildContext context) async {
    // Prevent multiple simultaneous calls
    if (_isFilePickerActive || isPickingFile.value) {
      print('File picker already in progress, ignoring request');
      return;
    }

    _isFilePickerActive = true;
    isPickingFile.value = true;

    try {
      // Small delay to ensure UI updates
      await Future.delayed(const Duration(milliseconds: 100));

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp3', 'wav', 'm4a', 'aac', 'ogg', 'flac'],
        allowMultiple: false,
        withData: false, // Don't load file data in memory
        withReadStream: false, // Don't create read stream
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);

        // Verify file exists
        if (await file.exists()) {
          selectedVoiceFile.value = file;
          voiceFileName.value = result.files.single.name;

          _showAwesomeSnackbar(
            context,
            title: AppStrings.success.tr,
            message: 'Voice file selected: ${result.files.single.name}',
            contentType: ContentType.success,
          );
        } else {
          throw Exception('Selected file does not exist');
        }
      } else {
        print('File picker was cancelled by user');
      }
    } on PlatformException catch (e) {
      print('Platform exception: ${e.code} - ${e.message}');

      if (e.code == 'multiple_request') {
        print('Multiple file picker requests detected');
      } else if (!e.message.toString().contains('User cancelled')) {
        _showAwesomeSnackbar(
          context,
          title: AppStrings.error.tr,
          message: 'Failed to pick voice file: ${e.message}',
          contentType: ContentType.failure,
        );
      }
    } catch (e) {
      print('File picker error: $e');

      _showAwesomeSnackbar(
        context,
        title: AppStrings.error.tr,
        message: 'Failed to pick voice file: ${e.toString()}',
        contentType: ContentType.failure,
      );
    } finally {
      // Reset flags with a small delay
      await Future.delayed(const Duration(milliseconds: 100));
      isPickingFile.value = false;
      _isFilePickerActive = false;
    }
  }

  // Load contacts (simulate loading from storage/API)
  Future<void> loadContacts() async {
    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      print('Error loading contacts: $e');
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
          Text(
            'Select Image Source',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildImageSourceOption(
                context,
                icon: Icons.camera_alt,
                label: 'Camera',
                onTap: () {
                  Navigator.pop(context);
                  pickProfileImage(context, ImageSource.camera);
                },
              ),
              _buildImageSourceOption(
                context,
                icon: Icons.photo_library,
                label: 'Gallery',
                onTap: () {
                  Navigator.pop(context);
                  pickProfileImage(context, ImageSource.gallery);
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
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 32, color: Colors.blue),
          ),
          SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  // Add this method to preserve form state
  void preserveFormState() {
    // This method helps maintain form state during rebuilds
    // The actual preservation is handled by not clearing the controllers
  }
}
