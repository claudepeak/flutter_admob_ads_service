import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'data_model/ads_model.dart';

class AdsService {
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  static const int maxFailedLoadAttempts = 3;

  /// Get Interstitial Ad Unit Id
  static String getInterstitialAdUnitId() {
    if (Platform.isAndroid) {
      return AdsVariables.adUnitIds[AdsType.interstitial]![PlatformType.android]!;
    } else if (Platform.isIOS) {
      return AdsVariables.adUnitIds[AdsType.interstitial]![PlatformType.ios]!;
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  /// Create Interstitial Ad
  Future<void> createInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: getInterstitialAdUnitId(),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          debugPrint('$ad loaded');
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error.');
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            createInterstitialAd();
          }
        },
      ),
    );
  }

  /// Show Interstitial Ad
  Future<void> showInterstitialAd([bool? isPremium]) async {
    if (isPremium != null && isPremium) return;

    /// Create Interstitial Ad
    // ignore: prefer-async-await
    await createInterstitialAd().then((value) {
      _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) => debugPrint('ad onAdShowedFullScreenContent.'),
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          debugPrint('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
          createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
          createInterstitialAd();
        },
      );
    });

    /// Show Interstitial Ad
    await Future.delayed(const Duration(seconds: 1), () {
      if (_interstitialAd != null) {
        _interstitialAd!.show();
      } else {
        debugPrint('Warning: attempt to show interstitial before loaded.');
      }
    });
  }
}
