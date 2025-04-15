class ApiEndpoints {
  // Base URL for the API
  static const String baseUrl = 'http://localhost:5232/api/';

  // Token for authentication
  static String token = '';

  // Authentication
  static const String signUp = 'auth/register';
  static const String login = 'auth/login';
  static const String forgotPassword = 'auth/forgot-password';
  static const String resetPassword = 'auth/reset-password';
  static const String refreshToken = 'auth/refresh';

  // Categories
  static const String category = 'Category';
}
