import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:groc_shopy/utils/app_colors/app_colors.dart';
import 'package:groc_shopy/utils/static_strings/static_strings.dart';

import '../../../global/model/contact.dart';

import '../../widgets/custom_bottons/custom_button/app_button.dart';
import '../../widgets/custom_text_form_field/custom_text_form.dart';
import 'controller/contact_controller.dart';

class NewContactScreen extends StatefulWidget {
  final Contact? editContact; // For editing existing contact

  const NewContactScreen({Key? key, this.editContact}) : super(key: key);

  @override
  _NewContactScreenState createState() => _NewContactScreenState();
}

class _NewContactScreenState extends State<NewContactScreen> {
  late final ContactController contactController;
  Contact? editContact;
  bool _hasLoadedContact = false; // Add this flag

  // Consistent border style for all text fields
  final _borderRadius = BorderRadius.circular(12.r);
  final _borderColor = Colors.grey.shade300;

  @override
  void initState() {
    super.initState();
    contactController = Get.isRegistered<ContactController>()
        ? Get.find<ContactController>()
        : Get.put(ContactController());

    // If editing, load contact data
    if (widget.editContact != null) {
      contactController.loadContactForEditing(widget.editContact!);
      _hasLoadedContact = true; // Set flag to true
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Only load contact data if not already loaded
    if (!_hasLoadedContact) {
      // Get the extra parameter from GoRouter
      final extra = GoRouterState.of(context).extra;

      if (extra is Contact) {
        editContact = extra;
        contactController.loadContactForEditing(editContact!);
        _hasLoadedContact = true; // Set flag to true
      } else if (extra is Map<String, dynamic>) {
        if (extra['apiContact'] != null && extra['isApiContact'] == true) {
          // Handle API contact editing
          final apiContact = extra['apiContact'] as Contact;
          contactController.loadContactForEditing(apiContact);
          _hasLoadedContact = true; // Set flag to true
        } else if (extra['prefill'] == true) {
          // Handle prefill from default caller
          contactController.firstNameController.text = extra['name'] ?? '';
          contactController.messageController.text = extra['message'] ?? '';
          _hasLoadedContact = true; // Set flag to true
        }
      }
    }
  }

  void _onSave() {
    if (editContact != null) {
      // Update existing local contact
      contactController.updateContact(context, editContact!);
    } else {
      // Save new contact (will be sent to API)
      contactController.saveContact(context);
    }
  }

  void _onCancel() {
    contactController.clearForm();
    Navigator.of(context).pop();
  }

  Widget _buildSectionTile({
    required Widget leading,
    Widget? title,
    Widget? trailing,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: InkWell(
        borderRadius: _borderRadius,
        onTap: enabled ? onTap : null,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 6.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: _borderColor, width: 1.2.w),
            borderRadius: _borderRadius,
          ),
          child: Row(
            children: [
              leading,
              if (title != null) ...[
                Gap(12.w),
                Expanded(child: title),
              ],
              if (trailing != null) trailing,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Form(
        key: contactController.formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              // ===== Custom "AppBar" =====
              SafeArea(
                bottom: false,
                child: Container(
                  height: topPadding + 56.h,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: _onCancel,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            AppStrings.cancel.tr,
                            style: TextStyle(
                                color: AppColors.primary, fontSize: 16.sp),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Obx(() => Text(
                                contactController.isEditingApiContact.value ||
                                        editContact != null
                                    ? AppStrings.editContact.tr
                                    : AppStrings.newContact.tr,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        ),
                      ),
                      Obx(() => TextButton(
                            onPressed: contactController.isSaving.value
                                ? null
                                : _onSave,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: contactController.isSaving.value
                                ? SizedBox(
                                    width: 16.w,
                                    height: 16.h,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.primary,
                                    ),
                                  )
                                : Text(
                                    AppStrings.done.tr,
                                    style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 16.sp),
                                  ),
                          )),
                    ],
                  ),
                ),
              ),

              // Show API contact indicator
              Obx(() => contactController.isEditingApiContact.value
                  ? Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: _borderRadius,
                        border: Border.all(color: Colors.blue.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.cloud, color: Colors.blue, size: 16.r),
                          Gap(8.w),
                          Text(
                            'Editing server contact',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.blue[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink()),

              // Avatar + Add Photo
              Column(
                children: [
                  Obx(() => GestureDetector(
                        onTap: () => contactController
                            .showImagePickerBottomSheet(context),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 40.r,
                              backgroundColor: Colors.grey.shade300,
                              backgroundImage:
                                  contactController.profileImage.value != null
                                      ? FileImage(
                                          contactController.profileImage.value!)
                                      : null,
                              child:
                                  contactController.profileImage.value == null
                                      ? Icon(Icons.person,
                                          size: 40.r, color: Colors.white70)
                                      : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 24.w,
                                height: 24.h,
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 2.w),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 12.r,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Obx(() => TextButton(
                        onPressed: contactController.isPickingImage.value
                            ? null
                            : () => contactController
                                .showImagePickerBottomSheet(context),
                        child: contactController.isPickingImage.value
                            ? SizedBox(
                                width: 16.w,
                                height: 16.h,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Text(
                                AppStrings.addPhoto.tr,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 14.sp),
                              ),
                      )),
                ],
              ),
              Gap(10.h),

              // First Name field
              CustomTextFormField(
                controller: contactController.firstNameController,
                validator: contactController.validateFirstName,
                hintText: AppStrings.firstName.tr,
                borderRadius: _borderRadius,
                enabledBorderColor: _borderColor,
                focusedBorderColor: _borderColor,
                errorBorderColor: Colors.red,
                focusedErrorBorderColor: Colors.red,
                focusedBorderWidth: 1.2.w,
                enabledBorderWidth: 1.2.w,
                prefix:
                    Icon(Icons.person_outline, color: Colors.grey, size: 20.r),
              ),
              Gap(12.h),

              // Last Name field
              CustomTextFormField(
                controller: contactController.lastNameController,
                validator: contactController.validateLastName,
                hintText: AppStrings.lastName.tr,
                borderRadius: _borderRadius,
                enabledBorderColor: _borderColor,
                focusedBorderColor: _borderColor,
                errorBorderColor: Colors.red,
                focusedErrorBorderColor: Colors.red,
                focusedBorderWidth: 1.2.w,
                enabledBorderWidth: 1.2.w,
                prefix:
                    Icon(Icons.person_outline, color: Colors.grey, size: 20.r),
              ),
              Gap(12.h),

              // Phone field
              CustomTextFormField(
                controller: contactController.phoneController,
                validator: contactController.validatePhoneNumber,
                hintText: AppStrings.phoneNumber.tr,
                keyboardType: TextInputType.phone,
                borderRadius: _borderRadius,
                enabledBorderColor: _borderColor,
                focusedBorderColor: _borderColor,
                errorBorderColor: Colors.red,
                focusedErrorBorderColor: Colors.red,
                focusedBorderWidth: 1.2.w,
                enabledBorderWidth: 1.2.w,
                prefix: Icon(Icons.phone, color: Colors.green, size: 20.r),
              ),
              Gap(12.h),

              // Message field
              CustomTextFormField(
                controller: contactController.messageController,
                validator: contactController.validateMessage,
                hintText: AppStrings.message.tr,
                maxLength: 200,
                keyboardType: TextInputType.multiline,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
                borderRadius: _borderRadius,
                enabledBorderColor: _borderColor,
                focusedBorderColor: _borderColor,
                errorBorderColor: Colors.red,
                focusedErrorBorderColor: Colors.red,
                focusedBorderWidth: 1.2.w,
                enabledBorderWidth: 1.2.w,
                prefix: Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: Icon(Icons.message_outlined,
                      color: Colors.blue, size: 20.r),
                ),
              ),
              Gap(16.h),

              // Add Voice section
              Obx(() => _buildSectionTile(
                    leading: Icon(
                      contactController.selectedVoiceFile.value != null
                          ? Icons.audiotrack
                          : Icons.add_circle,
                      color: contactController.selectedVoiceFile.value != null
                          ? Colors.green
                          : Colors.grey,
                      size: 24.r,
                    ),
                    title: Text(
                      contactController.selectedVoiceFile.value != null
                          ? contactController.voiceFileName.value
                          : AppStrings.addVoice.tr,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: contactController.selectedVoiceFile.value != null
                            ? Colors.black
                            : Colors.grey[600],
                      ),
                    ),
                    trailing: contactController.isPickingFile.value
                        ? SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Icon(
                            contactController.selectedVoiceFile.value != null
                                ? Icons.check_circle
                                : Icons.graphic_eq,
                            color: contactController.selectedVoiceFile.value !=
                                    null
                                ? Colors.green
                                : Colors.grey,
                            size: 24.r,
                          ),
                    onTap: contactController.isPickingFile.value
                        ? null
                        : () {
                            if (!contactController.isPickingFile.value) {
                              contactController.pickVoiceFile(context);
                            }
                          },
                    enabled: !contactController.isPickingFile.value,
                  )),

              // Show selected voice file info
              Obx(() => contactController.selectedVoiceFile.value != null
                  ? Container(
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: _borderRadius,
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.audiotrack,
                              color: Colors.green, size: 20.r),
                          Gap(8.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  contactController.voiceFileName.value,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Voice file selected',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.green.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              contactController.selectedVoiceFile.value = null;
                              contactController.voiceFileName.value = '';
                            },
                            icon: Icon(Icons.close,
                                color: Colors.red, size: 20.r),
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink()),

              Gap(24.h),

              // Save button
              Obx(() => AppButton(
                    text: contactController.isSaving.value
                        ? 'Saving...'
                        : (contactController.isEditingApiContact.value ||
                                editContact != null
                            ? AppStrings.updateContact.tr
                            : AppStrings.saveContact.tr),
                    onPressed:
                        contactController.isSaving.value ? null : _onSave,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    backgroundColor: contactController.isSaving.value
                        ? Colors.grey
                        : AppColors.primary,
                    borderRadius: 12.r,
                    height: 50.h,
                  )),

              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
