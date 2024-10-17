import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class InterstitialAdHelper {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;
  bool loading = false;

  Future<void> loadInterstitialAd()async {
    Completer<void> adLoadCompleter = Completer();
    loading = true;
    InterstitialAd.load(
      // adUnitId: 'ca-app-pub-3940256099942544/1033173712', // Replace with your Interstitial Ad Unit ID
      adUnitId: 'ca-app-pub-8480119277588398/4635339846', // Replace with your Interstitial Ad Unit ID
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _isAdLoaded = true;
          loading =false;
          print("Interstitial Ad Loaded");
          adLoadCompleter.complete();
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('Failed to load interstitial ad: ${error.message}');
          _isAdLoaded = false;
          loading =false;
          adLoadCompleter.completeError(error);
        },
      ),
    );
    return await adLoadCompleter.future;
  }
  bool get getLoadedAdd =>   _isAdLoaded  && _interstitialAd != null;

  void showInterstitialAd(Function onAdDismissed) {
    if (_isAdLoaded && _interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdWillDismissFullScreenContent: (ad) {

          log('on dismiss..................................');
        },
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          // ad.dispose();
          log("Interstitial Ad dismissed......................");
          // _isAdLoaded = false;
          // onAdDismissed(); // Callback after the ad is dismissed

        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          log('...............Failed to show interstitial ad: ${error.message}');
          ad.dispose();
          _isAdLoaded = false;
          onAdDismissed(); // Proceed to the next screen even if ad fails to show

        },
      );

      // Show the ad
      _interstitialAd!.show().then((value) {
        _interstitialAd = null;
      },);

      //_isAdLoaded = false;
    } else {
      log('Interstitial ad is not ready yet');
      onAdDismissed(); // Proceed to the next screen if the ad is not ready
    }
  }

  bool isAdLoaded() {
    return _isAdLoaded;
  }
}
