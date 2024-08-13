import 'package:anexpress/features/send_money/view/send_money_screen_container.dart';
import 'package:anexpress/features/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:anexpress/features/splash_screen/splash_screen.dart';
import 'package:anexpress/features/login/view/login_screen.dart';
import 'package:anexpress/features/privacy_policy_screen/view/privacy_policy_screen.dart';
import 'package:anexpress/features/settings_screen/settings_screen.dart';
import 'package:anexpress/features/notifications_screen/notifications_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String welcomeScreen = '/welcome_screen';
  static const String loginScreen = '/login_screen';
  static const String privacyPolicyScreen = '/privacy_policy_screen';
  static const String settingsScreen = '/settings_screen';
  static const String notificationsScreen = '/notifications_screen';
  static const String sendMoneyScreen = '/sendMoneyOneToFromScreen';

  //SendMoneyOneToFrom

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => const SplashScreen(),
    welcomeScreen: (context) => const WelcomeScreen(),
    loginScreen: (context) => const LoginScreen(),
    privacyPolicyScreen: (context) => const PrivacyPolicyScreen(),
    settingsScreen: (context) => const SettingsScreen(),
    notificationsScreen: (context) => const NotificationsScreen(),
    sendMoneyScreen: (context) => SendMoneyScreenContainer(),
  };
}
