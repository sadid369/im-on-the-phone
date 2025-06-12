// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:groc_shopy/helper/extension/base_extension.dart';
// import 'package:groc_shopy/presentation/screens/main/main_screen.dart';
// import 'package:groc_shopy/presentation/screens/profile/profile_screen.dart';
// import 'package:groc_shopy/presentation/screens/auth/admin_signup_screen%20.dart';
// import 'package:groc_shopy/presentation/screens/auth/login_screen.dart';
// import 'package:groc_shopy/presentation/screens/auth/forgot_password_screen.dart';
// import 'package:groc_shopy/presentation/screens/auth/password_reset_confirm_screen.dart';
// import 'package:groc_shopy/presentation/screens/auth/set_new_password_screen.dart';
// import 'package:groc_shopy/presentation/screens/auth/update_password_success_screen.dart';
// import 'package:groc_shopy/presentation/screens/auth/verify_code_screen.dart';
// import 'package:groc_shopy/presentation/screens/home/home_screen.dart';
// import 'package:groc_shopy/presentation/screens/scan/scan_screen.dart';
// import 'package:groc_shopy/presentation/screens/transaction_history/transaction_history_screen.dart';
// import 'package:groc_shopy/presentation/widgets/payment_modal/payment_modal.dart';
// import 'package:groc_shopy/presentation/widgets/paypal/paypal.dart';
// import 'package:groc_shopy/presentation/widgets/subscription_modal/subscription_modal.dart';

// import '../../presentation/screens/report/report_screen.dart';
// import '../../presentation/screens/scannedItemsScreen/scanned_items_screen.dart';
// import '../../presentation/screens/splash_screen/splash_screen.dart';
// import '../../presentation/widgets/error_screen/error_screen.dart';
// import '../../presentation/widgets/subscription_plans/subscription_plans.dart';
// import 'route_observer.dart';
// import 'route_path.dart';

