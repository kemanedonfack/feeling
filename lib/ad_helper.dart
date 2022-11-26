import 'dart:io';

class AdHelper {

  static String homepageBanner(){
    if(Platform.isAndroid){
      return " ";
    }else{
      return "";
    }
  }

  static String fullPageAd(){
    if(Platform.isAndroid){
      return " ";
    }else{
      return "";
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return ' ';
    } else if (Platform.isIOS) {
      return '';
    } else {
      throw UnsupportedError("unsupported Platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return ' ';
    } else if (Platform.isIOS) {
      return '';
    } else {
      throw UnsupportedError("unsupported Platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return ' ';
    } else if (Platform.isIOS) {
      return '';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}