import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class Add extends StatefulWidget {
  const Add({ Key? key }) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {

  late BannerAd staticAd;
  bool staticAdLoaded = false;

  late BannerAd inilineAd;
  bool inilineAdLoaded = false;

  static const AdRequest request = AdRequest();

  void loadStaticBannerAd(){
    staticAd = BannerAd(
      adUnitId: " ",
      size: AdSize.banner,
      request: request,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            staticAdLoaded = true;
          });
        }, 
        onAdFailedToLoad: (ad, error) {
          print("erreur static banner ${error.message}");
          // _isBannerAdReady = false;
          ad.dispose();
        }
      ),
    );

    staticAd.load();

  }

  void loadInilineBannerAd(){
    inilineAd = BannerAd(
      adUnitId: " ",
      size: AdSize.banner,
      request: request,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            inilineAdLoaded = true;
          });
        }, 
        onAdFailedToLoad: (ad, error) {
          print("erreur inline banner ${error.message}");
          // _isBannerAdReady = false;
          ad.dispose();
        }
      ),
    );

    inilineAd.load();

  }

  @override
  void initState() {
    loadStaticBannerAd();
    loadInilineBannerAd();
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("add"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if(staticAdLoaded)
                Container(
                  child: AdWidget(ad: staticAd),
                  width: staticAd.size.width.toDouble(),
                  height: staticAd.size.height.toDouble(),
                  alignment: Alignment.bottomCenter,
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {  },
                      child: const Text('show inters ad')
                    ),
                    ElevatedButton(
                      onPressed: () {  },
                      child: const Text('show reward ad')
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                SizedBox(
                  height: MediaQuery.of(context).size.height-300,
                  child: ListView.builder(
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      if(inilineAdLoaded && index == 5){
                        return Column(
                          children: [
                            Container(
                              child: AdWidget(ad: inilineAd),
                              width: inilineAd.size.width.toDouble(),
                              height: inilineAd.size.height.toDouble(),
                              alignment: Alignment.bottomCenter,
                            ),
                            const SizedBox(height: 20,),
                          ],
                        );
                      }else{
                        return ListTile(
                          title: Text("Element $index"),
                          leading: const Icon(Icons.star),
                        );
                      }
                      
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}