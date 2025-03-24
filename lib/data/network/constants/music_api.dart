class MusicApis {
  MusicApis._();
   // base url
  static const String baseUrl = 'http://192.168.1.143:3000/';

  //All category list
  static const String categories = "${baseUrl}v1/user/categories/";

  //Ads Flags
  static const bool showBottomBannerAd = true;
  static const bool showBigAd = false;
}
