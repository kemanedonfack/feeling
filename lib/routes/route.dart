import 'package:flutter/material.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:feeling/screen/a_propos.dart';
import 'package:feeling/screen/centre_interet.dart';
import 'package:feeling/screen/choose_language.dart';
import 'package:feeling/screen/escort.dart';
import 'package:feeling/screen/identification.dart';
import 'package:feeling/screen/match.dart';
import 'package:feeling/screen/modifier_information.dart';
import 'package:feeling/screen/modifier_profil.dart';
import 'package:feeling/screen/photo_escort.dart';
import 'package:feeling/screen/profile_details.dart';
import 'package:feeling/screen/settings.dart';
import 'package:feeling/screen/tab.dart';
import 'package:feeling/screen/inscription.dart';
import 'package:feeling/screen/mon_sex.dart';
import 'package:feeling/screen/not_found.dart';
import 'package:feeling/screen/preference_sex.dart';
import 'package:feeling/screen/splashscreen.dart';
import 'package:feeling/screen/upload_image.dart';
import 'package:feeling/screen/verification.dart';
import 'package:feeling/screen/welcome.dart';

class AppRouter {

  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch(settings.name){
      case splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen() );
      case chooseLanguageRoute:
        return MaterialPageRoute(builder: (_) => const ChooseLanguageScreen() );
      case monSexRoute:
        return MaterialPageRoute(builder: (_) => MonSexScreen(settings.arguments as Utilisateurs) );
      case preferenceSexRoute:
        return MaterialPageRoute(builder: (_) => const PreferenceSexScreen() );
      case inscriptionRoute:
        return MaterialPageRoute(builder: (_) => InscriptionScreen(settings.arguments as Utilisateurs) );
      case verificationRoute:
        return MaterialPageRoute(builder: (_) => VerificationScreen(settings.arguments as Utilisateurs) );
      case tabRoute:
        return MaterialPageRoute(builder: (_) => const TabScreen() );
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingScreen() );
      case profildetailsRoute:
        return MaterialPageRoute(builder: (_) => ProfileDetailScreen(settings.arguments as Utilisateurs) );
      case editprofilRoute:
        return MaterialPageRoute(builder: (_) => const ModifierProfilScreen() );
      case escortinscriptionRoute:
        return MaterialPageRoute(builder: (_) => EscortInscriptionScreen(settings.arguments as Utilisateurs) );
      case photoescortRoute:
        return MaterialPageRoute(builder: (_) => PhotoEscort(settings.arguments as Utilisateurs) );
      case phoneidenficationRoute:
        return MaterialPageRoute(builder: (_) => const PhoneIdentificationScreen() );
      case uploadimageRoute:
        return MaterialPageRoute(builder: (_) => UploadImageScreen(settings.arguments as Utilisateurs) );
      case aproposRoute:
        return MaterialPageRoute(builder: (_) => AProposScreen(settings.arguments as Utilisateurs) );
      case centreinteretRoute:
        return MaterialPageRoute(builder: (_) => InteretScreen(settings.arguments as Utilisateurs) );
      case modifierinformationRoute:
        return MaterialPageRoute(builder: (_) => const ModifierInformation() );
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen() );
      case matchRoute:
        return MaterialPageRoute(builder: (_) => MatchScreen(settings.arguments as Utilisateurs) );
    }

    return MaterialPageRoute(builder: (_) => const NotFoundScreen() );

  }

}



