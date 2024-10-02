// ignore_for_file: depend_on_referenced_packages, deprecated_member_use

import 'dart:async';

import 'package:nyumbayo_app/tools/Reload.dart';

import 'Observers/IntervalObserver.dart';
import 'controllers/PowerBillController.dart';
import 'firebase_options.dart';
import 'exports/exports.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      // statusBarColor: Colors.transparent,
      // statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black12,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('android12splash');
  // iOS settings
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();

  // initialization settings for both Android and iOS
  InitializationSettings initializationSettings = const InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin);

  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {});

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // firebase messaging
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onMessage.listen((event) {});

  // end of firebase messaging
  Timer.periodic(const Duration(seconds: 7), (timer) {
    // sendNotification();  Maurice256
  });
  Bloc.observer = const Observer();
  runApp(
    ReloadApp(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => UserdataController()),
          BlocProvider(create: (_) => AmountController()),
          BlocProvider(create: (_) => TenantController()),
          BlocProvider(create: (_) => PowerStatusController()),
          BlocProvider(create: (_) => PowerBillController()),
          ChangeNotifierProvider(create: (_) => MainController()),
        ],
        child: Builder(builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.splash,
            theme: ThemeData().copyWith(
              appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue.shade700,
              ),
              // useMaterial3: true,
              textTheme:
                  GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                      .apply(
                bodyColor: ThemeData().brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                displayColor: ThemeData().brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            routes: Routes.routes,
          );
        }),
      ),
    ),
  );
}
