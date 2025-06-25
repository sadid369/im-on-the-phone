import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:groc_shopy/helper/extension/base_extension.dart';
import 'package:groc_shopy/presentation/screens/call_screens/call_received_screen.dart';
// import 'package:groc_shopy/presentation/screens/main/user_main_screen.dart';
// import 'package:groc_shopy/presentation/screens/main/admin_main_screen.dart';
import 'package:groc_shopy/presentation/screens/new_contact_screen/new_contact_screen.dart';
import 'package:groc_shopy/presentation/screens/profile/change_password_screen.dart';
import 'package:groc_shopy/presentation/screens/profile/profile_screen.dart';
import 'package:groc_shopy/presentation/screens/auth/admin_signup_screen%20.dart';
import 'package:groc_shopy/presentation/screens/auth/login_screen.dart';
import 'package:groc_shopy/presentation/screens/auth/forgot_password_screen.dart';
import 'package:groc_shopy/presentation/screens/auth/password_reset_confirm_screen.dart';
import 'package:groc_shopy/presentation/screens/auth/set_new_password_screen.dart';
import 'package:groc_shopy/presentation/screens/auth/update_password_success_screen.dart';
import 'package:groc_shopy/presentation/screens/auth/verify_code_screen.dart';
import 'package:groc_shopy/presentation/screens/home/home_screen.dart';
import 'package:groc_shopy/presentation/screens/settings/ringtone_selection_screen.dart';
import 'package:groc_shopy/presentation/screens/transaction_history/transaction_history_screen.dart';
import 'package:groc_shopy/presentation/widgets/payment_modal/payment_modal.dart';
import 'package:groc_shopy/presentation/widgets/paypal/paypal.dart';
import 'package:groc_shopy/presentation/widgets/subscription_modal/subscription_modal.dart';

