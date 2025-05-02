import 'package:intl/intl.dart';

extension CurrencyStringExtension on String {
  String toCurrencyString({
    String locale = 'en_US',
    String? symbol,
    int decimalDigits = 2,
  }) {
    final number = double.tryParse(replaceAll(',', ''));
    // Return the original string if parsing fails
    if (number == null) return this;

    final format = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return format.format(number);
  }
}

// print('1000'.toCurrencyString()); // Output: $1,000.00
// print('1300000'.toCurrencyString(symbol: '£')); // Output: £1,300,000.00
// print('1005000'.toCurrencyString(locale: 'de_DE', symbol: '€')); // Output: 1.005.000,00 €
