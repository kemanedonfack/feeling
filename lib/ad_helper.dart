import 'dart:io';

class AdHelper {

  static String homepageBanner(){
    if(Platform.isAndroid){
      return "ca-app-pub-5780597516233270/7057324798";
    }else{
      return "";
    }
  }

  static String fullPageAd(){
    if(Platform.isAndroid){
      return "ca-app-pub-5780597516233270/6554244996";
    }else{
      return "";
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5780597516233270/7057324798';
    } else if (Platform.isIOS) {
      return '';
    } else {
      throw UnsupportedError("unsupported Platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5780597516233270/6554244996';
    } else if (Platform.isIOS) {
      return '';
    } else {
      throw UnsupportedError("unsupported Platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-5780597516233270/6864649451';
    } else if (Platform.isIOS) {
      return '';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}