import '../../presentation/screens/admin_screens/admin_setting_screen/admin_change_password_screen.dart';
import '../../presentation/screens/admin_screens/admin_setting_screen/admin_setting_screen.dart';
import '../../presentation/screens/admin_screens/admin_setting_screen/admin_update_profile_screen.dart';
import '../../presentation/screens/admin_screens/admin_setting_screen/app_configaration_screen.dart';
import '../../presentation/screens/admin_screens/admin_users/admin_user_screen.dart';
import '../../presentation/screens/call_screens/incoming_call_screen.dart';
import '../../presentation/screens/admin_screens/dashboard/dashboard_screen.dart';
import '../../presentation/screens/main/admin_nav.dart';
import '../../presentation/screens/main/user_nav.dart';
import '../../presentation/screens/profile/update_profile_screen.dart';
import '../../presentation/screens/report/report_screen.dart';
import '../../presentation/screens/scannedItemsScreen/scanned_items_screen.dart';
import '../../presentation/screens/search/search_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/splash_screen/splash_screen.dart';
import '../../presentation/widgets/error_screen/error_screen.dart';
import '../../presentation/widgets/subscription_plans/subscription_plans.dart';
import 'route_observer.dart';
import 'route_path.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _adminSettingsNavigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter? _router;

  static Widget _fadeTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  // Add this method for backward compatibility
  static void refreshRouter() {
    _router = null;
  }

  static GoRouter get route {
    _router ??= GoRouter(
      initialLocation: RoutePath.splashScreen.addBasePath,
      debugLogDiagnostics: true,
      routes: [
        ///======================= Splash Route =======================
        GoRoute(
          name: RoutePath.splashScreen,
          path: RoutePath.splashScreen.addBasePath,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const SplashScreen(),
            transitionsBuilder: _fadeTransition,
          ),
        ),

        ///======================= Error Route =======================
        GoRoute(
          name: RoutePath.errorScreen,
          path: RoutePath.errorScreen.addBasePath,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const ErrorPage(),
            transitionsBuilder: _fadeTransition,
          ),
        ),

        ///======================= Auth Routes =======================
        GoRoute(
          name: RoutePath.login,
          path: RoutePath.login.addBasePath,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: LoginScreen(),
            transitionsBuilder: _fadeTransition,
          ),
        ),
        GoRoute(
          name: RoutePath.adminSignUp,
          path: RoutePath.adminSignUp.addBasePath,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const AdminSignUpScreen(),
            transitionsBuilder: _fadeTransition,
          ),
        ),
        GoRoute(
          name: RoutePath.forgotPass,
          path: RoutePath.forgotPass.addBasePath,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: ForgotPasswordScreen(),
            transitionsBuilder: _fadeTransition,
          ),
        ),
        GoRoute(
          name: RoutePath.resetPassConfirm,
          path: RoutePath.resetPassConfirm.addBasePath,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const PasswordResetConfirmScreen(),
            transitionsBuilder: _fadeTransition,
          ),
        ),
        GoRoute(
          name: RoutePath.resetPass,
          path: RoutePath.resetPass.addBasePath,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const SetPasswordScreen(),
            transitionsBuilder: _fadeTransition,
          ),
        ),
        GoRoute(
          name: RoutePath.verification,
          path: RoutePath.verification.addBasePath,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const CodeVerificationScreen(),
            transitionsBuilder: _fadeTransition,
          ),
        ),
        GoRoute(
          name: RoutePath.resetPasswordSuccess,
          path: RoutePath.resetPasswordSuccess.addBasePath,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: UpdatePasswordSuccessScreen(),
            transitionsBuilder: _fadeTransition,
          ),
        ),

        ///======================= Other Routes =======================
        GoRoute(
          name: RoutePath.subscription,
          path: RoutePath.subscription.addBasePath,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const SubscriptionModal(),
            transitionsBuilder: _fadeTransition,
          ),
        ),
        GoRoute(
          name: RoutePath.paymentModal,
          path: RoutePath.paymentModal.addBasePath,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: const PaymentModal(),
            transitionsBuilder: _fadeTransition,
          ),
        ),
        GoRoute(
          name: RoutePath.paypal,
          path: RoutePath.paypal.addBasePath,
          pageBuilder: (context, state) {
            final plan = state.extra as SubscriptionPlan?;
            Widget child;
            if (plan == null) {
              child = const Scaffold(
                body: Center(child: Text('No subscription plan provided')),
              );
            } else {
              child = PaypalPage(plan: plan);
            }
            return CustomTransitionPage(
              key: state.pageKey,
              child: child,
              transitionsBuilder: _fadeTransition,
            );
          },
        ),
        GoRoute(
          name: RoutePath.transactionHistory,
          path: RoutePath.transactionHistory.addBasePath,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: TransactionHistoryScreen(),
            transitionsBuilder: _fadeTransition,
          ),
        ),
        GoRoute(
          name: RoutePath.scannedItemsScreen,
          path: RoutePath.scannedItemsScreen.addBasePath,
          pageBuilder: (context, state) {
            final image = state.extra as File?;
            return CustomTransitionPage(
              key: state.pageKey,
              child: ScannedItemsScreen(image: image),
              transitionsBuilder: _fadeTransition,
            );
          },
        ),
        GoRoute(
          name: RoutePath.report,
          path: RoutePath.report.addBasePath,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: ReportScreen(),
            transitionsBuilder: _fadeTransition,
          ),
        ),
        GoRoute(
          name: RoutePath.callReceivedScreen,
          path: RoutePath.callReceivedScreen.addBasePath,
          pageBuilder: (context, state) {
            final args = state.extra as Map<String, dynamic>? ?? {};
            return CustomTransitionPage(
              key: state.pageKey,
              child: CallReceivedScreen(
                callerName: args['callerName'] ?? 'Unknown',
              ),
              transitionsBuilder: _fadeTransition,
            );
          },
        ),

        ///======================= Standalone Routes =======================
        GoRoute(
          name: RoutePath.newContactScreen,
          path: RoutePath.newContactScreen.addBasePath,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: NewContactScreen(),
            transitionsBuilder: _fadeTransition,
          ),
        ),
        GoRoute(
          name: RoutePath.changePasswordScreen,
          path: RoutePath.changePasswordScreen.addBasePath,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: ChangePasswordScreen(),
            transitionsBuilder: _fadeTransition,
          ),
        ),
        GoRoute(
          name: RoutePath.ringtoneSelectionScreen,
          path: RoutePath.ringtoneSelectionScreen.addBasePath,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: RingtoneSelectionScreen(),
            transitionsBuilder: _fadeTransition,
          ),
        ),
        GoRoute(
          name: RoutePath.profile,
          path: RoutePath.profile.addBasePath,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: ProfileScreen(),
            transitionsBuilder: _fadeTransition,
          ),
        ),
        GoRoute(
          name: RoutePath.updateProfileScreen,
          path: RoutePath.updateProfileScreen.addBasePath,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: UpdateProfileScreen(),
            transitionsBuilder: _fadeTransition,
          ),
        ),
        GoRoute(
          name: RoutePath.incomingCallScreen,
          path: RoutePath.incomingCallScreen.addBasePath,
          pageBuilder: (context, state) {
            final args = state.extra as Map<String, dynamic>? ?? {};
            return CustomTransitionPage(
              key: state.pageKey,
              child: IncomingCallScreen(
                callerName: args['callerName'] ?? 'Unknown',
                time: args['time'] ?? 'Now',
                callDuration: args['callDuration'] ?? '15 sec',
              ),
              transitionsBuilder: _fadeTransition,
            );
          },
        ),

        ///======================= User Navigation Shell =======================
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return UserMainScreen(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: RoutePath.home,
                  path: RoutePath.home.addBasePath,
                  pageBuilder: (context, state) => CustomTransitionPage(
                    key: state.pageKey,
                    child: HomeScreen(),
                    transitionsBuilder: _fadeTransition,
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: RoutePath.search,
                  path: RoutePath.search.addBasePath,
                  pageBuilder: (context, state) => CustomTransitionPage(
                    key: state.pageKey,
                    child: SearchScreen(),
                    transitionsBuilder: _fadeTransition,
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: RoutePath.settings,
                  path: RoutePath.settings.addBasePath,
                  pageBuilder: (context, state) => CustomTransitionPage(
                    key: state.pageKey,
                    child: SettingsScreen(),
                    transitionsBuilder: _fadeTransition,
                  ),
                ),
              ],
            ),
          ],
        ),

        ///======================= Admin Navigation Shell =======================
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return AdminMainScreen(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: RoutePath.adminDashboard,
                  path: RoutePath.adminDashboard.addBasePath,
                  pageBuilder: (context, state) => CustomTransitionPage(
                    key: state.pageKey,
                    child: DashboardScreen(),
                    transitionsBuilder: _fadeTransition,
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  name: RoutePath.adminUser,
                  path: RoutePath.adminUser.addBasePath,
                  pageBuilder: (context, state) => CustomTransitionPage(
                    key: state.pageKey,
                    child: AdminUserScreen(),
                    transitionsBuilder: _fadeTransition,
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _adminSettingsNavigatorKey,
              routes: [
                GoRoute(
                  name: RoutePath.adminSettings,
                  path: RoutePath.adminSettings.addBasePath,
                  pageBuilder: (ctx, state) => CustomTransitionPage(
                    key: state.pageKey,
                    child: AdminSettingsScreen(),
                    transitionsBuilder: _fadeTransition,
                  ),
                  routes: [
                    GoRoute(
                      name: RoutePath.adminChangePasswordScreen,
                      path: RoutePath.adminChangePasswordScreen.addBasePath,
                      pageBuilder: (ctx, state) => CustomTransitionPage(
                        key: state.pageKey,
                        child: AdminChangePasswordScreen(),
                        transitionsBuilder: _fadeTransition,
                      ),
                    ),
                    GoRoute(
                      name: RoutePath.adminUpdateProfileScreen,
                      path: RoutePath.adminUpdateProfileScreen.addBasePath,
                      pageBuilder: (ctx, state) => CustomTransitionPage(
                        key: state.pageKey,
                        child: AdminUpdateProfileScreen(),
                        transitionsBuilder: _fadeTransition,
                      ),
                    ),
                    GoRoute(
                      name: RoutePath.appConfigurationsScreen,
                      path: RoutePath.appConfigurationsScreen.addBasePath,
                      pageBuilder: (ctx, state) => CustomTransitionPage(
                        key: state.pageKey,
                        child: AppConfigScreen(),
                        transitionsBuilder: _fadeTransition,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
      observers: [routeObserver],
    );
    return _router!;
  }
}