// // Custom Search Screen (since you don't have one in your routes)
// class SearchScreen extends StatelessWidget {
//   const SearchScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Search'),
//         backgroundColor: const Color(0xFFFFD54F),
//       ),
//       body: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.search,
//               size: 80,
//               color: Color(0xFFFFD54F),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Search Screen',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               'Find what you\'re looking for!',
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Custom Settings Screen (using your existing profile screen or create new one)
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Settings'),
//         backgroundColor: const Color(0xFFFFD54F),
//       ),
//       body: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.settings,
//               size: 80,
//               color: Color(0xFFFFD54F),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Settings Screen',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               'Configure your preferences',
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AppRouter {
//   static final GoRouter initRoute = GoRouter(
//     initialLocation: RoutePath.splashScreen.addBasePath,
//     debugLogDiagnostics: true,
//     routes: [
//       ///======================= Splash Route =======================
//       GoRoute(
//         name: RoutePath.splashScreen,
//         path: RoutePath.splashScreen.addBasePath,
//         builder: (context, state) => const SplashScreen(),
//       ),

//       ///======================= Error Route =======================
//       GoRoute(
//         name: RoutePath.errorScreen,
//         path: RoutePath.errorScreen.addBasePath,
//         builder: (context, state) => const ErrorPage(),
//       ),

//       ///======================= Auth Routes =======================
//       GoRoute(
//         name: RoutePath.login,
//         path: RoutePath.login.addBasePath,
//         builder: (context, state) => LoginScreen(),
//       ),
//       GoRoute(
//         name: RoutePath.adminSignUp,
//         path: RoutePath.adminSignUp.addBasePath,
//         builder: (context, state) => const AdminSignUpScreen(),
//       ),
//       GoRoute(
//         name: RoutePath.forgotPass,
//         path: RoutePath.forgotPass.addBasePath,
//         builder: (context, state) => ForgotPasswordScreen(),
//       ),
//       GoRoute(
//         name: RoutePath.resetPassConfirm,
//         path: RoutePath.resetPassConfirm.addBasePath,
//         builder: (context, state) => const PasswordResetConfirmScreen(),
//       ),
//       GoRoute(
//         name: RoutePath.resetPass,
//         path: RoutePath.resetPass.addBasePath,
//         builder: (context, state) => const SetPasswordScreen(),
//       ),
//       GoRoute(
//         name: RoutePath.verification,
//         path: RoutePath.verification.addBasePath,
//         builder: (context, state) => const CodeVerificationScreen(),
//       ),
//       GoRoute(
//         name: RoutePath.resetPasswordSuccess,
//         path: RoutePath.resetPasswordSuccess.addBasePath,
//         builder: (context, state) => UpdatePasswordSuccessScreen(),
//       ),

//       ///======================= Other Routes =======================
//       GoRoute(
//         name: RoutePath.subscription,
//         path: RoutePath.subscription.addBasePath,
//         builder: (context, state) => const SubscriptionModal(),
//       ),
//       GoRoute(
//         name: RoutePath.paymentModal,
//         path: RoutePath.paymentModal.addBasePath,
//         builder: (context, state) => const PaymentModal(),
//       ),
//       GoRoute(
//         name: RoutePath.paypal,
//         path: RoutePath.paypal.addBasePath,
//         builder: (context, state) {
//           final plan = state.extra as SubscriptionPlan?;
//           if (plan == null) {
//             return const Scaffold(
//               body: Center(child: Text('No subscription plan provided')),
//             );
//           }
//           return PaypalPage(plan: plan);
//         },
//       ),
//       GoRoute(
//         name: RoutePath.transactionHistory,
//         path: RoutePath.transactionHistory.addBasePath,
//         builder: (context, state) => TransactionHistoryScreen(),
//       ),
//       GoRoute(
//         name: RoutePath.scannedItemsScreen,
//         path: RoutePath.scannedItemsScreen.addBasePath,
//         builder: (context, state) {
//           final image = state.extra as File?;
//           return ScannedItemsScreen(image: image);
//         },
//       ),
//       GoRoute(
//         name: RoutePath.report,
//         path: RoutePath.report.addBasePath,
//         builder: (context, state) => ReportScreen(),
//       ),

//       ///======================= Bottom Navigation Shell =======================
//       StatefulShellRoute.indexedStack(
//         builder: (context, state, navigationShell) {
//           return MainScreen(navigationShell: navigationShell);
//         },
//         branches: [
//           // Home Branch
//           StatefulShellBranch(
//             routes: [
//               GoRoute(
//                 name: RoutePath.home,
//                 path: RoutePath.home.addBasePath,
//                 builder: (context, state) => HomeScreen(),
//               ),
//             ],
//           ),
//           // Search Branch (new)
//           StatefulShellBranch(
//             routes: [
//               GoRoute(
//                 name: 'search', // Add this to your RoutePath class
//                 path: '/search', // Add this to your RoutePath class
//                 builder: (context, state) => const SearchScreen(),
//               ),
//             ],
//           ),
//           // Settings Branch (or Profile)
//           StatefulShellBranch(
//             routes: [
//               GoRoute(
//                 name: RoutePath.profile,
//                 path: RoutePath.profile.addBasePath,
//                 builder: (context, state) => ProfileScreen(),
//                 // You can add sub-routes here if needed
//                 routes: [
//                   GoRoute(
//                     name: 'settings', // Add this to your RoutePath class
//                     path: '/settings', // Add this to your RoutePath class  
//                     builder: (context, state) => const SettingsScreen(),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     ],
//     observers: [routeObserver],
//   );

//   static GoRouter get route => initRoute;
// }

// // Updated MainScreen to work with StatefulNavigationShell
// class MainScreenWithBottomNav extends StatelessWidget {
//   final StatefulNavigationShell navigationShell;

//   const MainScreenWithBottomNav({
//     super.key,
//     required this.navigationShell,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: navigationShell,
//       bottomNavigationBar: CustomBottomNavBar(
//         selectedIndex: navigationShell.currentIndex,
//         onTap: (index) => _onTabTapped(context, index),
//         // Custom icons and labels for your 3-tab navigation
//         icons: const [
//           'assets/icons/home.svg',
//           'assets/icons/search.svg', 
//           'assets/icons/settings.svg',
//         ],
//         labels: const [
//           'Home',
//           'Search',
//           'Settings',
//         ],
//       ),
//     );
//   }

//   void _onTabTapped(BuildContext context, int index) {
//     navigationShell.goBranch(
//       index,
//       initialLocation: index == navigationShell.currentIndex,
//     );
//   }
// }

// // Update your RoutePath class to include the new routes
// class RoutePathExtension {
//   static const String search = 'search';
//   static const String settings = 'settings';
// }

// // Custom Bottom Navigation Bar Widget
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class CustomBottomNavBar extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onTap;
//   final List<String> icons;
//   final List<String> labels;

//   const CustomBottomNavBar({
//     super.key,
//     required this.selectedIndex,
//     required this.onTap,
//     this.icons = const [
//       'assets/icons/home.svg',
//       'assets/icons/search.svg', 
//       'assets/icons/settings.svg',
//     ],
//     this.labels = const [
//       'Home',
//       'Search',
//       'Settings',
//     ],
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Active/inactive colors matching your design
//     const activeColor = Color(0xFFFFD54F);
//     const inactiveColor = Color(0xFFC4C4C4);
//     const backgroundColor = Color(0xff282f291a);

//     return Container(
//       height: 70.h,
//       decoration: BoxDecoration(
//         color: backgroundColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(50.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, -5),
//           ),
//         ],
//       ),
//       margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: List.generate(icons.length, (index) {
//           bool isSelected = selectedIndex == index;

//           return GestureDetector(
//             onTap: () => onTap(index),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               curve: Curves.easeInOut,
//               width: isSelected ? 120.w : 60.w,
//               height: 50.h,
//               decoration: BoxDecoration(
//                 color: isSelected ? activeColor : Colors.transparent,
//                 borderRadius: BorderRadius.circular(25.r),
//               ),
//               alignment: Alignment.center,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Icon with color change based on selection
//                   SvgPicture.asset(
//                     icons[index],
//                     width: 24.w,
//                     height: 24.h,
//                     colorFilter: ColorFilter.mode(
//                       isSelected ? Colors.black.withOpacity(0.8) : inactiveColor,
//                       BlendMode.srcIn,
//                     ),
//                   ),
//                   // Animated label that appears when selected
//                   if (isSelected)
//                     AnimatedOpacity(
//                       opacity: isSelected ? 1.0 : 0.0,
//                       duration: const Duration(milliseconds: 200),
//                       curve: Curves.easeIn,
//                       child: Padding(
//                         padding: EdgeInsets.only(left: 8.w),
//                         child: Text(
//                           labels[index],
//                           style: TextStyle(
//                             fontSize: 12.sp,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black.withOpacity(0.8),
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }