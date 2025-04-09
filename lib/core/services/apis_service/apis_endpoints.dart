class ApiEndpoints {
  static const String baseUrl = 'http://localhost:5232/api/';

  // Authentication
  static const String signUp = 'auth/register';
  static const String login = 'auth/login';
  static const String forgotPassword = 'auth/forgot-password';
  static const String resetPassword = 'auth/reset-password';

  // Categories
  static const String category = 'Category';

  static const String products = 'products';
  static const String categoryList = 'category-list';
  static const String search = 'products/search';
  static const String cart = 'carts';
}
