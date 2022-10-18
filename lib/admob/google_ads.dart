// class
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Ads {
  String testDevice = 'ca-app-pub-3940256099942544/1033173712';

  bool interstitialReady = false;

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: testDevice,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;

          _interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        },
      ),
    );
  }

  void showInterstitialAd(context,
      {List<dynamic>? dares, List<dynamic>? truth}) {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show().then((value) {
      _interstitialAd = null;
    });
  }
}
