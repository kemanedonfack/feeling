import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feeling/routes/route.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:feeling/utile/couleur.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// // If you're going to use other Firebase services in the background, such as Firestore,
// // make sure you call `initializeApp` before using other Firebase services.
// // await Firebase.initializeApp();
//   print('Background message ${message.messageId}');
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp]
  ).then((_) {
      runApp(const MyApp());
  });
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feeling',
      theme: ThemeData(
        fontFamily: 'San Francisco',
        primarySwatch: primary,
      ),
      // home: LocationScreen(),
      onGenerateRoute: AppRouter.allRoutes,
      initialRoute: splashRoute,
      debugShowCheckedModeBanner: false,
    );
  }
   
}


