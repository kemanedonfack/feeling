import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feeling/routes/route.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:feeling/utile/couleur.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp]
  ).then((_) {
      runApp(MyApp());
  });
  
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feeling',
      theme: ThemeData(
        fontFamily: 'San Francisco',
        primarySwatch: primary,
      ),
      // home: Tinder(),
      onGenerateRoute: AppRouter.allRoutes,
      initialRoute: splashRoute,
      debugShowCheckedModeBanner: false,
    );
  }
   
}

