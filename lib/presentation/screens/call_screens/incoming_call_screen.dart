// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gap/gap.dart';
// import 'package:go_router/go_router.dart';
// import 'package:groc_shopy/core/custom_assets/assets.gen.dart';

// class IncomingCallScreen extends StatefulWidget {
//   final String callerName;
//   final String time;
//   final String callDuration;

//   const IncomingCallScreen({
//     Key? key,
//     required this.callerName,
//     required this.time,
//     required this.callDuration,
//   }) : super(key: key);

//   @override
//   State<IncomingCallScreen> createState() => _IncomingCallScreenState();
// }

// class _IncomingCallScreenState extends State<IncomingCallScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _dot1Animation;
//   late Animation<double> _dot2Animation;
//   late Animation<double> _dot3Animation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1500),
//     )..repeat();

//     // Create staggered animations for each dot
//     _dot1Animation = _createDotAnimation(begin: 0.0, end: 0.33);
//     _dot2Animation = _createDotAnimation(begin: 0.33, end: 0.66);
//     _dot3Animation = _createDotAnimation(begin: 0.66, end: 1.0);
//   }

//   Animation<double> _createDotAnimation({required double begin, required double end}) {
//     return TweenSequence<double>([
//       TweenSequenceItem(weight: 0.01, tween: Tween(begin: 0.3, end: 1.0), // Fade in
//       TweenSequenceItem(weight: 0.03, tween: Tween(begin: 1.0, end: 0.3),
//        // Fade out
//     ]).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Interval(begin, end, curve: Curves.easeInOut),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             // Caller information
//             Column(
//               children: [
//                 CircleAvatar(
//                   backgroundColor: const Color(0xffC9867B),
//                   radius: 40.r,
//                   child: Text(
//                     widget.callerName[0],
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 38.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 const Gap(16),
//                 Text(
//                   widget.callerName,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 32.sp,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Gap(16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Calling',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18.sp,
//                       ),
//                     ),
//                     const Gap(4),
//                     _buildAnimatedDot(_dot1Animation),
//                     _buildAnimatedDot(_dot2Animation),
//                     _buildAnimatedDot(_dot3Animation),
//                   ],
//                 ),
//               ],
//             ),

//             // Action buttons
//             Padding(
//               padding: EdgeInsets.only(bottom: 40.h),
//               child: Column(
//                 children: [
//                   // Top row buttons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _buildActionButton(
//                         text: 'Remind me',
//                         icon: Assets.icons.remindMe.path,
//                         onPressed: () {},
//                       ),
//                       Gap(120.w),
//                       _buildActionButton(
//                         text: 'Message',
//                         icon: Assets.icons.message.path,
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),

//                   const Gap(40),

//                   // Bottom row buttons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _buildCallButton(
//                         text: 'Decline',
//                         color: Colors.red,
//                         onPressed: () => context.pop(),
//                         isAccept: false,
//                       ),
//                       Gap(120.w),
//                       _buildCallButton(
//                         text: 'Accept',
//                         color: Colors.green,
//                         onPressed: () {},
//                         isAccept: true,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAnimatedDot(Animation<double> animation) {
//     return AnimatedBuilder(
//       animation: animation,
//       builder: (context, child) {
//         return Opacity(
//           opacity: animation.value,
//           child: const Text(
//             '.',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 18,
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildActionButton({
//     required String text,
//     required String icon,
//     required VoidCallback onPressed,
//   }) {
//     return Row(
//       children: [
//         Gap(10.w),
//         SvgPicture.asset(
//           icon,
//           width: 24.w,
//           height: 24.h,
//         ),
//         Gap(8.w),
//         Text(
//           text,
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 16.sp,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCallButton({
//     required String text,
//     required Color color,
//     required VoidCallback onPressed,
//     required bool isAccept,
//   }) {
//     return Column(
//       children: [
//         Container(
//           width: 72.w,
//           height: 72.h,
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle,
//           ),
//           child: IconButton(
//             icon: Icon(
//               isAccept ? Icons.call : Icons.call_end,
//               color: Colors.white,
//               size: 32.sp,
//             ),
//             onPressed: onPressed,
//             padding: EdgeInsets.zero,
//           ),
//         ),
//         Gap(8.h),
//         Text(
//           text,
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 16.sp,
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:groc_shopy/core/custom_assets/assets.gen.dart';
import 'package:groc_shopy/core/routes/route_path.dart';

class IncomingCallScreen extends StatefulWidget {
  final String callerName;
  final String time;
  final String callDuration;

  const IncomingCallScreen({
    Key? key,
    required this.callerName,
    required this.time,
    required this.callDuration,
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

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    // Initialize animations after the controller is set up
    _dot1Animation = _createDotAnimation(begin: 0.0, end: 0.33);
    _dot2Animation = _createDotAnimation(begin: 0.33, end: 0.66);
    _dot3Animation = _createDotAnimation(begin: 0.66, end: 1.0);
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 50.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Caller information
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xffC9867B),
                    radius: 40.r,
                    child: Text(
                      widget.callerName[0],
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
                        'Calling',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                        ),
                      ),
                      const Gap(4),
                      _buildAnimatedDot(_dot1Animation),
                      _buildAnimatedDot(_dot2Animation),
                      _buildAnimatedDot(_dot3Animation),
                      _buildAnimatedDot(_dot3Animation),
                    ],
                  ),
                ],
              ),

              // Action buttons
              Padding(
                padding: EdgeInsets.only(bottom: 0.h, left: 50.w, right: 50.w),
                child: Column(
                  children: [
                    // Top row buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildActionButton(
                          text: 'Remind me',
                          icon: Assets.icons.remindMe.path,
                          onPressed: () {},
                        ),
                        Expanded(child: Gap(10.w)), // Added Expanded
                        _buildActionButton(
                          text: 'Message',
                          icon: Assets.icons.message.path,
                          onPressed: () {},
                        ),
                      ],
                    ),

                    Gap(37.h),

                    // Bottom row buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCallButton(
                          text: 'Decline',
                          color: Colors.red,
                          onPressed: () => context.pop(),
                          isAccept: false,
                        ),
                        Expanded(child: Gap(10.w)), // Added Expanded
                        _buildCallButton(
                          text: 'Accept',
                          color: Color(0xff7FEB12),
                          onPressed: () {
                            context.pushNamed(RoutePath.callReceivedScreen);
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
          child: const Text(
            '.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
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
    return Row(
      children: [
        Gap(10.w),
        SvgPicture.asset(
          icon,
          width: 18.w,
          height: 18.h,
        ),
        Gap(8.w),
        Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
          ),
        ),
      ],
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
              size: 32.sp,
            ),
            onPressed: onPressed,
            padding: EdgeInsets.zero,
          ),
        ),
        Gap(8.h),
        Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}
