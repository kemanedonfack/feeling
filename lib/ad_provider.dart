import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_helper.dart';

class AdProvider {

    bool isHomePageBannerLoader = false;
    late BannerAd homePageBanner;
    
    bool isFullPageLoad = false;
    late InterstitialAd FullPageAd;

  void intializeHomePageBanner() async {
    homePageBanner = BannerAd(adUnitId: AdHelper.homepageBanner(),
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          print("home page banner load");
          isHomePageBannerLoader = true;
        },
        onAdClosed: (ad){
          isHomePageBannerLoader = false;
          ad.dispose();
        },
        onAdFailedToLoad: (ad, error) {
          print("Failed to Load A Banner Ad${error.message}");
          isHomePageBannerLoader = false;
          ad.dispose();
        }),      
    );
    await homePageBanner.load();
  }

  void intializeFullPageAd() async {
    await InterstitialAd.load(
      adUnitId: AdHelper.fullPageAd(),
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print("full page at loaded");
          FullPageAd = ad;
          isFullPageLoad = true;
        }, 
        onAdFailedToLoad: (err){          
          print("erreur ${err.toString()}");
          isFullPageLoad = false;

        }
      )
    );

  }

} 