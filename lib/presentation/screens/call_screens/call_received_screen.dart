
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:groc_shopy/helper/extension/base_extension.dart';
import 'package:groc_shopy/presentation/screens/home/controller/home_controller.dart';
import 'package:groc_shopy/utils/static_strings/static_strings.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../../core/routes/route_path.dart';

// Platform channel for audio routing
class AudioRouteController {
  static const MethodChannel _channel = MethodChannel('audio_route');

  // Route audio to earpiece
  static Future<void> routeToEarpiece() async {
    await _channel.invokeMethod('routeToEarpiece');
  }

  // Lower the device media volume (Android only)
  static Future<void> setLowVolume() async {
    await _channel.invokeMethod('setLowVolume');
  }
}

class CallReceivedScreen extends StatefulWidget {
  final String callerName;

  const CallReceivedScreen({Key? key, required this.callerName})
      : super(key: key);

  @override
  State<CallReceivedScreen> createState() => _CallReceivedScreenState();
}

class _CallReceivedScreenState extends State<CallReceivedScreen> {
  bool isPressLoudSpeaker = false;
  late Stopwatch _stopwatch;
  late String _timeString;
  final HomeController homeController = Get.find<HomeController>();
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();

    _stopwatch = Stopwatch();
    _timeString = '0:00';
    _stopwatch.start();
    _updateTime();

    _audioPlayer = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    // Ensure audio is routed to earpiece
    await AudioRouteController.routeToEarpiece();

    // Small delay to ensure routing is applied
    await Future.delayed(Duration(milliseconds: 500));

    await _audioPlayer.play(AssetSource('sounds/mom.mp3'));
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> _toggleSpeaker() async {
    setState(() {
      isPressLoudSpeaker = !isPressLoudSpeaker;
    });
    // For now, keep audio on earpiece (modify later if needed)
    await AudioRouteController.routeToEarpiece();
  }

  void _updateTime() {
    if (_stopwatch.isRunning) {
      setState(() {
        int minutes = _stopwatch.elapsed.inMinutes;
        int seconds = _stopwatch.elapsed.inSeconds % 60;
        _timeString = '$minutes:${seconds.toString().padLeft(2, '0')}';
      });

      Future.delayed(const Duration(seconds: 1), _updateTime);
    }
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Gap(20.h),
            // Avatar and name/duration
            Column(
              children: [
                CircleAvatar(
                  radius: 50.r,
                  backgroundColor: homeController.selectedIconColor.value,
                  child: Text(
                    widget.callerName[0],
                    style: TextStyle(
                      fontSize: 48.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Gap(16.h),
                Text(
                  widget.callerName,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(8.h),
                Text(
                  _timeString,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            // Buttons grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _CallOption(
                        icon: Icons.mic_off,
                        label: AppStrings.mute,
                      ),
                      _CallOption(
                        icon: Icons.dialpad,
                        label: AppStrings.keyboard,
                      ),
                      GestureDetector(
                        onTap: _toggleSpeaker,
                        child: _CallOption(
                          icon: isPressLoudSpeaker
                              ? Icons.volume_up
                              : Icons.volume_off_sharp,
                          label: isPressLoudSpeaker
                              ? AppStrings.speaker
                              : AppStrings.sound,
                          color: isPressLoudSpeaker ? Colors.white54 : null,
                        ),
                      ),
                    ],
                  ),
                  Gap(32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      _CallOption(
                        icon: Icons.add_call,
                        label: AppStrings.addCall,
                      ),
                      _CallOption(
                        icon: Icons.videocam,
                        label: AppStrings.video,
                      ),
                      _CallOption(
                        icon: Icons.person_add,
                        label: AppStrings.callers,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Hang up button
            Padding(
              padding: EdgeInsets.only(bottom: 32.h),
              child: FloatingActionButton(
                elevation: 0,
                shape: const CircleBorder(),
                backgroundColor: Colors.red,
                onPressed: () {
                  _stopwatch.stop();
                  context.go(RoutePath.home.addBasePath);
                },
                child: Icon(
                  Icons.call_end,
                  size: 32.w,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CallOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;

  const _CallOption(
      {Key? key, required this.icon, required this.label, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
              color: color ?? const Color(0xff898989),
              shape: BoxShape.circle,
              border: color == null
                  ? null
                  : Border.all(color: Colors.black.withOpacity(0.2))),
          child: Icon(
            icon,
            size: 28.w,
            color: color == null ? Colors.white : Colors.black,
          ),
        ),
        Gap(8.h),
        Text(
          label.tr,
          style: TextStyle(fontSize: 14.sp),
        ),
      ],
    );
  }
}
