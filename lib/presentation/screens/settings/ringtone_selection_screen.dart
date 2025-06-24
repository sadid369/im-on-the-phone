import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

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
        title: Text('Ringtone', style: TextStyle(fontSize: 18.sp)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: ListView.separated(
          itemCount: ringtones.length,
          separatorBuilder: (context, index) => Gap(8.h),
          itemBuilder: (context, index) {
            final ringtone = ringtones[index];
            return ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              title: Text(
                ringtone,
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: selectedRingtone == ringtone
                  ? Icon(Icons.check, color: Colors.green, size: 22.r)
                  : null,
              onTap: () {
                setState(() {
                  selectedRingtone = ringtone;
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              tileColor: selectedRingtone == ringtone
                  ? Colors.green.withOpacity(0.08)
                  : Colors.transparent,
            );
          },
        ),
      ),
    );
  }
}
