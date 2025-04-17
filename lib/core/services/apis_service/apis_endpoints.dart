class ApiEndpoints {
  // Base URL for the API
  static const String baseUrl = 'http://localhost:5232/api/';
  static const String imageUrl = 'http://localhost:5232/';

  // Token for authentication
  static String? accessToken;
  static String? refreshToken;

  // Authentication
  static const String signUp = 'auth/register';
  static const String login = 'auth/login';
  static const String forgotPassword = 'auth/forgot-password';
  static const String resetPassword = 'auth/reset-password';
  static const String refresh = 'auth/refresh';

  // Profile
  static const String profile = 'user/profile';
  static const String updateProfileImage = 'user/update-profile-image';

  // Categories
  static const String category = 'Category';

  // Products
  static const String product = 'Products';
  static const String productAddReview = 'Products/add-review';
}
