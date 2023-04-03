enum PlatformType {
  android,
  ios,
}

/// This enum is used to store the ad types.
enum AdsType {
  interstitial,
  homeFooterBanner,
  profileFooterBanner,
  premiumFooterBanner,
  quranNavFooterBanner,
  quranFooterBanner,
  quranAudioFooterBanner,
  settingsScreenBanner,
  quranAudioSettingsBanner
}

/// This class is used to store the ad unit ids for each ad type.
class AdsVariables {
  static final adUnitIds = {
    /// Interstitial Ad Unit Id
    AdsType.interstitial: {
      PlatformType.android: 'your ads unit id',
      PlatformType.ios: 'your ads unit id',
    },

    /// Home Footer Banner Ad Unit Id
    AdsType.homeFooterBanner: {
      PlatformType.android: 'your ads unit id',
      PlatformType.ios: 'your ads unit id',
    },

    /// Profile Footer Banner Ad Unit Id
    AdsType.profileFooterBanner: {
      PlatformType.android: 'your ads unit id',
      PlatformType.ios: 'your ads unit id',
    },

    /// Premium Footer Banner Ad Unit Id
    AdsType.premiumFooterBanner: {
      PlatformType.android: 'your ads unit id',
      PlatformType.ios: 'your ads unit id',
    },

    /// Quran Nav Footer Banner Ad Unit Id
    AdsType.quranNavFooterBanner: {
      PlatformType.android: 'your ads unit id',
      PlatformType.ios: 'your ads unit id',
    },

    /// Quran Footer Banner Ad Unit Id
    AdsType.quranFooterBanner: {
      PlatformType.android: 'your ads unit id',
      PlatformType.ios: 'your ads unit id',
    },

    /// Quran Audio Footer Banner Ad Unit Id
    AdsType.quranAudioFooterBanner: {
      PlatformType.android: 'your ads unit id',
      PlatformType.ios: 'your ads unit id',
    },

    /// Audio Settings Screen Banner Ad Unit Id
    AdsType.quranAudioSettingsBanner: {
      PlatformType.android: 'your ads unit id',
      PlatformType.ios: 'your ads unit id',
    },

    /// Settings Screen Banner Ad Unit Id
    AdsType.settingsScreenBanner: {
      PlatformType.android: 'your ads unit id',
      PlatformType.ios: 'your ads unit id',
    },
  };
}
