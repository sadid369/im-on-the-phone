import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

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
  final _borderRadius = BorderRadius.circular(12);
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
      _isPickingFile = true; // Show the loading indicator
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
        _isPickingFile =
            false; // Hide the loading indicator once the process is complete
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
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: _borderColor, width: 1.2),
            borderRadius: _borderRadius,
          ),
          child: Row(
            children: [
              leading,
              if (title != null) ...[
                const SizedBox(width: 12),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            // ===== custom "AppBar" =====
            SafeArea(
              bottom: false,
              child: Container(
                height: topPadding + 56,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.teal, fontSize: 16),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'New Contact',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _onSave,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(color: Colors.black, fontSize: 16),
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
                  radius: 40,
                  backgroundColor: Colors.grey.shade300,
                  child:
                      const Icon(Icons.person, size: 40, color: Colors.white70),
                ),
                TextButton(
                  onPressed: () {/* pick photo */},
                  child: const Text('Add Photo',
                      style: TextStyle(color: Colors.grey)),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // First & Last name fields
            CustomTextFormField(
              controller: _firstNameController,
              hintText: 'First name',
              borderRadius: _borderRadius,
              enabledBorderColor: _borderColor,
              focusedBorderColor: _borderColor,
              focusedBorderWidth: 1.2,
              enabledBorderWidth: 1.2,
            ),
            const SizedBox(height: 12),
            CustomTextFormField(
              controller: _lastNameController,
              hintText: 'Last name',
              borderRadius: _borderRadius,
              enabledBorderColor: _borderColor,
              focusedBorderColor: _borderColor,
              focusedBorderWidth: 1.2,
              enabledBorderWidth: 1.2,
            ),
            const SizedBox(height: 12),

            // Phone field
            CustomTextFormField(
              controller: _phoneController,
              hintText: 'Phone number',
              keyboardType: TextInputType.phone,
              borderRadius: _borderRadius,
              enabledBorderColor: _borderColor,
              focusedBorderColor: _borderColor,
              focusedBorderWidth: 1.2,
              enabledBorderWidth: 1.2,
              prefix: Icon(Icons.phone, color: Colors.green, size: 20),
            ),
            const SizedBox(height: 12),

            // Message field
            CustomTextFormField(
              controller: _messageController,
              hintText: 'Message',
              maxLength: 200,
              keyboardType: TextInputType.multiline,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              borderRadius: _borderRadius,
              enabledBorderColor: _borderColor,
              focusedBorderColor: _borderColor,
              focusedBorderWidth: 1.2,
              enabledBorderWidth: 1.2,
            ),
            const SizedBox(height: 16),

            // Ringtone section
            _buildSectionTile(
              leading: const Icon(Icons.music_note, color: Colors.grey),
              title: const Text('Ringtone'),
              trailing: const Text('Default',
                  style: TextStyle(color: Colors.black54)),
              onTap: () {/* pick ringtone */},
            ),

            // Add Voice section
            _buildSectionTile(
              leading: const Icon(Icons.add_circle, color: Colors.green),
              title: Text(
                  _selectedVoicePath != null ? _voiceFileName : 'add voice'),
              trailing: _isPickingFile
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(
                      Icons.graphic_eq, // Built-in waveform icon
                      color: Colors.grey,
                      size: 24,
                    ),
              onTap: _pickVoiceFile, // Trigger file picker
              enabled: !_isPickingFile, // Disable while picking
            ),

            // Add Theme section
            _buildSectionTile(
              leading: const Icon(Icons.add_circle, color: Colors.green),
              title: const Text('add theme'),
              trailing: const Icon(Icons.palette, color: Colors.grey),
              onTap: () {/* add theme */},
            ),

            const SizedBox(height: 24),

            // Save button
            AppButton(
              text: 'Save Contact',
              onPressed: _onSave,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              borderRadius: 12,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
