import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
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
  final String? callerPhoto;
  final String? callerVoice; // Add this parameter

  const CallReceivedScreen({
    Key? key,
    required this.callerName,
    this.callerPhoto,
    this.callerVoice, // Add this parameter
  }) : super(key: key);

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

    // Add debug prints to see what's being received
    print('CallReceivedScreen - Caller Name: ${widget.callerName}');
    print('CallReceivedScreen - Caller Photo: ${widget.callerPhoto}');

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

    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);

      // Use contact's voice if available, otherwise use default
      if (widget.callerVoice != null && widget.callerVoice!.isNotEmpty) {
        print(
            'Attempting to download and play contact voice: ${widget.callerVoice}');

        try {
          // Download the audio file
          final audioFile = await _downloadAudioFile(widget.callerVoice!);
          if (audioFile != null) {
            await _audioPlayer.play(DeviceFileSource(audioFile.path));
            print('Successfully started playing downloaded contact voice');
          } else {
            await _playDefaultAudio();
          }
        } catch (downloadError) {
          print('Download audio failed: $downloadError');
          await _playDefaultAudio();
        }
      } else {
        print('No contact voice provided, playing default audio');
        await _playDefaultAudio();
      }
    } catch (e) {
      print('Error in audio initialization: $e');
      await _playDefaultAudio();
    }
  }

  Future<File?> _downloadAudioFile(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final fileName = url.split('/').last;
        final file = File('${tempDir.path}/$fileName');
        await file.writeAsBytes(response.bodyBytes);
        print('Audio file downloaded to: ${file.path}');
        return file;
      }
    } catch (e) {
      print('Error downloading audio file: $e');
    }
    return null;
  }

  Future<void> _playDefaultAudio() async {
    try {
      print('Playing default audio: sounds/mom.mp3');
      await _audioPlayer.play(AssetSource('sounds/mom.mp3'));
      print('Successfully started playing default audio');
    } catch (fallbackError) {
      print('Error playing fallback audio: $fallbackError');
    }
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
                  child: widget.callerPhoto != null &&
                          widget.callerPhoto!.isNotEmpty
                      ? ClipOval(
                          child: Image.network(
                            widget.callerPhoto!,
                            width: 100.r,
                            height: 100.r,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              print('Error loading image: $error');
                              return Container(
                                width: 100.r,
                                height: 100.r,
                                color: homeController.selectedIconColor.value,
                                child: Text(
                                  widget.callerName.isNotEmpty
                                      ? widget.callerName[0]
                                      : 'U',
                                  style: TextStyle(
                                    fontSize: 48.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 100.r,
                                height: 100.r,
                                color: homeController.selectedIconColor.value,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Text(
                          widget.callerName.isNotEmpty
                              ? widget.callerName[0]
                              : 'U',
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
