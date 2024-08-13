import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:anexpress/exports/core_export.dart';
import 'package:anexpress/firebase_options.dart';
import 'package:device_preview/device_preview.dart';
import 'package:anexpress/app.dart';
import 'package:anexpress/core/config/locator.dart';
import 'package:anexpress/core/controllers/localization_controller.dart';
import 'package:anexpress/core/controllers/theme_controller.dart';
import 'package:anexpress/core/ui/setup_dialog_ui.dart';
import 'package:anexpress/core/ui/setup_snackbar_ui.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Get.putAsync<Loc>(() => Loc().init(), permanent: true);

  await Get.putAsync<ThemeController>(() => ThemeController.init(),
      permanent: true);

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

// status bar color setup
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: AppColors.primaryDark,
  ));

  ///  calling dependencies setting for get_it
  setupLocator();
  //
  setupSnackbarUi();
  //
  setupDialogUi();

  //
  const String sentryDsn =
      'https://54b8c915a0d14e5ebb6f4387745bf1d5@o1320538.ingest.sentry.io/6576781';

  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  // NOTE: Replace with your own app ID from https://www.onesignal.com
  await OneSignal.shared.setAppId("90fb6d3b-f3e8-44f0-bfc4-b46b02935573");

  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    "permission accepted".log();
  });
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("tempTwoFaStatus");

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (value) async {
      await SentryFlutter.init(
        (options) {
          options.dsn = sentryDsn;
          options.tracesSampleRate = 1.0;
        },
        appRunner: () => runApp(
          DevicePreview(
            enabled: false,
            builder: (context) => const MyApp(), // Wrap your app
          ),
        ),
      );
    },
  );
}
