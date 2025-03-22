class VideoApis {
  //Base url
  static const String baseUrl = "http://aditetechnologies.com/";

  //Home page category api
  static const String homePageCategory = "${baseUrl}VideoApp/api/v1/get_home";

  //All category list
  static const String categories = "${baseUrl}VideoApp/api/v1/get_category";

  //Fetch category vice video items
  static const String videoItem =
      "${baseUrl}VideoApp/api/v1/get_item_by_cat_id";

  //Search video item data
  static const String searchUrl = "${baseUrl}VideoApp/api/v1/search_song";

  //AboutUs Page Url
  static const String aboutUs = "${baseUrl}VideoApp/api/v1/get_about_us";

  //FCM ID && Device Token
  static const String apiFCM =
      "${baseUrl}VideoApp/api/v1/gcm_register?gcm_id&device_id";

  //Ads Flags
  static const bool showBottomBannerAd = true;
  static const bool showBigAd = false;
}
