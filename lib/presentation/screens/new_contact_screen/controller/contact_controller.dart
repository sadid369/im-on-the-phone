import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../../global/model/contact.dart';
import '../../../../utils/static_strings/static_strings.dart';



class ContactController extends GetxController {
  // Observable variables
  var isLoading = false.obs;
  var isSaving = false.obs;
  var isPickingFile = false.obs;
  var isPickingImage = false.obs;
  var contacts = <Contact>[].obs;
  var selectedContact = Rxn<Contact>();
  
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

  @override
  void onInit() {
    super.onInit();
    loadContacts();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.onClose();
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
    // Basic phone number validation (you can make this more sophisticated)
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

  // Pick profile image
  Future<void> pickProfileImage(BuildContext context, ImageSource source) async {
    if (isPickingImage.value) return;
    
    isPickingImage.value = true;
    
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 512,
        maxHeight: 512,
      );

      if (pickedFile != null) {
        profileImage.value = File(pickedFile.path);
        _showAwesomeSnackbar(
          context,
          title: AppStrings.success.tr,
          message: AppStrings.profileImageSelected.tr,
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
    } finally {
      isPickingImage.value = false;
    }
  }

  // Pick voice file
  Future<void> pickVoiceFile(BuildContext context) async {
    if (isPickingFile.value) return;
    
    isPickingFile.value = true;

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
        allowedExtensions: ['mp3', 'wav', 'm4a', 'aac'],
      );

      if (result != null && result.files.single.path != null) {
        selectedVoiceFile.value = File(result.files.single.path!);
        voiceFileName.value = result.files.single.name;
        
        _showAwesomeSnackbar(
          context,
          title: AppStrings.success.tr,
          message: AppStrings.voiceFileSelected.tr,
          contentType: ContentType.success,
        );
      }
    } catch (e) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.error.tr,
        message: AppStrings.failedToPickVoiceFile.tr,
        contentType: ContentType.failure,
      );
    } finally {
      isPickingFile.value = false;
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
                  pickProfileImage(context, ImageSource.camera);
                },
              ),
              _buildImageSourceOption(
                context,
                icon: Icons.photo_library,
                label: AppStrings.gallery.tr,
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

  // Save contact
  Future<void> saveContact(BuildContext context) async {
    if (isSaving.value) return;

    if (!formKey.currentState!.validate()) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.validationError.tr,
        message: AppStrings.pleaseFixErrors.tr,
        contentType: ContentType.failure,
      );
      return;
    }

    isSaving.value = true;

    try {
      // Create new contact
      final contact = Contact(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        message: messageController.text.trim(),
        profileImagePath: profileImage.value?.path,
        voiceFilePath: selectedVoiceFile.value?.path,
        voiceFileName: voiceFileName.value.isEmpty ? null : voiceFileName.value,
        themeId: selectedThemeId.value,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Add to contacts list
      contacts.add(contact);

      _showAwesomeSnackbar(
        context,
        title: AppStrings.success.tr,
        message: AppStrings.contactSavedSuccessfully.tr,
        contentType: ContentType.success,
      );

      // Clear form and navigate back with success result
      clearForm();
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context, true); // Return true to indicate success
      });

    } catch (e) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.error.tr,
        message: AppStrings.failedToSaveContact.tr,
        contentType: ContentType.failure,
      );
    } finally {
      isSaving.value = false;
    }
  }

  // Load contacts (simulate loading from storage/API)
  Future<void> loadContacts() async {
    isLoading.value = true;
    
    try {
      // Simulate loading delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Here you would load from local storage or API
      // For now, we'll just clear the loading state
      
    } catch (e) {
      print('Error loading contacts: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Update contact
  Future<void> updateContact(BuildContext context, Contact contact) async {
    if (isSaving.value) return;

    if (!formKey.currentState!.validate()) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.validationError.tr,
        message: AppStrings.pleaseFixErrors.tr,
        contentType: ContentType.failure,
      );
      return;
    }

    isSaving.value = true;

    try {
      // Update contact properties
      contact.firstName = firstNameController.text.trim();
      contact.lastName = lastNameController.text.trim();
      contact.phoneNumber = phoneController.text.trim();
      contact.message = messageController.text.trim();
      contact.profileImagePath = profileImage.value?.path ?? contact.profileImagePath;
      contact.voiceFilePath = selectedVoiceFile.value?.path ?? contact.voiceFilePath;
      contact.voiceFileName = voiceFileName.value.isEmpty ? contact.voiceFileName : voiceFileName.value;
      contact.themeId = selectedThemeId.value ?? contact.themeId;
      contact.updatedAt = DateTime.now();

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Update in contacts list
      final index = contacts.indexWhere((c) => c.id == contact.id);
      if (index != -1) {
        contacts[index] = contact;
      }

      _showAwesomeSnackbar(
        context,
        title: AppStrings.success.tr,
        message: AppStrings.contactUpdatedSuccessfully.tr,
        contentType: ContentType.success,
      );

      // Clear form and navigate back with success result
      clearForm();
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context, true); // Return true to indicate success
      });

    } catch (e) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.error.tr,
        message: AppStrings.failedToUpdateContact.tr,
        contentType: ContentType.failure,
      );
    } finally {
      isSaving.value = false;
    }
  }

  // Delete contact
  Future<void> deleteContact(BuildContext context, Contact contact) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      contacts.removeWhere((c) => c.id == contact.id);

      _showAwesomeSnackbar(
        context,
        title: AppStrings.success.tr,
        message: AppStrings.contactDeletedSuccessfully.tr,
        contentType: ContentType.success,
      );

    } catch (e) {
      _showAwesomeSnackbar(
        context,
        title: AppStrings.error.tr,
        message: AppStrings.failedToDeleteContact.tr,
        contentType: ContentType.failure,
      );
    }
  }

  // Load contact for editing
  void loadContactForEditing(Contact contact) {
    selectedContact.value = contact;
    firstNameController.text = contact.firstName;
    lastNameController.text = contact.lastName;
    phoneController.text = contact.phoneNumber;
    messageController.text = contact.message;
    
    if (contact.profileImagePath != null) {
      profileImage.value = File(contact.profileImagePath!);
    }
    
    if (contact.voiceFilePath != null) {
      selectedVoiceFile.value = File(contact.voiceFilePath!);
      voiceFileName.value = contact.voiceFileName ?? '';
    }
    
    selectedThemeId.value = contact.themeId;
  }

  // Clear form
  void clearForm() {
    selectedContact.value = null;
    firstNameController.clear();
    lastNameController.clear();
    phoneController.clear();
    messageController.clear();
    profileImage.value = null;
    selectedVoiceFile.value = null;
    voiceFileName.value = '';
    selectedThemeId.value = null;
  }

  // Search contacts
  List<Contact> searchContacts(String query) {
    if (query.isEmpty) return contacts;
    
    return contacts.where((contact) {
      final fullName = contact.fullName.toLowerCase();
      final phone = contact.phoneNumber.toLowerCase();
      final searchQuery = query.toLowerCase();
      
      return fullName.contains(searchQuery) || phone.contains(searchQuery);
    }).toList();
  }

  // Get contact by phone number
  Contact? getContactByPhone(String phoneNumber) {
    try {
      return contacts.firstWhere((contact) => contact.phoneNumber == phoneNumber);
    } catch (e) {
      return null;
    }
  }
}