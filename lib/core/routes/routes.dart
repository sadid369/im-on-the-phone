import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:groc_shopy/helper/extension/base_extension.dart';
import 'package:groc_shopy/presentation/screens/main/main_screen.dart';
import 'package:groc_shopy/presentation/screens/profile/profile_screen.dart';
import 'package:groc_shopy/presentation/screens/auth/admin_signup_screen%20.dart';
import 'package:groc_shopy/presentation/screens/auth/login_screen.dart';
import 'package:groc_shopy/presentation/screens/auth/forgot_password_screen.dart';
import 'package:groc_shopy/presentation/screens/auth/password_reset_confirm_screen.dart';
import 'package:groc_shopy/presentation/screens/auth/set_new_password_screen.dart';
import 'package:groc_shopy/presentation/screens/auth/update_password_success_screen.dart';
import 'package:groc_shopy/presentation/screens/auth/verify_code_screen.dart';
import 'package:groc_shopy/presentation/screens/home/home_screen.dart';
import 'package:groc_shopy/presentation/screens/scan/scan_screen.dart';
import 'package:groc_shopy/presentation/screens/transaction_history/transaction_history_screen.dart';
import 'package:groc_shopy/presentation/widgets/payment_modal/payment_modal.dart';
import 'package:groc_shopy/presentation/widgets/paypal/paypal.dart';
import 'package:groc_shopy/presentation/widgets/subscription_modal/subscription_modal.dart';

import '../../presentation/screens/report/report_screen.dart';
import '../../presentation/screens/scannedItemsScreen/scanned_items_screen.dart';
import '../../presentation/screens/splash_screen/splash_screen.dart';
import '../../presentation/widgets/error_screen/error_screen.dart';
import '../../presentation/widgets/subscription_plans/subscription_plans.dart';
import 'route_observer.dart';
import 'route_path.dart';

