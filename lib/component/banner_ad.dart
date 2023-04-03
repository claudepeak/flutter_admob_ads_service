import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  final String adUnitId;
  final AdSize? size;
  final bool? isPremiumUser;
  const BannerAdWidget({super.key, required this.adUnitId, this.size, this.isPremiumUser});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late BannerAd? _bannerAd;

  void createBannerAd() {
    if (widget.isPremiumUser != null && widget.isPremiumUser == true) return;

    _bannerAd = BannerAd(
      adUnitId: widget.adUnitId,
      size: widget.size ?? AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) => debugPrint('${ad.runtimeType} loaded.'),
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint('${ad.runtimeType} failed to load: $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => debugPrint('${ad.runtimeType} opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) {
          debugPrint('${ad.runtimeType} closed');
          ad.dispose();
          createBannerAd();
          debugPrint('${ad.runtimeType} reloaded');
        },
        // Called when an ad is in the process of leaving the application.
        onAdWillDismissScreen: (ad) => debugPrint('${ad.runtimeType} will dismiss.'),
      ),
    )..load();
  }

  @override
  void initState() {
    super.initState();
    createBannerAd();
  }

  @override
  void dispose() {
    if (widget.isPremiumUser != null) _bannerAd!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isPremiumUser != null && widget.isPremiumUser == true
        ? const SizedBox.shrink()
        : SizedBox(
            width: _bannerAd!.size.width.toDouble(),
            height: _bannerAd!.size.height.toDouble(),
            child: AdWidget(ad: _bannerAd!),
          );
  }
}
