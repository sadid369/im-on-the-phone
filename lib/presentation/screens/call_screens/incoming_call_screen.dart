import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:groc_shopy/core/custom_assets/assets.gen.dart';
import 'package:groc_shopy/core/routes/route_path.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart'; // Add this
import 'dart:async';
import 'package:groc_shopy/utils/static_strings/static_strings.dart';
import 'package:groc_shopy/presentation/screens/home/controller/home_controller.dart'; // Add this import

class IncomingCallScreen extends StatefulWidget {
  final String callerName;
  final String time;
  final String callDuration;
  final String? callerPhoto; // Add this parameter
  final String? callerVoice; // Add this parameter

  const IncomingCallScreen({
    Key? key,
    required this.callerName,
    required this.time,
    required this.callDuration,
    this.callerPhoto, // Add this parameter
    this.callerVoice, // Add this parameter
  }) : super(key: key);

  @override
  State<IncomingCallScreen> createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _dot1Animation;
  late Animation<double> _dot2Animation;
  late Animation<double> _dot3Animation;
  Timer? _ringtoneTimer;
  bool _isRingtoneActive = false;
  final HomeController homeController = Get.find<HomeController>(); // Add this

  @override
  void initState() {
    super.initState();

    // Add debug prints to see what's being received
    print('IncomingCallScreen - Caller Name: ${widget.callerName}');
    print('IncomingCallScreen - Caller Photo: ${widget.callerPhoto}');

    // Start playing ringtone and vibration
    _playRingtone();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _dot1Animation = _createDotAnimation(begin: 0.0, end: 0.33);
    _dot2Animation = _createDotAnimation(begin: 0.33, end: 0.66);
    _dot3Animation = _createDotAnimation(begin: 0.66, end: 1.0);
  }

  void _playRingtone() async {
    if (_isRingtoneActive) return;

    _isRingtoneActive = true;

    try {
      // Method 1: Play actual ringtone
      await FlutterRingtonePlayer().play(
        android: AndroidSounds.ringtone,
        ios: IosSounds.electronic,
        looping: true, // Set to true for continuous ringing
        volume: 1.0,
        asAlarm: false,
      );

      // Method 2: Add vibration pattern for extra effect
      _startVibrationPattern();
    } catch (e) {
      print('Error playing ringtone: $e');
      // Fallback to system sounds if ringtone fails
      _playSystemSoundsFallback();
    }
  }

  void _startVibrationPattern() {
    // Create a vibration pattern that mimics phone ring with heavy vibration
    _ringtoneTimer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (mounted && _isRingtoneActive) {
        // Main heavy burst
        HapticFeedback.heavyImpact();

        // Optional: Add a medium burst after 200ms
        Timer(Duration(milliseconds: 200), () {
          if (mounted && _isRingtoneActive) {
            HapticFeedback.mediumImpact();
          }
        });

        // Optional: Add a light burst after 400ms
        Timer(Duration(milliseconds: 400), () {
          if (mounted && _isRingtoneActive) {
            HapticFeedback.lightImpact();
          }
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _playSystemSoundsFallback() {
    // Fallback method using system sounds
    SystemSound.play(SystemSoundType.alert);

    _ringtoneTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted && _isRingtoneActive) {
        SystemSound.play(SystemSoundType.alert);
      } else {
        timer.cancel();
      }
    });
  }

  void _stopRingtone() async {
    _isRingtoneActive = false;

    try {
      // Stop the ringtone - use instance method
      await FlutterRingtonePlayer().stop();
    } catch (e) {
      print('Error stopping ringtone: $e');
    }

    // Cancel timers
    _ringtoneTimer?.cancel();
    _ringtoneTimer = null;
  }

  @override
  void dispose() {
    _controller.dispose();
    _stopRingtone();
    super.dispose();
  }

  Animation<double> _createDotAnimation(
      {required double begin, required double end}) {
    return TweenSequence<double>([
      TweenSequenceItem(
        weight: 0.33,
        tween: Tween(begin: 0.3, end: 1.0),
      ),
      TweenSequenceItem(
        weight: 0.33,
        tween: Tween(begin: 1.0, end: 0.3),
      ),
      TweenSequenceItem(
        weight: 0.33,
        tween: Tween(begin: 0.3, end: 1.0),
      ),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(begin, end, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 50.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Caller information
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: homeController.selectedIconColor.value,
                    radius: 40.r,
                    child: widget.callerPhoto != null &&
                            widget.callerPhoto!.isNotEmpty
                        ? ClipOval(
                            child: Image.network(
                              widget.callerPhoto!,
                              width: 80.r,
                              height: 80.r,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                print('Error loading image: $error');
                                return Container(
                                  width: 80.r,
                                  height: 80.r,
                                  color: homeController.selectedIconColor.value,
                                  child: Text(
                                    widget.callerName.isNotEmpty
                                        ? widget.callerName[0]
                                        : 'U',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 38.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  width: 80.r,
                                  height: 80.r,
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
                              color: Colors.white,
                              fontSize: 38.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  Gap(16.h),
                  Text(
                    widget.callerName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Gap(20.w),
                      Text(
                        AppStrings.calling.tr, // <-- Add .tr here
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                        ),
                      ),
                      const Gap(4),
                      _buildAnimatedDot(_dot1Animation),
                      _buildAnimatedDot(_dot2Animation),
                      _buildAnimatedDot(_dot3Animation),
                    ],
                  ),
                ],
              ),

              // Action buttons
              Padding(
                padding: EdgeInsets.only(
                    bottom: 0.h, left: 20.w, right: 20.w), // Reduced padding
                child: Column(
                  children: [
                    // Top row buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: _buildActionButton(
                            text: AppStrings.remindMe.tr,
                            icon: Assets.icons.remindMe.path,
                            onPressed: () {},
                          ),
                        ),
                        Gap(10.w),
                        Flexible(
                          child: _buildActionButton(
                            text: AppStrings.message.tr,
                            icon: Assets.icons.message.path,
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),

                    Gap(40.h),

                    // Bottom row buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCallButton(
                          text: AppStrings.decline.tr, // <-- Add .tr here
                          color: Colors.red,
                          onPressed: () => context.pop(),
                          isAccept: false,
                        ),
                        Gap(120.w),
                        _buildCallButton(
                          text: AppStrings.accept.tr, // <-- Add .tr here
                          color: const Color(0xff7FEB12),
                          onPressed: () {
                            context.pushNamed(
                              RoutePath.callReceivedScreen,
                              extra: {
                                'callerName': widget.callerName,
                                'callerPhoto':
                                    widget.callerPhoto, // Add this line
                                'callerVoice':
                                    widget.callerVoice, // Add this line
                              },
                            );
                          },
                          isAccept: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedDot(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: Text(
            '.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton({
    required String text,
    required String icon,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      // Wrap with GestureDetector
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              width: 24.w,
              height: 24.h,
            ),
            Gap(8.w),
            Text(
              text.tr, // <-- Add .tr here for button label
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallButton({
    required String text,
    required Color color,
    required VoidCallback onPressed,
    required bool isAccept,
  }) {
    return Column(
      children: [
        Container(
          width: 72.w,
          height: 72.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              isAccept ? Icons.call_outlined : Icons.call_end_outlined,
              color: Colors.white,
              size: 32.r,
            ),
            onPressed: () {
              _stopRingtone(); // Stop ringtone when button is pressed
              onPressed();
            },
            padding: EdgeInsets.zero,
          ),
        ),
        Gap(8.h),
        Text(
          text.tr, // <-- Add .tr here for button label
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}
