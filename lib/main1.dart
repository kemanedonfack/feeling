import 'package:feeling/controllers/google_login_controller.dart';
import 'package:feeling/controllers/notification_controller.dart';
import 'package:feeling/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feeling/utile/couleur.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'add.dart';
import 'banner.dart';
import 'controllers/facebook._login_controller.dart';
import 'facebook_login.dart';
import 'localization/Demolocalisation.dart';
import 'localization/language_constants.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// If you're going to use other Firebase services in the background, such as Firestore,
// make sure you call `initializeApp` before using other Firebase services.
// await Firebase.initializeApp();
    NotificationController.display(message);
  // if (kDebugMode) {
  //   print('Background message ${message.messageId}');
  // }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  NotificationController.initializeLocalNotification();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp]
  ).then((_) {
      runApp(MyApp());
  });
  
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        
      ],
      child: MaterialApp(
        title: 'Feeling',
        theme: ThemeData(
          fontFamily: 'San Francisco',
          primarySwatch: primary,
        ),
        
        home: const FacebookLoginPage(),
        // onGenerateRoute: AppRouter.allRoutes,
        // initialRoute: splashRoute,
        // debugShowCheckedModeBanner: false,
      ),
    );
  }
}


