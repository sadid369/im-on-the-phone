import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../widgets/custom_bottons/custom_button/app_button.dart';
import '../../widgets/custom_text_form_field/custom_text_form.dart';

class NewContactScreen extends StatefulWidget {
  @override
  _NewContactScreenState createState() => _NewContactScreenState();
}

class _NewContactScreenState extends State<NewContactScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _messageController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedVoicePath;
  String _voiceFileName = '';
  bool _isPickingFile = false;

  // Consistent border style for all text fields
  final _borderRadius = BorderRadius.circular(12.r);
  final _borderColor = Colors.grey.shade300;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _messageController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onSave() {
    // TODO: Implement save logic
    print('First: ${_firstNameController.text}, '
        'Last: ${_lastNameController.text}, '
        'Phone: ${_phoneController.text}, '
        'Msg: ${_messageController.text}, '
        'Voice: $_selectedVoicePath');
  }

  Future<void> _pickVoiceFile() async {
    if (_isPickingFile) return;
    setState(() {
      _isPickingFile = true;
    });

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
      );

      if (result != null) {
        setState(() {
          _selectedVoicePath = result.files.single.path;
          _voiceFileName = result.files.single.name;
        });
      }
    } catch (e) {
      // Optionally handle error
    } finally {
      setState(() {
        _isPickingFile = false;
      });
    }
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          children: [
            // ===== custom "AppBar" =====
            SafeArea(
              bottom: false,
              child: Container(
                height: topPadding + 56.h,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.teal, fontSize: 16.sp),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'New Contact',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _onSave,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Done',
                        style: TextStyle(color: Colors.black, fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // avatar + add photo
            Column(
              children: [
                CircleAvatar(
                  radius: 40.r,
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(Icons.person, size: 40.r, color: Colors.white70),
                ),
                TextButton(
                  onPressed: () {/* pick photo */},
                  child: Text('Add Photo',
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
                ),
              ],
            ),
            Gap(10.h),

            // First & Last name fields
            CustomTextFormField(
              controller: _firstNameController,
              hintText: 'First name',
              borderRadius: _borderRadius,
              enabledBorderColor: _borderColor,
              focusedBorderColor: _borderColor,
              focusedBorderWidth: 1.2.w,
              enabledBorderWidth: 1.2.w,
            ),
            Gap(12.h),
            CustomTextFormField(
              controller: _lastNameController,
              hintText: 'Last name',
              borderRadius: _borderRadius,
              enabledBorderColor: _borderColor,
              focusedBorderColor: _borderColor,
              focusedBorderWidth: 1.2.w,
              enabledBorderWidth: 1.2.w,
            ),
            Gap(12.h),

            // Phone field
            CustomTextFormField(
              controller: _phoneController,
              hintText: 'Phone number',
              keyboardType: TextInputType.phone,
              borderRadius: _borderRadius,
              enabledBorderColor: _borderColor,
              focusedBorderColor: _borderColor,
              focusedBorderWidth: 1.2.w,
              enabledBorderWidth: 1.2.w,
              prefix: Icon(Icons.phone, color: Colors.green, size: 20.r),
            ),
            Gap(12.h),

            // Message field
            CustomTextFormField(
              controller: _messageController,
              hintText: 'Message',
              maxLength: 200,
              keyboardType: TextInputType.multiline,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
              borderRadius: _borderRadius,
              enabledBorderColor: _borderColor,
              focusedBorderColor: _borderColor,
              focusedBorderWidth: 1.2.w,
              enabledBorderWidth: 1.2.w,
            ),
            Gap(16.h),

            // Ringtone section
            _buildSectionTile(
              leading: Icon(Icons.music_note, color: Colors.grey, size: 24.r),
              title: Text('Ringtone', style: TextStyle(fontSize: 15.sp)),
              trailing: Text('Default',
                  style: TextStyle(color: Colors.black54, fontSize: 14.sp)),
              onTap: () {/* pick ringtone */},
            ),

            // Add Voice section
            _buildSectionTile(
              leading: Icon(Icons.add_circle, color: Colors.green, size: 24.r),
              title: Text(
                _selectedVoicePath != null ? _voiceFileName : 'add voice',
                style: TextStyle(fontSize: 15.sp),
              ),
              trailing: _isPickingFile
                  ? SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(
                      Icons.graphic_eq,
                      color: Colors.grey,
                      size: 24.r,
                    ),
              onTap: _pickVoiceFile,
              enabled: !_isPickingFile,
            ),

            // Add Theme section
            _buildSectionTile(
              leading: Icon(Icons.add_circle, color: Colors.green, size: 24.r),
              title: Text('add theme', style: TextStyle(fontSize: 15.sp)),
              trailing: Icon(Icons.palette, color: Colors.grey, size: 24.r),
              onTap: () {/* add theme */},
            ),

            Gap(24.h),

            // Save button
            AppButton(
              text: 'Save Contact',
              onPressed: _onSave,
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              borderRadius: 12.r,
              height: 50.h,
            ),
          ],
        ),
      ),
    );
  }
}