class AppRouter {
  static final GoRouter initRoute = GoRouter(
    initialLocation: RoutePath.splashScreen.addBasePath,
    // initialLocation: RoutePath.paymentModal.addBasePath,
    // initialLocation: RoutePath.subscription.addBasePath,
    // initialLocation: RoutePath.home.addBasePath,
    // initialLocation: RoutePath.main.addBasePath,
    // initialLocation: RoutePath.report.addBasePath,
    // initialLocation: RoutePath.transactionHistory.addBasePath,
    // initialLocation: RoutePath.profile.addBasePath,
    // initialLocation: RoutePath.scan.addBasePath,
    // navigatorKey: Get.key,
    debugLogDiagnostics: true,
    routes: [
      ///======================= splash Route =======================
      GoRoute(
          name: RoutePath.subscription,
          path: RoutePath.subscription.addBasePath,
          builder: (context, state) => const SubscriptionModal()),
      GoRoute(
          name: RoutePath.paymentModal,
          path: RoutePath.paymentModal.addBasePath,
          builder: (context, state) => const PaymentModal()),
      GoRoute(
        name: RoutePath.splashScreen,
        path: RoutePath.splashScreen.addBasePath,
        builder: (context, state) => const SplashScreen(),
        // redirect: (context, state) {
        //   Future.delayed(const Duration(seconds: 1), () {
        //     AppRouter.route.replaceNamed(RoutePath.chooseRole);
        //   });
        //   return null;
        // },
      ),

      ///======================= Error Route =======================
      GoRoute(
          name: RoutePath.errorScreen,
          path: RoutePath.errorScreen.addBasePath,
          builder: (context, state) => const ErrorPage()),
      GoRoute(
        name: RoutePath.paypal,
        path: RoutePath.paypal.addBasePath,
        builder: (context, state) {
          final plan = state.extra as SubscriptionPlan?;
          if (plan == null) {
            return Scaffold(
              body: Center(child: Text('No subscription plan provided')),
            );
          }
          return PaypalPage(plan: plan);
        },
      ),

      ///======================= Auth Route =======================
      GoRoute(
        name: RoutePath.login,
        path: RoutePath.login.addBasePath,
        builder: (context, state) => LoginScreen(),
      ),

      ///======================= Sign Up Route =======================
      GoRoute(
        name: RoutePath.adminSignUp,
        path: RoutePath.adminSignUp.addBasePath,
        builder: (context, state) => const AdminSignUpScreen(),
      ),

      ///======================= Forgot Pass Route =======================
      GoRoute(
        name: RoutePath.forgotPass,
        path: RoutePath.forgotPass.addBasePath,
        builder: (context, state) => ForgotPasswordScreen(),
      ),

      ///======================= Reset Pass Confirm =======================
      GoRoute(
        name: RoutePath.resetPassConfirm,
        path: RoutePath.resetPassConfirm.addBasePath,
        builder: (context, state) => const PasswordResetConfirmScreen(),
      ),

      ///======================= Reset Pass Route =======================
      GoRoute(
        name: RoutePath.resetPass,
        path: RoutePath.resetPass.addBasePath,
        builder: (context, state) => const SetPasswordScreen(),
      ),

      ///======================= Verification Route =======================
      GoRoute(
        name: RoutePath.verification,
        path: RoutePath.verification.addBasePath,
        builder: (context, state) => const CodeVerificationScreen(),
      ),

      ///======================= Verification Success =======================
      GoRoute(
        name: RoutePath.resetPasswordSuccess,
        path: RoutePath.resetPasswordSuccess.addBasePath,
        builder: (context, state) => UpdatePasswordSuccessScreen(),
      ),

      ///======================= Transaction History =======================
      GoRoute(
        name: RoutePath.transactionHistory,
        path: RoutePath.transactionHistory.addBasePath,
        builder: (context, state) => TransactionHistoryScreen(),
      ),

      ///======================= LogIn Route =======================

      ///======================= Forgot Pass Route =======================

      ///======================= Reset Pass Route =======================

      ///======================= Verification Route =======================

      ///======================= Choose Language =======================

      /// <<<<<<<<<<<<<<======================= Worker Route =======================>>>>>>>>>>>>>>>>>>

      /// ====================  Main ====================
      GoRoute(
        name: RoutePath.main,
        path: RoutePath.main.addBasePath,
        builder: (context, state) => MainScreen(),
      ),

      /// ====================  Home ====================
      GoRoute(
        name: RoutePath.home,
        path: RoutePath.home.addBasePath,
        builder: (context, state) => HomeScreen(),
      ),

      /// ====================  Profile ====================
      GoRoute(
        name: RoutePath.profile,
        path: RoutePath.profile.addBasePath,
        builder: (context, state) => ProfileScreen(),
      ),

      /// ====================  Scan ====================
      GoRoute(
        name: RoutePath.scan,
        path: RoutePath.scan.addBasePath,
        builder: (context, state) => ScanScreen(),
      ),
      GoRoute(
        name: RoutePath.scannedItemsScreen,
        path: RoutePath.scannedItemsScreen.addBasePath,
        builder: (context, state) {
          final image = state.extra as File?;
          return ScannedItemsScreen(image: image);
        },
      ),

      /// ==================== Report ====================
      GoRoute(
        name: RoutePath.report,
        path: RoutePath.report.addBasePath,
        builder: (context, state) => ReportScreen(),
      ),

      /// ==================== Order/Worked History ====================

      /// ==================== Worker Notification ====================

      /// ========================================== Client Section =====================================

      /// ==================== Client Service ===================

      /// ==================== Subscription Packages ===================

      /// ==================== Client Service Request ===================

      /// ==================== Client Service Request ===================

      /// ==================== Terms of Use ===================

      /// ==================== Privacy Policy ===================
    ],
    observers: [routeObserver],
  );

  static GoRouter get route => initRoute;
}

// extension on String {
//   get addBasePath => null;
// }
