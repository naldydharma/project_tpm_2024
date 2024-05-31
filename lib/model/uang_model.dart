enum Currency {
  IDR, // Indonesian Rupiah
  MYR, // Malaysian Ringgit
  USD, // US Dollar
}

class CurrencyConversionModel {
  final Currency fromCurrency;
  final Currency toCurrency;
  final double amount;

  CurrencyConversionModel({
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
  });

  // Method to perform currency conversion
  double convert() {
    double rate = _getConversionRate(fromCurrency, toCurrency);
    return amount * rate;
  }

  double _getConversionRate(Currency from, Currency to) {
    Map<Currency, Map<Currency, double>> rates = {
      Currency.USD: {Currency.IDR: 14500, Currency.MYR: 4.1, Currency.USD: 1.0},
      Currency.IDR: {Currency.USD: 0.000069, Currency.MYR: 0.00028, Currency.IDR: 1.0},
      Currency.MYR: {Currency.USD: 0.24, Currency.IDR: 3548, Currency.MYR: 1.0},
    };

    return rates[from]?[to] ?? 1.0;
  }
}