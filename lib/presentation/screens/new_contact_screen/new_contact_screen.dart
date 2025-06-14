import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

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

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _onSave() {
    // TODO: Implement save logic
    print('First: ${_firstNameController.text}, '
        'Last: ${_lastNameController.text}, '
        'Msg: ${_messageController.text}');
  }

  Widget _buildSectionTile({
    required Widget leading,
    Widget? title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 1.2),
          borderRadius: BorderRadius.circular(12),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: GestureDetector(
      //     onTap: () => context.pop(),
      //     child: Text('Cancel', style: TextStyle(color: Colors.teal)),
      //   ),
      //   centerTitle: true,
      //   title: const Text(
      //     'New Contact',
      //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      //   ),
      //   actions: [
      //     TextButton(
      //       onPressed: _onSave,
      //       child: const Text('Done', style: TextStyle(color: Colors.black)),
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            // ===== custom “AppBar” =====
            SafeArea(
              bottom: false,
              child: Container(
                height: topPadding + 56, // status bar + toolbar
                child: Row(
                  children: [
                    // Cancel
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

                    // Title
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

                    // Done
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
            const SizedBox(height: 20),

            // First & Last name fields
            CustomTextFormField(
              controller: _firstNameController,
              hintText: 'First name',
            ),
            const SizedBox(height: 12),
            CustomTextFormField(
              controller: _lastNameController,
              hintText: 'Last name',
            ),
            const SizedBox(height: 12),

            // Message multiline
            CustomTextFormField(
              controller: _messageController,
              hintText: 'Message',
              maxLength: 200,
              keyboardType: TextInputType.multiline,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            ),
            const SizedBox(height: 16),

            // Add Phone
            _buildSectionTile(
              leading: const Icon(Icons.add_circle, color: Colors.green),
              title: const Text('add phone'),
              onTap: () {/* add phone action */},
            ),

            // Ringtone
            _buildSectionTile(
              leading: const Icon(Icons.music_note, color: Colors.grey),
              title: const Text('Ringtone'),
              trailing: const Text('Default',
                  style: TextStyle(color: Colors.black54)),
              onTap: () {/* pick ringtone */},
            ),

            // Add Voice
            _buildSectionTile(
              leading: const Icon(Icons.add_circle, color: Colors.green),
              title: const Text('add voice'),
              trailing: SvgPicture.asset(
                'assets/icons/waveform.svg',
                width: 24,
                height: 24,
                color: Colors.grey,
              ),
              onTap: () {/* add voice */},
            ),

            // Add Theme
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
