import 'package:flutter/material.dart';

class RingtoneSelectionScreen extends StatefulWidget {
  @override
  _RingtoneSelectionScreenState createState() =>
      _RingtoneSelectionScreenState();
}

class _RingtoneSelectionScreenState extends State<RingtoneSelectionScreen> {
  // List of ringtone names
  final List<String> ringtones = [
    'Default',
    'Atlantis',
    'Candy',
    'Cowboy',
    'Digital universe',
    'Fairyland',
    'Fantasy',
    'Glee',
    'Ice latte',
    'Kung fu',
    'Lollipop'
  ];

  // Variable to store selected ringtone
  String? selectedRingtone = 'Default';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ringtone'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: ringtones.map((ringtone) {
            return ListTile(
              title: Text(ringtone),
              trailing: selectedRingtone == ringtone
                  ? Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () {
                setState(() {
                  selectedRingtone = ringtone;
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
