class AppConstants {
  // TODO: Update these with your actual API URLs
  static const String baseURL = "https://vyapapp-stage-backend.tsuite.in";
  static String accessToken = "";
  static String api = "/api";
  static String version = "/v1";
  static String user = "/user";
  static String general = "/general";
  static String prefix = "$api$version";

  // Auth endpoints
  static String login = "$api/login";
  static String register = "$api/company-details";
  static String companyDetails = "$api/company-details";
  static String refreshTokenApi = "$prefix$user/token-refresh";
  static String logout = "$prefix$user/logout";

  // Profile endpoints
  static String getProfileData = "$prefix$user/profile";

  // CRUD endpoints
  static String dropdowns = "$api/dropdowns";
  static String products = "$api/products";
  static String categories = "$api/categories";
  static String customers = "$api/customers";
  static String categoriesWithProducts = "$api/categories-with-products";
  static String bills = "$api/bills";
  static String dashboard = "$api/dashboard";
  static String reports = "$api/reports";
  static const int maxImageSizeMb = 5;
}
