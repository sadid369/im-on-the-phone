import 'package:flutter/material.dart';
import 'package:groc_shopy/utils/app_colors/app_colors.dart';

import '../../widgets/custom_bottons/custom_button/app_button.dart';
// Adjust the import based on your project structure

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Color Picker
            Text('Choose your icon color', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Row(
              children: [
                ColorCircle(color: Colors.red),
                ColorCircle(color: Colors.orange),
                ColorCircle(color: Colors.green),
                ColorCircle(color: Colors.cyan),
                ColorCircle(color: Colors.purple),
                ColorCircle(color: Colors.pink),
              ],
            ),
            SizedBox(height: 16),

            // Language Picker
            Text('Choose your language', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Row(
              children: [
                ChoiceChip(
                  label: Text('English'),
                  selected: true,
                  onSelected: (selected) {},
                ),
                SizedBox(width: 8),
                ChoiceChip(
                  label: Text('Spanish'),
                  selected: false,
                  onSelected: (selected) {},
                ),
              ],
            ),
            SizedBox(height: 16),

            // Theme Picker
            Text('Switch app theme:', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Row(
              children: [
                ChoiceChip(
                  label: Text('Light'),
                  selected: true,
                  onSelected: (selected) {},
                ),
                SizedBox(width: 8),
                ChoiceChip(
                  label: Text('Pastel'),
                  selected: false,
                  onSelected: (selected) {},
                ),
                SizedBox(width: 8),
                ChoiceChip(
                  label: Text('Dark'),
                  selected: false,
                  onSelected: (selected) {},
                ),
              ],
            ),
            SizedBox(height: 16),

            // Ringtone Picker
            Text('Ringtone', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Row(
              children: [
                ChoiceChip(
                  label: Text('Default'),
                  selected: true,
                  onSelected: (selected) {},
                ),
                SizedBox(width: 8),
                ChoiceChip(
                  label: Text('Quad'),
                  selected: false,
                  onSelected: (selected) {},
                ),
                SizedBox(width: 8),
                ChoiceChip(
                  label: Text('Radial'),
                  selected: false,
                  onSelected: (selected) {},
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                ),
              ],
            ),
            Spacer(),

            // Buttons
            Row(
              children: [
                AppButton(
                  text: 'Reset to Default',
                  onPressed: () {},
                  width: 150,
                  textStyle: TextStyle(color: Colors.black),
                ),
                SizedBox(width: 16),
                AppButton(
                  text: 'Save Changes',
                  onPressed: () {},
                  width: 150,
                  backgroundColor: Colors.blue,
                  textStyle: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ColorCircle extends StatelessWidget {
  final Color color;

  const ColorCircle({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
