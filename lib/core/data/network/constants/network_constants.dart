class NetworkConstants {
  NetworkConstants._();

  // base url
  static const String baseUrl = 'http://192.168.1.143:3000/';

  //All category list
  static const String categories = "${baseUrl}v1/user/categories/";
  
  //All subCategory list
  static const String subCategories = "${baseUrl}v1/user/subcategories/";
  
}