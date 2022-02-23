import 'package:feeling/screen/localisation.dart';
import 'package:feeling/screen/tab/chat_details.dart';
import 'package:feeling/screen/update_centre_interet.dart';
import 'package:feeling/utile/custom_transition.dart';
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

import '../screen/modifier_pays.dart';

class AppRouter {

  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch(settings.name){
      case splashRoute:
        return CustomPageRoute(child: const SplashScreen() );
      case chooseLanguageRoute:
        return CustomPageRoute(child: const ChooseLanguageScreen() );
      case monSexRoute:
        return CustomPageRoute(child: MonSexScreen(settings.arguments as Utilisateurs) );
      case preferenceSexRoute:
        return CustomPageRoute(child: const PreferenceSexScreen() );
      case inscriptionRoute:
        return CustomPageRoute(child: InscriptionScreen(settings.arguments as Utilisateurs) );
      case verificationRoute:
        return CustomPageRoute(child: VerificationScreen(settings.arguments as Utilisateurs) );
      case tabRoute:
        return CustomPageRoute(child: const TabScreen() );
      case settingsRoute:
        return CustomPageRoute(child: const SettingScreen() );
      case profildetailsRoute:
        return CustomPageRoute(child: ProfileDetailScreen(settings.arguments as Utilisateurs) );
      case editprofilRoute:
        return CustomPageRoute(child: ModifierProfilScreen(settings.arguments as Utilisateurs) );
      case escortinscriptionRoute:
        return CustomPageRoute(child: EscortInscriptionScreen(settings.arguments as Utilisateurs) );
      case photoescortRoute:
        return CustomPageRoute(child: PhotoEscort(settings.arguments as Utilisateurs) );
      case phoneidenficationRoute:
        return CustomPageRoute(child:  const PhoneIdentificationScreen(), direction: AxisDirection.left );
      case uploadimageRoute:
        return CustomPageRoute(child: UploadImageScreen(settings.arguments as Utilisateurs) );
      case aproposRoute:
        return CustomPageRoute(child: AProposScreen(settings.arguments as Utilisateurs) );
      case centreinteretRoute:
        return CustomPageRoute(child: InteretScreen(settings.arguments as Utilisateurs) );
      case modifierinformationRoute:
        return CustomPageRoute(child: const ModifierInformation() );
      case welcomeRoute:
        return CustomPageRoute(child: const WelcomeScreen() );
      case matchRoute:
        return CustomPageRoute(child: MatchScreen(settings.arguments as Utilisateurs) );
      case chatDetailsRoute:
        return CustomPageRoute(child: ChatDetailScreen(settings.arguments as Utilisateurs) );
      case locationRoute:
        return CustomPageRoute(child: LocationScreen(settings.arguments as Utilisateurs) );
      case updateInteretRoute:
        return CustomPageRoute(child: UpdateInteretScreen(settings.arguments as Utilisateurs) );
      case updateCountryRoute:
        return CustomPageRoute(child: UpdateCountryScreen(settings.arguments as Utilisateurs) );
    }

    return CustomPageRoute(child: const NotFoundScreen() );

  }

}



